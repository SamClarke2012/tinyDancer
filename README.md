# tinyDancer

Don't want to pay $200 for a [Slow Dance time frame](https://www.kickstarter.com/projects/xercyn/slow-dance-a-frame-that-slows-down-time "Slow Dance time frame")?  I don't blame you!

One of the more expensive parts of that project is the microcontroller, for this the [time frame](https://www.kickstarter.com/projects/xercyn/slow-dance-a-frame-that-slows-down-time "Slow Dance time frame") uses an Atmel MEGA series chipset which is overkill to say the least as most of this microcontroller's peripherals such as I/O, timers and serial comms aren't used at all. 

In order to bring the cost of this project down somewhat, the main functionality of slow dance has been implemented for a more suitable and cheaper chipset, the ATTiny85, which can be had for as little as $1.  Furthermore, by running the chipset with it's calibrated internal oscillator as opposed to an external xtal, the time frame can be run using just 1x LM7805 regulator and 1x TIP122 darlington transistor (see diagram and O'scope below). It's true that the internal oscillator is only accurate to +/-10%, but given that the illusion is created by the relative difference in strobe frequencies, this doesn't matter at all (the two signal remain 0.5Hz apart).

The ATTiny85 can be flashed using any standard AVR programmer, and I expect most will likely use the arduinoISP sketch. If so the chip can be flashed using the following cmd:


`sudo avrdude -F -c arduino -p t85 -U flash:w:tinyDancer.hex -U lfuse:w:0xe2:m -U hfuse:w:0xdf:m -U efuse:w:0xff:m`

## PB4 strobes at ~90.5Hz (Magnetic coil via TIP122)
![Channel 2](https://raw.githubusercontent.com/SamClarke2012/tinyDancer/master/Oscope/SDS00003.BMP "Channel 2")

## PB3 strobes at ~90.0Hz (LED strip)
![Channel 1](https://raw.githubusercontent.com/SamClarke2012/tinyDancer/master/Oscope/SDS00002.BMP "Channel 1")
