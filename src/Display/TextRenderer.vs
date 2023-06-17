//Renders text from a buffer
module TextRenderer # (
    parameter BUFFER_SIZE = 256, //Size of the text buffer
    parameter LINE_WIDTH = 16, //Number of characters per line
    parameter logic [11:0] COLOR = {4'h3,4'h3,4'h3}, //RGB 12 bit Color of the text

    parameter FONT_WIDTH = 8, //Width of the font in pixels
    parameter FONT_HEIGHT = 8, //Height of the font in pixels
    parameter FONT_CHARACTERS = 256 //Number of characters in the font

    //todo custom font with different sizes
    //todo custom background color
)
(
    input logic dot_clk, //Screen clock
    input logic data_enable, //Screen data enable
    input logic new_frame, //Screen new frame
    input logic new_line, //Screen new line

    input logic [$clog2(BUFFER_SIZE)-1:0] buffer_write_address, // Address to write to in character buffer
    input logic [7 : 0] buffer_write_data, // Data to write to character buffer
    input logic buffer_write_enable, // Enable writing to character buffer
    input logic buffer_clk, //Clock for the character buffer

    //color output
    output logic [3:0] red, 
    output logic [3:0] green,
    output logic [3:0] blue
);

logic [$clog2(BUFFER_SIZE)-1:0] character_address;
logic [7 : 0] character;

logic [$clog2(FONT_CHARACTERS*FONT_HEIGHT)-1:0] font_bitmap_address;
logic [FONT_WIDTH-1 : 0] font_bitmap_data;

logic [$clog2(BUFFER_SIZE/LINE_WIDTH)-1:0] line_number;
logic [$clog2(LINE_WIDTH)-1:0] character_number;

logic [$clog2(FONT_WIDTH)-1:0] font_x;
logic [$clog2(FONT_HEIGHT)-1:0] font_y;

//Handle screen events
always_ff @(posedge dot_clk) begin
    if(new_frame) begin
        font_x <= 0;
        font_y <= 0;
        line_number <= 0;
        character_number <= 0;
    end else if(data_enable) begin
        if(new_line) begin
            font_x <= 0;
            font_y <= font_y + 1;
            character_number <= 0;
        end else begin
            font_x <= font_x + 1;
        end
        if(font_x == (FONT_WIDTH-1)) begin
            font_x <= 0;
            character_number <= character_number + 1;
        end
        if(font_y == (FONT_HEIGHT-1)) begin
            font_y <= 0;
            line_number <= line_number + 1;
        end
    end
end

//Calculate addresses
always_ff @(posedge dot_clk) begin
    character_address <= line_number * LINE_WIDTH + character_number;
    font_bitmap_address <= character * FONT_HEIGHT + font_y ;
end

//Render character
always_ff @(posedge dot_clk) begin
    if(data_enable && font_bitmap_data[4-font_x]) begin
            red <= COLOR[11:8];
            green <= COLOR[7:4];
            blue <= COLOR[3:0];
            
    end else begin
        red <= 0;
        green <= 0;
        blue <= 0;
    end
end


DualPortBRAM  # (
    .DATA_WIDTH(8),
    .DEPTH(BUFFER_SIZE),
    .INITITIAL_VALUE(8'h0020) //space character
) buffer
(
    .address_read(character_address), 
    .clk_read(dot_clk),
    .read_data(character),

    .address_write(buffer_write_address),
    .clk_write(buffer_clk),
    .write_data(buffer_write_data),
    .write_enable(buffer_write_enable)
);

ROM # (
    .DATA_WIDTH(FONT_WIDTH),
    .DEPTH(FONT_CHARACTERS*FONT_HEIGHT),
    .INIT_FILE("resources/bitmaps/unscii-8.hex") //unicode font cut off at 256 characters
) font (
    .address(font_bitmap_address),
    .data(font_bitmap_data),
    .clk(dot_clk)
);

endmodule;