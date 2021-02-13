# Work In Progress
I've been fed up with the built in windows serialport tools, so having a go at doing it myself in a few various ways. I plan on using a combination of functions and classes, and finally properly learning stream.

## New-SerialPort
Mostly a QOL function. It contains dynamic classes that feed the PortName, FriendlyName, and Service parameters. If you have a port plugged in, tab should autofill each property with current valid options.

For scripting purposes, if you are unsure of what the port name will be and aren't familiar with how to get it, you can use the FriendlyName and Service parameters to narrow down the port. I plan on including other properties to filter by later on but for now this should cover most of my current needs. It also contains tabbed Baudrate, parity, stopbits, databits, and switches for RTS and DTR, and a default 10 second readtimeout to prevent people from hanging their scripts up.