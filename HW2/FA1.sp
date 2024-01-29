*********************************************
.inc '90nm_bulk.l'

.SUBCKT FA1 DVDD GND A B Ci Co S
*.PININFO DVDD:I GND:I A:I B:I Ci:I Co:O S:O
MM1 Co R DVDD DVDD PMOS l=0.1u w=0.5u m=1
MM2 R A X DVDD PMOS l=0.1u w=0.5u m=1
MM3 X B DVDD DVDD PMOS l=0.1u w=0.5u m=1
MM4 R Ci Y DVDD PMOS l=0.1u w=0.5u m=1
MM5 Y A DVDD DVDD PMOS l=0.1u w=0.5u m=1
MM6 Y B DVDD DVDD PMOS l=0.1u w=0.5u m=1
MM7 Co R GND GND NMOS l=0.1u w=0.25u m=1
MM8 R A Z GND NMOS l=0.1u w=0.25u m=1
MM9 Z B GND GND NMOS l=0.1u w=0.25u m=1
MM10 R Ci W GND NMOS l=0.1u w=0.25u m=1
MM11 W A GND GND NMOS l=0.1u w=0.25u m=1
MM12 W B GND GND NMOS l=0.1u w=0.25u m=1

MM13 A_bar A DVDD DVDD PMOS l=0.1u w=0.5u m=1
MM14 A_bar A GND GND NMOS l=0.1u w=0.25u m=1

MM15 U A_bar B DVDD PMOS l=0.1u w=0.5u m=1
MM16 U B A_bar DVDD PMOS l=0.1u w=0.5u m=1
MM17 U A B GND NMOS l=0.1u w=0.25u m=1
MM18 U B A GND NMOS l=0.1u w=0.25u m=1

MM19 Ci_bar Ci DVDD DVDD PMOS l=0.1u w=0.5u m=1
MM20 Ci_bar Ci GND GND NMOS l=0.1u w=0.25u m=1

MM21 T U Ci DVDD PMOS l=0.1u w=0.5u m=1
MM22 T Ci U DVDD PMOS l=0.1u w=0.5u m=1
MM23 T Ci_bar U GND NMOS l=0.1u w=0.25u m=1
MM24 T U Ci_bar GND NMOS l=0.1u w=0.25u m=1

MM25 S T DVDD DVDD PMOS l=0.1u w=0.5u m=1
MM26 S T GND GND NMOS l=0.1u w=0.25u m=1
.ENDS
*********************************************


Vdd DVDD    0   1
Vss GND     0   0

VinA A    0   pwl (0 0 2u 0 2.1u 1 4u 1 4.1u 0)
VinB B    0   pwl (0 0 1u 0 1.1u 1 2u 1 2.1u 0 3u 0 3.1u 1 4u 1 4.1u 0)
VinCi Ci   0   pwl (0 0 0.5u 0 0.6u 1 1u 1 1.1u 0 1.5u 0 1.6u 1 2u 1 2.1u 0 2.5u 0 2.6u 1 3u 1 3.1u 0 3.5u 0 3.6u 1 4u 1 4.1u 0)

xFA1  DVDD  GND  A  B  Ci  Co  S  FA1

.tran 10n 4.1u
.op
.option post
.end
