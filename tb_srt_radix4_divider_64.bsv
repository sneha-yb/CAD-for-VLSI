package tb_srt_radix4_divider_64;
//import UniqueWrappers::*;
import Vector::*;
import srt_radix4_divider_64 ::*;

(*synthesize*)
module mk_tb_srt_radix4_divider_64();

  Ifc_srt_radix4_divider ifc_div <- mk_srt_radix4_divider();
  Reg#(int) rg_cycle <- mkReg(0);
  Reg#(Bit#(4)) rg_opcode <- mkReg('b1100);
  Reg#(Bit#(3)) rg_funct3 <- mkReg('b101);
  Reg#(Bit#(6)) rg_cnt <- mkReg(0);
	Reg#(Bool) en <- mkReg(True);
  rule rl_cycle;
    rg_cycle <= rg_cycle +1;
    if(rg_cycle==400)
      $finish(0);
  endrule
  rule rl_stage_1(rg_cycle % 38 == 0);

//    Bit#(64) op1 ='hce9e3519a12fe4a4;
//    Bit#(64) op2 ='h00000000312fe4a4;
    Bit#(64) op1 ='h0000000000045FEA;
    Bit#(64) op2 ='h0000000000023BC3;
    Bit#(64) dividend = 0;
    Bit#(64) divisor = 0;    
    if(rg_cnt == 0)
    begin
      dividend = op1;
      divisor = op2;
      ifc_div.ma_start(dividend,divisor,'b1100 , 'b100);
      $display("divident = %h ,  divisor = %h", op1, op2);
      rg_cnt<=rg_cnt+1;
    end
    else if(rg_cnt == 1)
    begin
      dividend = op1;
      divisor = op2;
      ifc_div.ma_start(dividend,divisor,'b1100 , 'b110);
      rg_cnt<=rg_cnt+1;
    end
    else if(rg_cnt == 2)
    begin
      dividend = op1;
      divisor = op2;
      ifc_div.ma_start(dividend,divisor,'b1100 , 'b101);
      $display("\n \n divident = %h ,  divisor = %h", op1, op2);
      rg_cnt<=rg_cnt+1;
    end
    else if(rg_cnt == 3)
    begin
      dividend = op1;
      divisor = op2;
      ifc_div.ma_start(dividend,divisor,'b1100 , 'b111);
      rg_cnt<=rg_cnt+1;
    end
    
    else if(rg_cnt == 4)
    begin
      dividend = op1;
      divisor = op2;
      ifc_div.ma_start(dividend,divisor,'b1110 , 'b100);
      $display("\n\ndivident = %h ,  divisor = %h", op1, op2);
      rg_cnt<=rg_cnt+1;
    end
    else if(rg_cnt == 5)
    begin
      dividend = op1;
      divisor = op2;
      ifc_div.ma_start(dividend,divisor,'b1110 , 'b110);
      rg_cnt<=rg_cnt+1;
    end
    else if(rg_cnt == 6)
    begin
      dividend = op1;
      divisor = op2;
      ifc_div.ma_start(dividend,divisor,'b1110 , 'b101);
      $display("\n\ndivident = %h ,  divisor = %h", op1, op2);
      rg_cnt<=rg_cnt+1;    
    end
    else if(rg_cnt == 7)
    begin
      dividend = op1;
      divisor = op2;
      ifc_div.ma_start(dividend,divisor,'b1110 , 'b111);
      rg_cnt<=rg_cnt+1;            
    end
  endrule

  rule rl_receive;
    match {.valid,.out} <- ifc_div.mav_result();
  //  $display("after updation Cycle %d => valid %d value %h",rg_cycle,valid,out);
    
    if(valid == 1) begin
    case(rg_cnt-1)
    	0: begin
    		$display("after cycle %d    the 64 bit signed divsion quotient = %h  ", rg_cycle, out);	
    	end
    	1: begin
    		$display("after cycle %d    the 64 bit signed divsion remainder = %h \n", rg_cycle, out);	
    	end
    	2: begin
    		$display("after cycle %d    the 64 bit unsigned divsion quotient = %h", rg_cycle, out);	
    	end
    	3: begin
    		$display("after cycle %d    the 64 bit unsigned divsion remainder = %h \n", rg_cycle, out);	
    	end
    	4: begin
    		$display("after cycle %d    the 32 bit signed divsion quotient = %h", rg_cycle, out);	
    	end
    	5: begin
    		$display("after cycle %d    the 32 bit signed divsion remainder = %h \n", rg_cycle, out);	
    	end
    	6: begin
    		$display("after cycle %d    the 32 bit unsigned divsion quotient = %h", rg_cycle, out);	
    	end
    	7: begin
    		$display("after cycle %d    the 32 bit unsigned divsion remainder = %h \n", rg_cycle, out);	
    	end

    endcase
//	$display("after updation Cycle %d => valid %d value %h",rg_cycle,valid,out);
    end
  endrule
endmodule
endpackage

