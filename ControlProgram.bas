symbol rightsensor= b6 ; Intializing data allocation
symbol countdown = b7 ; Intializing data allocation

servo B.1,80 ;Intitalize servo position
servo B.2,80 ;Intitalize servo position

dirsB = %11111111	;Setting ouputs
dirsC = %00000000 ;Setting inputs
let adcsetup = %000000000001110 

#no_table ;Speeds up download
#no_data ;Speeds up download 

myloop: ;Starting loop
button C.4,1,200,100,b2,1,pushed; jump to cont when C.0 = 1
let countdown = 250 ;Declaring variable's starting value
pause 10 ; loop delay time
goto myloop ;Makes loop run infinitely until desired outcome is achieved

pushed: ;Sound procedure
sound b.3 ,(100,50); Pitches
sound b.3 ,(50,50)
sound b.3 ,(20,50)
  
goto start ;Begin main program 

start: ;Main Program 

readadc C.1,rightsensor ;Finds voltage value for servo
let w0 = rightsensor * 7/12 + 80 ;Calculating Servo position
servopos B.1,w0 ;Set servo position

readadc C.2,rightsensor ;Finds voltage value for servo
let w0 = rightsensor * 7/12 + 80 ;Calculating Servo position
servopos B.2,w0 ;Set servo position


countdown=countdown - 1 ;Decreases variable value for timer function

pause 30 ;Delay

button C.3,1,200,100,b2,1,TimeReset; jump to TimeReset procedure when C.3 = 1
button C.4,1,200,100,b2,1,Win; jump to Win procedure when C.4 = 1


if countdown >225 then ;Checks variable value,if true outputs 9 on display

high b.7
high b.4

else if countdown >200 then ;Checks variable value,if true outputs 8 on display

low b.4

else if countdown >175 then ;Checks variable value,if true outputs 7 on display

low b.7
high b.6
high b.5 
high b.4

else if countdown >150 then ;Checks variable value,if true outputs 6 on display

low b.4

else if countdown >125 then ;Checks variable value,if true outputs 5 on display

low b.5
high b.4

else if countdown >100 then ;Checks variable value,if true outputs 4 on display

low b.4

else if countdown >75 then ;Checks variable value,if true outputs 3 on display

low b.6
high b.5
high b.4

else if countdown >50 then ;Checks variable value,if true outputs 2 on display

low b.4

else if countdown >25 then ;Checks variable value,if true outputs 1 on display

high b.4
low b.5

else if countdown >0 then ;Checks variable value,if true outputs 0 on display

low b.4

else if countdown = 0 then ;Checks variable value,if true gameover sound

sound b.3 ,(20,50)
sound b.3 ,(50,50)
sound b.3 ,(100,50)

goto myloop ;Goes back to the Starting procedure because game was lost

endif

goto start ;Game not lost, Rechecks servo positions and decrements countdown


TimeReset: ;Time reset procedure
let countdown = 250 ; Resets countdown variable

low b.7 ;Turn everything low
low b.6
low b.5 
low b.4
goto start ;Goes back to main program


Win: ;Win Procedure
low b.7 ;Turn everything low
low b.6
low b.5 
low b.4

sound b.3 ,(150,50) ;Play Win sounds
sound b.3 ,(150,50)
sound b.3 ,(150,50)

goto myloop ;Goes back to starting procedure because game was won