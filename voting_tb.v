`timescale 1ns / 1ps

module voting_tb;

    reg clk;
    reg rst;
    reg i_candidate_1;
    reg i_candidate_2;
    reg i_candidate_3;
    reg i_voting_over;

    wire [31:0] o_count1;
    wire [31:0] o_count2;
    wire [31:0] o_count3;

    // Instantiate the voting machine
    voting_machine uut (
        .clk(clk),
        .rst(rst),
        .i_candidate_1(i_candidate_1),
        .i_candidate_2(i_candidate_2),
        .i_candidate_3(i_candidate_3),
        .i_voting_over(i_voting_over),
        .o_count1(o_count1),
        .o_count2(o_count2),
        .o_count3(o_count3)
    );

    // Generate clock
    always #5 clk = ~clk;

    initial begin
        $dumpfile("voting.vcd");
        $dumpvars(0, voting_tb);

        clk = 0;
        rst = 1;
        i_candidate_1 = 1;
        i_candidate_2 = 1;
        i_candidate_3 = 1;
        i_voting_over = 0;

        #10 rst = 0;

        // Simulate a vote for candidate 1
        #10 i_candidate_1 = 0;
        #10 i_candidate_1 = 1;

        // Simulate a vote for candidate 2
        #20 i_candidate_2 = 0;
        #10 i_candidate_2 = 1;

        // Simulate a vote for candidate 3
        #20 i_candidate_3 = 0;
        #10 i_candidate_3 = 1;

        // Finish voting
        #50 i_voting_over = 1;

        #20 i_voting_over = 0;

        #20 $display("Vote counts - C1: %d, C2: %d, C3: %d", o_count1, o_count2, o_count3);
        #10 $finish;
    end
endmodule
