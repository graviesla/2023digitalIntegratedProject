.TITLE basic components for building a carry bypass adder circuit
**********************************
*Static Carry Bypass Adder
**********************************

**********************************
*library and options
**********************************
.lib sm046005-1j.hspice typical

.option post=2
**********************************
*Circuit Netlist
**********************************

*Subcircuit of inverter
.subckt INV VDD IN OUT
MN OUT IN 0 0 NMOS_3P3 W=1um L=0.35um
MP OUT IN VDD VDD PMOS_3P3 W=2um L=0.35um
.ends

*Subcircuit of NAND gate
.subckt NAND VDD A B OUT
MN1 OUT A 1 1 NMOS_3P3 W=2um L=0.35um
MN2 1 B 0 0 NMOS_3P3 W=2um L=0.35um
MP1 OUT A VDD VDD PMOS_3P3 W=2um L=0.35um
MP2 OUT B VDD VDD PMOS_3P3 W=2um L=0.35um
.ends

*Subcircuit of NOR gate
.subckt NOR VDD A B OUT
MN1 OUT A 0 0 NMOS_3P3 W=1um L=0.35um
MN2 OUT B 0 0 NMOS_3P3 W=1um L=0.35um
MP1 OUT A 1 1 PMOS_3P3 W=4um L=0.35um
MP2 1 B VDD VDD PMOS_3P3 W=4um L=0.35um
.ends

*Subcircuit of XOR gate
.subckt XOR VDD A B OUT
X1 VDD A NA INV
X2 VDD B NB INV
MN1 OUT A 1 1 NMOS_3P3 W=2um L=0.35um
MN2 OUT NA 2 2 NMOS_3P3 W=2um L=0.35um
MN3 1 B 0 0 NMOS_3P3 W=2um L=0.35um
MN4 2 NB 0 0 NMOS_3P3 W=2um L=0.35um
MP1 OUT NB 3 3 PMOS_3P3 W=4um L=0.35um
MP2 OUT B 4 4 PMOS_3P3 W=4um L=0.35um
MP3 3 A VDD VDD PMOS_3P3 W=4um L=0.35um
MP4 4 NA VDD VDD PMOS_3P3 W=4um L=0.35um
.ends

*Subcircuit of CMOS transmission gate
.subckt TRANS VDD NGATE PGATE IN OUT
MN IN NGATE OUT 0 NMOS_3P3 W=1um L=0.35um 
MP OUT PGATE IN VDD PMOS_3P3 W=2um L=0.35um
.ends

*Subcircuit of CMOS multiplexer
.subckt MUX VDD A B S OUT $If SEL == 1 choose A else choose B
X1 VDD A NA INV
X2 VDD B NB INV
X3 VDD S NS INV
MN1 OUT NA 1 1 NMOS_3P3 W=2um L=0.35um
MN2 OUT NS 1 1 NMOS_3P3 W=2um L=0.35um
MN3 1 NB 0 0 NMOS_3P3 W=2um L=0.35um
MN4 1 S 0 0 NMOS_3P3 W=2um L=0.35um
MP1 OUT NA 2 2 PMOS_3P3 W=4um L=0.35um
MP2 OUT NB 3 3 PMOS_3P3 W=4um L=0.35um
MP3 2 NS VDD VDD PMOS_3P3 W=4um L=0.35um
MP4 3 S VDD VDD PMOS_3P3 W=4um L=0.35um
.ends

*Subcircuit of static Manchester carry chain
.subckt STAT_MC_CHAIN VDD CI P D NG CO
X1 VDD P NP INV
X2 VDD P NP CI CO TRANS
MN CO D 0 0 NMOS_3P3 W=1um L=0.35um
MP CO NG VDD VDD PMOS_3P3 W=2um L=0.35um
.ends

*Subcircuit of dynamic Manchester carry chain
.subckt DYN_MC_CHAIN VDD NCI P G CLK NCO
MN1 NCI P NCO 0 NMOS_3P3 W=1um L=0.35um
MN2 NCO G 1 1 NMOS_3P3 W=1um L=0.35um 
MN3 1 CLK 0 0 NMOS_3P3 W=1um L=0.35um 
MP1 NCO CLK VDD VDD PMOS_3P3 W=2um L=0.35um 
.ends
.END


*X1 VDD IN o INV

**********************************
*Test
**********************************
*VDD VDD 0 3.3V
*VGND GND 0 0
*VIN IN 0 PULSE(0 3.3 5n 1n 1n 50n 100n)
*.TRAN 0.1n 250n
*.PRINT TRAN POWER
*.PRINT TRAN V(IN) V(o)