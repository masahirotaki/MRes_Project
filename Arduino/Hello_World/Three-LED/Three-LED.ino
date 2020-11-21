//We need to track how long the momentary pushbutton is held in order to execute different commands
//This value will be recorded in seconds
unsigned long time_now = 0;

// Define the *minimum* length of time, in milli-seconds, that the button must be pressed for a particular option to occur
int optionOne_milliSeconds = 10;
int optionTwo_milliSeconds = 500;        
int optionThree_milliSeconds = 1000; 

//The Pin your button is attached to
int buttonPin = 2;

//Pin your LEDs are attached to
int ledPin_Option_1 = 4;
int ledPin_Option_2 = 7;
int ledPin_Option_3 = 8;

void setup(){

  // Initialize the pushbutton pin as an input pullup
  // Keep in mind, when pin 2 has ground voltage applied, we know the button is being pressed
  pinMode(buttonPin, INPUT_PULLUP); // When pressed -> connect to the ground    

  //set the LEDs pins as outputs
  pinMode(ledPin_Option_1, OUTPUT); 
  pinMode(ledPin_Option_2, OUTPUT); 
  pinMode(ledPin_Option_3, OUTPUT); 

  //Start serial communication - for debugging purposes only
  Serial.begin(115200);                                      

} // close setup


void loop() {

  if (digitalRead(buttonPin) == LOW )
  {
    digitalWrite(ledPin_Option_1, LOW);
    digitalWrite(ledPin_Option_2, LOW);
    digitalWrite(ledPin_Option_3, LOW);
  }
  
  //Record *roughly* the tenths of seconds the button in being held down
  while (digitalRead(buttonPin) == LOW )
  { // When pressed, it connects to ground and becomes LOW
    while(millis() < time_now + 1){
    }
    //display how long button is has been held
    time_now = time_now + 1;
    Serial.print("ms =");
    Serial.println(time_now);

  }//close while


  //Different if-else conditions are triggered based on the length of the button press
  //Start with the longest time option first

  //Option 2 - Execute the second option if the button is held for the correct amount of time
if (time_now >= optionThree_milliSeconds){

    digitalWrite(ledPin_Option_3, HIGH);     

  } 

  
  else if (time_now >= optionTwo_milliSeconds){

    digitalWrite(ledPin_Option_2, HIGH);     

  } 

  //option 1 - Execute the first option if the button is held for the correct amount of time
  else if(time_now >= optionOne_milliSeconds){

    digitalWrite(ledPin_Option_1, HIGH);  

  }//close if options


  //every time through the loop, we need to reset the pressLength_Seconds counter
  time_now = 0;

} // close void loop
