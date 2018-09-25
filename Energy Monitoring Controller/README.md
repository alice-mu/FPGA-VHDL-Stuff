# Energy Monitering Controller

Made a 4-big magnitude comparator and implemented in top-level code to achieve the below functions:

1. Takes switch inputs as the current temperature and desire temp, seven-segnment digits display said inputs
2. The push button inputs as front door open, back door open, windows open repectively
3. LED lights indicate whether the furnace is on, AC is on, blower is on, or system is at equilibrium

With the doors and windows closed the Furnace or A/C will be activated whenever there is a
difference detected between the current and desired temperature values. When either of these
turn on the blower must turn on also.
The equilibrium indicator turns on when desired temp equals current temp regardless if any doors or
windows are open.
Uses 4-bit comparator design to control the Blower and determine whether the A/C or Furnace is to be activated/
