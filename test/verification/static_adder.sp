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
V1 vA0 0 PULSE(0 3.3 20ns 1ns 1ns 25ns 52ns)
V2 vA1 0 PULSE(0 3.3 20ns 1ns 1ns 50ns 102ns)
V3 vA2 0 PULSE(0 3.3 20ns 1ns 1ns 100ns 202ns)
V4 vA3 0 PULSE(0 3.3 20ns 1ns 1ns 200ns 402ns)
V5 vA4 0 PULSE(0 3.3 20ns 1ns 1ns 200ns 402ns)
V6 vA5 0 PULSE(0 3.3 20ns 1ns 1ns 100ns 202ns)
V7 vA6 0 PULSE(0 3.3 20ns 1ns 1ns 50ns 102ns)
V8 vA7 0 PULSE(0 3.3 20ns 1ns 1ns 25ns 52ns)
V9 vA8 0 PULSE(0 3.3 20ns 1ns 1ns 25ns 52ns)
V10 vA9 0 PULSE(0 3.3 20ns 1ns 1ns 200ns 402ns)
V11 vA10 0 PULSE(0 3.3 20ns 1ns 1ns 100ns 202ns)
V12 vA11 0 PULSE(0 3.3 20ns 1ns 1ns 50ns 102ns)
V13 vA12 0 PULSE(0 3.3 20ns 1ns 1ns 50ns 102ns)
V14 vA13 0 PULSE(0 3.3 20ns 1ns 1ns 25ns 52ns)
V15 vA14 0 PULSE(0 3.3 20ns 1ns 1ns 200ns 402ns)
V16 vA15 0 PULSE(0 3.3 20ns 1ns 1ns 100ns 202ns)

V17 vB0 0 PULSE(0 3.3 20ns 1ns 1ns 200ns 402ns)
V18 vB1 0 PULSE(0 3.3 20ns 1ns 1ns 25ns 52ns)
V19 vB2 0 PULSE(0 3.3 20ns 1ns 1ns 100ns 202ns)
V20 vB3 0 PULSE(0 3.3 20ns 1ns 1ns 50ns 102ns)
V21 vB4 0 PULSE(0 3.3 20ns 1ns 1ns 50ns 102ns)
V22 vB5 0 PULSE(0 3.3 20ns 1ns 1ns 200ns 402ns)
V23 vB6 0 PULSE(0 3.3 20ns 1ns 1ns 100ns 202ns)
V24 vB7 0 PULSE(0 3.3 20ns 1ns 1ns 25ns 52ns)
V25 vB8 0 PULSE(0 3.3 20ns 1ns 1ns 100ns 202ns)
V26 vB9 0 PULSE(0 3.3 20ns 1ns 1ns 50ns 102ns)
V27 vB10 0 PULSE(0 3.3 20ns 1ns 1ns 200ns 402ns) 
V28 vB11 0 PULSE(0 3.3 20ns 1ns 1ns 25ns 52ns)
V29 vB12 0 PULSE(0 3.3 20ns 1ns 1ns 100ns 202ns)
V30 vB13 0 PULSE(0 3.3 20ns 1ns 1ns 25ns 52ns)
V31 vB14 0 PULSE(0 3.3 20ns 1ns 1ns 50ns 102ns)
V32 vB15 0 PULSE(0 3.3 20ns 1ns 1ns 200ns 402ns)

V33 vci 0 PULSE(0 3.3 20ns 1ns 1ns 200ns 402ns)

X1 vd vci CO
+vA0 vA1 vA2 vA3 vA4 vA5 vA6 vA7 vA8 vA9 vA10 vA11 vA12 vA13 vA14 vA15
+vB0 vB1 vB2 vB3 vB4 vB5 vB6 vB7 vB8 vB9 vB10 vB11 vB12 vB13 vB14 vB15
+S0 S1 S2 S3 S4 S5 S6 S7 S8 S9 S10 S11 S12 S13 S14 S15 STAT_16BIT
.tran 1ns 500ns 


.END

