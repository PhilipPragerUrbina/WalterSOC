#pragma once
#include <queue>

// Register the next expected output for a simulation and compare it to the actual next output
// ResultType is the struct representing the output interface of the simulation
template<typename ResultType> class ScoreBoard{
    private:
        std::queue<ResultType> expected_outputs;
    public:

        // Add an expected output
        void registerExpectedOutput(ResultType expected_output){
            expected_outputs.push(expected_output);
        }

        // Add an acual input
        // If the actual input is not the same as the expected input, print an error and exit
        void registerActualOutput(ResultType actual_output){
            if(expected_outputs.empty()){
                std::cout << "Test Failed: Received unexpected output: " << actual_output << "\n";
                exit(1);
            }
            if(expected_outputs.front() != actual_output){
                std::cout << "Test Failed: Expected output: " << expected_outputs.front() << " but received: " << actual_output << "\n";
                exit(1);
            }
            expected_outputs.pop();
            std::cout << "Test Passed: Received expected output: " << actual_output << "\n";
        }

        // If there are any expected outputs left after simulation ends, print an error and exit
        ~ScoreBoard(){
            if(!expected_outputs.empty()){
                std::cout << "Test Failed: Expected output: " << expected_outputs.front() << " but received no output\n";
                exit(1);
            }
        }
};

//Interface for testing
/*
    Usage:
    1. Create a struct that represents the input and output interface of the simulation using verilator types.
    2. Create a class that inherits from TestGenerator. This class should implement the generateTestCase() method.
    3. In the simulation loop, getNextTest() and drive the inputs of the simulation with it.
    4. After the output is ready(After n clocks, or when flag is set), call reportResult() with the output of the simulation.
    5. Repeat steps 3 and 4 until the simulation ends.
*/
template<typename StimulusType, typename ResultType> class TestGenerator{
    private:
        ScoreBoard<ResultType> scoreboard;
    protected:

        struct TestCase{
            StimulusType stimulus;
            ResultType expected_result;
        };

        //Generate a random or get next pre-defined test case
        virtual TestCase generateTestCase() = 0;

    public:
        StimulusType getNextTest(){
            TestCase test_case = generateTestCase();
            scoreboard.registerExpectedOutput(test_case.expected_result);
            return test_case.stimulus;
        }

        void reportResult(ResultType result){
            scoreboard.registerActualOutput(result);
        }
};