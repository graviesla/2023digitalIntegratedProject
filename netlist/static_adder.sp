.TITLE 16bit carry bypass adder implemented using CMOS and static transmission gate technology
**********************************
*Carry Bypass Adder (Static Implementation)
**********************************

.include components.sp

*Subcircuit of an adder unit
.subckt STAT_FA VDD A B CI S CO P
X1 VDD A B NG NAND
X2 VDD A B P XOR
X3 VDD A B D NOR
X4 VDD CI P D NG CO STAT_MC_CHAIN
X5 VDD P CI S XOR
.ends

*Subcircuit of a 4bit carry bypass adder
.subckt STAT_4BIT VDD A0 A1 A2 A3 B0 B1 B2 B3 CI S0 S1 S2 S3 CO
X1 VDD A0 B0 CI S0 CO0 P0 STAT_FA
X2 VDD A1 B1 CO0 S1 CO1 P1 STAT_FA
X3 VDD A2 B2 CO1 S2 CO2 P2 STAT_FA
X4 VDD A3 B3 CO2 S3 CO3 P3 STAT_FA
X5 VDD P0 P1 1 NAND
X6 VDD P2 P3 2 NAND
X7 VDD 1 2 SEL NOR
X8 VDD CI CO3 SEL CO MUX $If SEL(P0P1P2P3) == 1 bypass CI immediately
.ends

*Subcircuit of a 16bit carry bypass adder
.subckt STAT_16BIT VDD CI CO 
+A0 A1 A2 A3 A4 A5 A6 A7 A8 A9 A10 A11 A12 A13 A14 A15
+B0 B1 B2 B3 B4 B5 B6 B7 B8 B9 B10 B11 B12 B13 B14 B15
+S0 S1 S2 S3 S4 S5 S6 S7 S8 S9 S10 S11 S12 S13 S14 S15
X1 VDD A0 A1 A2 A3 B0 B1 B2 B3 CI S0 S1 S2 S3 CO3! STAT_4BIT
X11 VDD CO3! NCO3 INV
X12 VDD NCO3 CO3 INV
X2 VDD A4 A5 A6 A7 B4 B5 B6 B7 CO3 S4 S5 S6 S7 CO7! STAT_4BIT
X21 VDD CO7! NCO7 INV
X22 VDD NCO7 CO7 INV
X3 VDD A8 A9 A10 A11 B8 B9 B10 B11 CO7 S8 S9 S10 S11 CO11! STAT_4BIT
X31 VDD CO11! NCO11 INV
X32 VDD NCO11 CO11 INV
X4 VDD A12 A13 A14 A15 B12 B13 B14 B15 CO11 S12 S13 S14 S15 CO! STAT_4BIT
X41 VDD CO! NCO INV
X42 VDD NCO CO INV
.ends

*****STRUCTURE_VERIFICATION*****
.OPTIONS nomod

V0 vd 0 DC=3.3
V1 vclk1 0 PULSE(0 5 20ns 1ns 1ns 25ns 52ns)
V2 vclk2 0 PULSE(0 5 20ns 1ns 1ns 50ns 102ns)
V3 vclk3 0 PULSE(0 5 20ns 1ns 1ns 100ns 202ns)
V4 vclk4 0 PULSE(0 5 20ns 1ns 1ns 200ns 402ns)
V5 vclk5 0 PULSE(0 5 20ns 1ns 1ns 400ns 802ns)
V6 vclk6 0 PULSE(0 5 20ns 1ns 1ns 800ns 1602ns)
V7 vclk7 0 PULSE(0 5 20ns 1ns 1ns 1600ns 3202ns)
V8 vclk8 0 PULSE(0 5 20ns 1ns 1ns 3200ns 6402ns)


X1 vd 0 CO
+vclk1 vclk2 vclk3 vclk4 vclk5 vclk6 vclk7 vclk8 0 0 0 0 0 0 0 0
+0 0 0 0 0 0 0 0 vclk1 vclk2 vclk3 vclk4 vclk5 vclk6 vclk7 vclk8 
+S0 S1 S2 S3 S4 S5 S6 S7 S8 S9 S10 S11 S12 S13 S14 S15 STAT_16BIT
.tran 1ns 13000ns 

.PRINT TRAN POWER

.END

