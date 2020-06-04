`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Emmanuel Francis
// Create Date: 04.06.2020 21:44:25
// Module Name: Debounce
// Project Name: YODA
// Description: Debounce module for Smoothing Filter
//////////////////////////////////////////////////////////////////////////////////


module Debounce(
    input clk,		//input clock
    input button,  //input reset signal (external button)
    output reg Flag //output reset signal (delayed)
    );
    
    reg previous_state;
    reg [21:0] count; //assume count is null on FPGA configuration

    always @(posedge clk) begin  	//activates every clock edge
        
        if (button && button != previous_state && &count) begin		// reset block
            Flag <= 1'b1;// reset the output to 1
            count <= 0;
            previous_state <= 1;
        end // if button && button != previous_state && &count
        else begin 
            if (button && button != previous_state) begin
                Flag <= 1'b0;
                count <= count + 1'b1;
            end //end if button && button != previous_state
            else begin
                Flag <= 1'b0;
                previous_state <= button;
            end //end else button && button != previous_state
        
        end// end else button && button != previous_state && &count
    end //@ always posedge clk
        
endmodule
