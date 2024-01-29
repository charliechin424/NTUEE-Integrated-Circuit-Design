*********************************************
.inc '90nm_bulk.l'

.SUBCKT Inv DVDD GND In Out
*.PININFO DVDD:I GND:I In:I Out:O
MM1 Out In GND GND NMOS l=0.1u w=0.25u m=1
MM2 Out In DVDD DVDD PMOS l=0.1u w=0.5u m=1
.ENDS

.SUBCKT Ckt_NAND DVDD GND A B X
*.PININFO DVDD:I GND:I A:I B:I X:O
MM1 X A DVDD DVDD PMOS l=0.1u w=0.5u m=1
MM2 X B DVDD DVDD PMOS l=0.1u w=0.5u m=1
MM3 X B Y GND NMOS l=0.1u w=0.25u m=1
MM4 Y A GND GND NMOS l=0.1u w=0.25u m=1
.ENDS
*********************************************


Vdd DVDD    0   1
Vss GND     0   0

VinA A     0   pwl (0 0 1u 0 1.1u 1 2u 1 2.1u 0)
VinB B     0   pwl (0 0 0.5u 0 0.6u 1 1u 1 1.1u 0 1.5u 0 1.6u 1 2u 1 2.1u 0)

xCkt_NAND  DVDD GND A B   X    Ckt_NAND
xoutput_Z  DVDD GND X Z   Inv

.tran 10n 4.1u
.op
.option post
.end
