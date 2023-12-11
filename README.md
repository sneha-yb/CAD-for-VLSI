# CAD-for-VLSI
**PIPELINED FAST 64 BIT SIGNED INTEGER DIVIDER**

We tried to implement the signed 64 bit integer divider using the SRT Radix-4 division algotithm.

**DESIGN**

SRT Radix-4 Division Algorithm: The SRT (Signed-Residue-to-True) Radix-4 algorithm is a high-performance method for dividing two signed integers. It leverages parallelism and is particularly well-suited for pipelined architectures. Below is a detailed explanation of the algorithm along with relevant formulas.

Algorithm Steps:

1. Initialization:
   - Load the dividend (A) and divisor (B) into registers.
   - Initialize quotient (Q) and partial remainder (P) registers.

2. Iteration:
   - The division process is divided into iterative steps, each executed in a clock cycle.
   - In each step, a quotient digit (q) is determined based on a portion of the partial remainder (P) and the most significant bits (MSBs) of the divisor (B).
   - Adjust the partial remainder and update the quotient registers.

3. Parallel Processing:
   - Radix-4 exploits parallelism by dividing the quotient digits into groups of four.
   - The parallel nature allows for multiple quotient digits to be computed simultaneously, reducing the number of iterative steps.

4. Special Cases Handling:
   - The algorithm incorporates checks for special cases, including division by zero, overflow conditions, and scenarios where the divisor or dividend is 1.
   - Special handling ensures the stability and correctness of the division process.

Formulas:
1. Quotient Digit Calculation:
   - The formula for determining the quotient digit (q) in each step is based on the MSBs of the divisor and a portion of the partial remainder. There are 8 cases, an example of the first case is below:

      'b1000:begin
     
          if(-12<=div && div<=-7)begin q = 2; q_sign =1; end
          else if(-6<=div && div<=-3)begin q = 1; q_sign =1; end
          else if(-2<=div && div<=1)begin q = 0; q_sign =0; end
          else if(2<=div && div<=5)begin q = 1; q_sign =0; end
          else if(6<=div && div<=11)begin q = 2; q_sign =0; end
     end

   - This formula is customized for each group of four MSBs of the divisor.

2. Partial Remainder and Quotient Update:
   - The partial remainder and quotient registers are updated based on the chosen quotient digit (q).
   -<img width="565" alt="Screenshot 2023-12-10 at 11 08 58 AM" src="https://github.com/sneha-yb/CAD-for-VLSI/assets/113349234/fcecfd83-dbc2-49b6-b268-173c84f55086">

3. Special Case Handling:
   - Special cases are checked to handle scenarios like division by zero, overflow, and equality of divisor and dividend.

Benefits of choosing the above algorithm:
   - The parallel nature of the algorithm is beneficial for pipelined architectures, reducing latency and improving throughput.
   - Efficient handling of special cases ensures the reliability of the division process in diverse scenarios.

**TESTING/VERIFICATION OVERVIEW**

Verification for the SRT Radix-4 Divider includes rigorous functional testing with known inputs, thorough examination of special cases, such as division by zero and overflow conditions, validation for both signed and unsigned scenarios, and verification of the termination mechanism through testing the flush mechanism. 

All the commands are executed using the Bluespec's bsc compiler, the step by step command is as follows:


bsc -verilog srt_radix4_divider_64.bsv

bsc -verilog tb_srt_radix4_divider_64.bsv

bsc -o sim -e mk_tb_srt_radix4_divider_64 mk_tb_srt_radix4_divider_64.v

./sim

The results obtained are as follows:
![WhatsApp Image 2023-12-10 at 10 31 38 AM](https://github.com/sneha-yb/CAD-for-VLSI/assets/113349234/09ead119-e6a0-4a04-ab6e-7ab8c7d41f6f)

**PHYSICAL DESIGN/SYNTHESIS**

YOSYS tool is used to perform the synthesis and we provide the tool with our rtl code.

The instructions used are as follows:

yosys

read_verilog mk_srt_radix4_divider.v

hierarchy -check -top mk_srt_radix4_divider

proc; opt; fsm; opt; memory; opt

synth -top mk_srt_radix4_divider

write_verilog synth.v

The results are follows:

![WhatsApp Image 2023-12-10 at 10 37 34 AM](https://github.com/sneha-yb/CAD-for-VLSI/assets/113349234/66953f9c-137f-475e-8b7e-fbb8adc51cc7)


![WhatsApp Image 2023-12-10 at 10 37 42 AM](https://github.com/sneha-yb/CAD-for-VLSI/assets/113349234/fa23cc74-291b-4396-9ea8-e25624149a31)

**SYNTHESIS RESULTS**


=== mk_srt_radix4_divider ===

Number of public wires:         621
Number of public wire bits:     816  
Number of memories:               0
Number of memory bits:            0
Number of processes:              0
Number of cells:               7379
sky130_fd_sc_hd__a2111o_2       6
sky130_fd_sc_hd__a211o_2       63
 sky130_fd_sc_hd__a211oi_2       6
 sky130_fd_sc_hd__a21bo_2       30
 sky130_fd_sc_hd__a21boi_2      14
     sky130_fd_sc_hd__a21o_2       342
     sky130_fd_sc_hd__a21oi_2      167
     sky130_fd_sc_hd__a221o_2      187
     sky130_fd_sc_hd__a221oi_2       1
     sky130_fd_sc_hd__a22o_2       346
     sky130_fd_sc_hd__a22oi_2        7
     sky130_fd_sc_hd__a2bb2o_2      37
     sky130_fd_sc_hd__a311o_2       39
     sky130_fd_sc_hd__a311oi_2       1
     sky130_fd_sc_hd__a31o_2       157
     sky130_fd_sc_hd__a31oi_2        9
     sky130_fd_sc_hd__a32o_2        47
     sky130_fd_sc_hd__a41o_2         3
     sky130_fd_sc_hd__a41oi_2        1
     sky130_fd_sc_hd__and2_2       379
     sky130_fd_sc_hd__and2b_2      104
     sky130_fd_sc_hd__and3_2       120
     sky130_fd_sc_hd__and3b_2       12
     sky130_fd_sc_hd__and4_2        15
     sky130_fd_sc_hd__and4b_2        5
     sky130_fd_sc_hd__and4bb_2       1
     sky130_fd_sc_hd__buf_1        727
     sky130_fd_sc_hd__buf_2          3
     sky130_fd_sc_hd__conb_1         3
     sky130_fd_sc_hd__dfxtp_2      608
     sky130_fd_sc_hd__inv_2        214
     sky130_fd_sc_hd__mux2_2       885
     sky130_fd_sc_hd__mux4_2        10
     sky130_fd_sc_hd__nand2_2      392
     sky130_fd_sc_hd__nand2b_2       3
     sky130_fd_sc_hd__nand3_2       13
     sky130_fd_sc_hd__nand3b_2       6
     sky130_fd_sc_hd__nand4_2        2
     sky130_fd_sc_hd__nand4b_2       3
     sky130_fd_sc_hd__nand4bb_2      1
     sky130_fd_sc_hd__nor2_2       333
     sky130_fd_sc_hd__nor3_2        13
     sky130_fd_sc_hd__nor3b_2        3
     sky130_fd_sc_hd__nor4_2         3
     sky130_fd_sc_hd__o2111a_2       4
     sky130_fd_sc_hd__o211a_2      289
     sky130_fd_sc_hd__o211a_4        1
     sky130_fd_sc_hd__o211ai_2      10
     sky130_fd_sc_hd__o21a_2       237
     sky130_fd_sc_hd__o21ai_2      158
     sky130_fd_sc_hd__o21ba_2       21
     sky130_fd_sc_hd__o21bai_2      10
     sky130_fd_sc_hd__o221a_2      136
     sky130_fd_sc_hd__o221ai_2       2
     sky130_fd_sc_hd__o22a_2        43
     sky130_fd_sc_hd__o22ai_2        4
     sky130_fd_sc_hd__o2bb2a_2      20
     sky130_fd_sc_hd__o311a_2       26
     sky130_fd_sc_hd__o311ai_2       1
     sky130_fd_sc_hd__o31a_2        47
     sky130_fd_sc_hd__o31ai_2       16
     sky130_fd_sc_hd__o32a_2         6
     sky130_fd_sc_hd__o41a_2        14
     sky130_fd_sc_hd__or2_2        378
     sky130_fd_sc_hd__or2_4          1
     sky130_fd_sc_hd__or2b_2        68
     sky130_fd_sc_hd__or3_2         82
     sky130_fd_sc_hd__or3_4          7
     sky130_fd_sc_hd__or3b_2        26
     sky130_fd_sc_hd__or4_2         81
     sky130_fd_sc_hd__or4_4         46
     sky130_fd_sc_hd__or4b_2        15
     sky130_fd_sc_hd__or4b_4         3
     sky130_fd_sc_hd__xnor2_2      180
     sky130_fd_sc_hd__xor2_2       126
<img width="368" alt="Screenshot 2023-12-11 at 10 55 32 AM" src="https://github.com/sneha-yb/CAD-for-VLSI/assets/113349234/d58217f8-575f-4e85-ae2c-0ac56d773e4d">
<img width="280" alt="Screenshot 2023-12-11 at 10 55 55 AM" src="https://github.com/sneha-yb/CAD-for-VLSI/assets/113349234/5c992425-1ec7-448b-a290-706807ead506">
<img width="535" alt="Screenshot 2023-12-11 at 10 56 30 AM" src="https://github.com/sneha-yb/CAD-for-VLSI/assets/113349234/69e3fd68-3275-4a5a-842f-b9f4d8830d47">

   Chip area for module '\mk_srt_radix4_divider': **71679.996800**

**Conclusion:** 

The SRT Radix-4 Division Algorithm combines parallel processing and efficient special case handling, making it a powerful solution for fast and reliable 64-bit integer division, especially in pipelined architectures.

