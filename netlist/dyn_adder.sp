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
