#Hold me closer tinyDancer!


<a href="http://www.youtube.com/watch?feature=player_embedded&v=Gln_W7R6Qp0" target="_blank"><img src="http://img.youtube.com/vi/Gln_W7R6Qp0/0.jpg" alt="tinyDancer" width="240" height="180" border="10" /></a> 


Don't want to pay $200 for a [Slow Dance time frame](https://www.kickstarter.com/projects/xercyn/slow-dance-a-frame-that-slows-down-time "Slow Dance time frame")?  
I don't blame you! And naturally, as a maker/hacker ... you build your own!

###Why is the [Slow Dance time frame](https://www.kickstarter.com/projects/xercyn/slow-dance-a-frame-that-slows-down-time "Slow Dance time frame") so expensive?
One of the more expensive parts of that project is the microcontroller, for this the [time frame](https://www.kickstarter.com/projects/xercyn/slow-dance-a-frame-that-slows-down-time "Slow Dance time frame") uses an Atmel MEGA series chipset which is overkill to say the least! (most of the ATMEGA's peripherals such as I/O, timers and serial comms aren't used at all). 

###So what microcontroller should we use?
In order to bring the cost of building one of these down somewhat, the main functionality of slow dance has been implemented for a more suitable and much cheaper chipset, the ATTiny85, which can be had for as little as $1.  Furthermore, by running the chipset with it's calibrated internal oscillator (as opposed to an external oscillator), tinyDancer can be run using just 1x LM7805 regulator and 2x TIP120 darlington transistors (along with a couple of passive components - see diagram). 

###Isn't that clock source inaccurate?
It's true that the internal oscillator is only accurate to +/-10%, but given that the illusion is created by the relative difference in strobe frequencies, this error doesn't matter at all as the two signals remain 0.5Hz apart, and the overall error remains beyond human perception.

###So, how do I get started?
The ATTiny85 can be flashed using any standard AVR programmer (no arduino bootloaders here folks), and I expect most will likely use the arduinoISP sketch to create their own programmer. If so the chip can be flashed using the following cmd:


`sudo avrdude -F -c arduino -p t85 -U flash:w:tinyDancer.hex -U lfuse:w:0xe2:m -U hfuse:w:0xdf:m -U efuse:w:0xff:m`

###Schematic
![Schematic](https://github.com/SamClarke2012/tinyDancer/blob/master/Oscope/Schematic.png "Schematic")


###PB4 strobes at ~90.5Hz (Magnetic coil via TIP122)
![Channel 2](https://raw.githubusercontent.com/SamClarke2012/tinyDancer/master/Oscope/SDS00003.BMP "Channel 2")

###PB3 strobes at ~90.0Hz (LED strip)
![Channel 1](https://raw.githubusercontent.com/SamClarke2012/tinyDancer/master/Oscope/SDS00002.BMP "Channel 1")

##Is there other way to reduce the cost?
Yup! Instead of buying 40ft of copper wire and winding it over a ferrous slug, simply repurpose a 12v solenoid by fixing the slug in place with epoxy (as close to center as possible). 
![Setup](https://raw.githubusercontent.com/SamClarke2012/tinyDancer/master/Oscope/tmp_27874-foto_no_exif89039024.jpg "ready-made magnet")
