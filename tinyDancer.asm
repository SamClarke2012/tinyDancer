;                                                                     ;
;                                                                     ;
; __________________Hold me closer tiny dancer!_______________________;
;                                                                     ;
; ______________________________________________Sam Clarke 2017_______;
;                                                                     ;
;  Firmware for the AVR ATTiny85                                      ;
;                                                                     ;
;  Clock:   Internal 8 MHz clock                                      ;
;                                                                     ;
;   Operation: Strobes an LED strip  @ 88.0 Hz on PB4                 ;
;              Strobes a transistor  @ 88.5 Hz on PB3                 ;
;_____________________________________________________________________;
;                                _____                                ;
;                rst  -- PB5 -- |  U  | -- VCC                        ;
;               LEDS  -- PB4 -- |     | -- PB0 -- sck                 ;
;         Transistor  -- PB3 -- |     | -- PB1 -- miso                ;
;                        GND -- |_____| -- PB2 -- mosi                ;
;                                                                     ;
;______________________________8-Pin DIP______________________________;
.NOLIST
.INCLUDE "tn85def.inc"
.LIST

;
;  Register constants
;
.DEF gReg = R17      ; General purpose register 
.DEF xReg = R18      ; XOR register
;
;  Pin constants
;
.EQU magPin = PB3    ; Pin for transistor (to drive the mag coil)
.EQU ledPin = PB4    ; Pin for LED strip
;
;  Pin masks
;
.EQU magMsk = (1 << magPin)   ;
.EQU ledMsk = (1 << ledPin)   ;  
;
;  Numerical Constants
;
.EQU T0_CMPAval = 175                  ; Top for T0 compare A register
.EQU T0_clock   = (1<<CS02)            ; T0 Clock Setting (/256)
.EQU T1_CMPAval = 176                  ; Top for T1 compare A register
.EQU T1_clock   = (1<<CS10)|(1<<CS13)  ; T1 Clock Setting (/256)
;
;  Interrrupt Vectors
;
.ORG 0x0000   rjmp   PWRRSTVECT       ; Reset / Power Vector
.ORG 0x0003   rjmp   T1_CMPAVECT      ; Timer 1 Compare A Vector
.ORG 0x000A   rjmp   T0_CMPAVECT      ; Timer 0 Compare A Vector
;
;  Entry Vector
;
PWRRSTVECT:
   ldi   gReg,    magMsk|ledMsk           ;
   out   DDRB,    gReg                    ; Set pin directions
   ldi   gReg,    (1<<WGM01)              ;
   out   TCCR0A,  gReg                    ; T0 CTC mode
   ldi   gReg,    T0_clock                ;
   out   TCCR0B,  gReg                    ; T0 CLK/256
   ldi   gReg,    T0_CMPAval              ;
   out   OCR0A,   gReg                    ; Set T0 CMP reg
   ldi   gReg,    (1<<CTC1)|T1_clock)     ;
   out   TCCR1,   gReg                    ; T1 CTC, CLK/256 
   ldi   gReg,    T1_CMPAval              ;
   out   OCR1A,   gReg                    ; Set T1 CLR/CMP regs
   out   OCR1C,   gReg                    ;
   ldi   gReg,    (1<<OCIE0A)|(1<<OCIE1A) ; 
   out   TIMSK,   gReg                    ; Enable timer compare(s)
   sei                                    ; Enable interrupts globally
;
;  Main
;
main:
   rjmp   main   ; Do nothing, main pgm loop

;
;  Timer 1 Compare A Vector - LED Strobe
;
T1_CMPAVECT:
   in    gReg,    PORTB       ; Get PORTB 
   ldi   xReg,    ledMsk      ; Prep xReg
   eor   gReg,    xReg        ; XOR registers
   out   PORTB,   gReg        ; Write result to PORTB
   reti
;
;  Timer 0 Compare A Vector - Magnet Strobe
;
T0_CMPAVECT:
   in    gReg,    PORTB       ; Get PORTB 
   ldi   xReg,    magMsk      ; Prep xReg
   eor   gReg,    xReg        ; XOR registers
   out   PORTB,   gReg        ; Write result to PORTB
   reti
