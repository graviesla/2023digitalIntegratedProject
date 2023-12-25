.TITLE 16bit carry bypass adder implemented using CMOS and dynamic logic technology
**********************************
*Carry Bypass Adder (Dynamic Implementation)
**********************************

.include components_default.sp

.subckt DYN_FA VDD NCI CLK
+ P0 P1 P2 P3 G0 G1 G2 G3
+ C0 C1 C2 C3
X1 VDD NCI P0 G0 CLK NCO1 DYN_MC_CHAIN
X2 VDD NCO1 P1 G1 CLK NCO2 DYN_MC_CHAIN
X3 VDD NCO2 P2 G2 CLK NCO3 DYN_MC_CHAIN
X4 VDD NCO3 P3 G3 CLK NCO4 DYN_MC_CHAIN
X5 VDD NCO1 C0 INV
X6 VDD NCO2 C1 INV
X7 VDD NCO3 C2 INV
X8 VDD NCO4 C3 INV
.ends

.subckt DYN_4BIT A0 A1 A2 A3 B0 B1 B2 B3 CI VDD CLK
+ S0 S1 S2 S3 CO
X1 VDD A0 B0 P0 XOR
X2 VDD A1 B1 P1 XOR
X3 VDD A2 B2 P2 XOR
X4 VDD A3 B3 P3 XOR
X5 VDD A0 B0 NG0 NAND
X6 VDD A1 B1 NG1 NAND
X7 VDD A2 B2 NG2 NAND
X8 VDD A3 B3 NG3 NAND
X9 VDD NG0 G0 INV
X10 VDD NG1 G1 INV
X11 VDD NG2 G2 INV
X12 VDD NG3 G3 INV
X13 VDD CI NCI INV
X14 VDD NCI CLK P0 P1 P2 P3 G0 G1 G2 G3 
+ C0 C1 C2 C3 DYN_FA
X15 VDD P0 P1 N1 NAND
X16 VDD P2 P3 N2 NAND
X17 VDD N1 N2 SEL NOR
X18 VDD CI C3 SEL CO MUX
X19 VDD P0 CI S0 XOR
X20 VDD P1 C0 S1 XOR
X21 VDD P2 C1 S2 XOR
X22 VDD P3 C2 S3 XOR
.ends

.subckt DYN_16BIT VDD CLK CI CO 
+A0 A1 A2 A3 A4 A5 A6 A7 A8 A9 A10 A11 A12 A13 A14 A15 
+B0 B1 B2 B3 B4 B5 B6 B7 B8 B9 B10 B11 B12 B13 B14 B15
+S0 S1 S2 S3 S4 S5 S6 S7 S8 S9 S10 S11 S12 S13 S14 S15
X1 A0 A1 A2 A3 B0 B1 B2 B3 CI VDD CLK S0 S1 S2 S3 CO1 DYN_4BIT
X2 A4 A5 A6 A7 B4 B5 B6 B7 CO1 VDD CLK S4 S5 S6 S7 CO2 DYN_4BIT
X3 A8 A9 A10 A11 B8 B9 B10 B11 CO2 VDD CLK S8 S9 S10 S11 CO3 DYN_4BIT
X4 A12 A13 A14 A15 B12 B13 B14 B15 CO3 VDD CLK S12 S13 S14 S15 CO DYN_4BIT

.ends

V1 vd 0 DC=3.3
V2 vclk 0 PULSE(0 3.3 50ns 1ns 1ns 100ns 202ns)


X1 vd vclk 0 cout
+vd vd vd vd vd vd vd vd vd vd vd vd vd vd vd 0 
+vclk 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
+S0 S1 S2 S3 S4 S5 S6 S7 S8 S9 S10 S11 S12 S13 S14 S15 DYN_16BIT

.tran 1ns 1000ns 
.MEASURE TRAN tdlay_CO TRIG V(vclk) VAL = 1.65 RISE=1  
+ TARG V(cout) VAL=1.65 RISE = 1

.MEASURE TRAN tdlay_S0 TRIG V(vclk) VAL = 1.65 RISE=1  
+ TARG V(S0) VAL=1.65 CROSS = 1

.MEASURE TRAN tdlay_S1 TRIG V(vclk) VAL = 1.65 RISE=1  
+ TARG V(S1) VAL=1.65 CROSS = 1

.MEASURE TRAN tdlay_S2 TRIG V(vclk) VAL = 1.65 RISE=1  
+ TARG V(S2) VAL=1.65 CROSS = 1

.MEASURE TRAN tdlay_S3 TRIG V(vclk) VAL = 1.65 RISE=1  
+ TARG V(S3) VAL=1.65 CROSS = 1

.MEASURE TRAN tdlay_S4 TRIG V(vclk) VAL = 1.65 RISE=1  
+ TARG V(S4) VAL=1.65 CROSS = 1

.MEASURE TRAN tdlay_S5 TRIG V(vclk) VAL = 1.65 RISE=1  
+ TARG V(S5) VAL=1.65 CROSS = 1

.MEASURE TRAN tdlay_S6 TRIG V(vclk) VAL = 1.65 RISE=1  
+ TARG V(S6) VAL=1.65 CROSS = 1

.MEASURE TRAN tdlay_S7 TRIG V(vclk) VAL = 1.65 RISE=1  
+ TARG V(S7) VAL=1.65 CROSS = 1

.MEASURE TRAN tdlay_S8 TRIG V(vclk) VAL = 1.65 RISE=1  
+ TARG V(S8) VAL=1.65 CROSS = 1

.MEASURE TRAN tdlay_S9 TRIG V(vclk) VAL = 1.65 RISE=1  
+ TARG V(S9) VAL=1.65 CROSS = 1

.MEASURE TRAN tdlay_S10 TRIG V(vclk) VAL = 1.65 RISE=1  
+ TARG V(S10) VAL=1.65 CROSS = 1

.MEASURE TRAN tdlay_S11 TRIG V(vclk) VAL = 1.65 RISE=1  
+ TARG V(S11) VAL=1.65 CROSS = 1

.MEASURE TRAN tdlay_S12 TRIG V(vclk) VAL = 1.65 RISE=1  
+ TARG V(S12) VAL=1.65 CROSS = 1

.MEASURE TRAN tdlay_S13 TRIG V(vclk) VAL = 1.65 RISE=1  
+ TARG V(S13) VAL=1.65 CROSS = 1

.MEASURE TRAN tdlay_S14 TRIG V(vclk) VAL = 1.65 RISE=1  
+ TARG V(S14) VAL=1.65 CROSS = 1

.MEASURE TRAN tdlay_S15 TRIG V(vclk) VAL = 1.65 RISE=1  
+ TARG V(S15) VAL=1.65 CROSS = 1



.END