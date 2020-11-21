int buttonPin = 8;
int ledPin = 9;

int toggleState;// keep track of ON or OFF state
int lastButtonState = 1;
long unsigned int lastPress;// Variable length (it can store 4 bits unlike 2 bits)
// unsigned remove negative values
int debounceTime = 20;

void setup() {
  // setup pin modes
  pinMode(ledPin, OUTPUT);                  
  pinMode(buttonPin, INPUT_PULLUP);
}

void loop() {  
  int buttonState = digitalRead(buttonPin);   //read the state of buttonPin and store it as buttonState (0 or 1)

  if((millis() - lastPress) > debounceTime)   //if the time between the last buttonChange is greater than the debounceTime
  {
    lastPress = millis();   //update lastPress                                                     
    
    if(buttonState == 0 && lastButtonState == 1)    //if button is pressed and was released last change
    {
      toggleState =! toggleState;                 //toggle the LED state
      digitalWrite(ledPin, toggleState);
      lastButtonState = 0;    //record the lastButtonState
    }

  
    if(buttonState == 1 && lastButtonState == 0)    //if button is not pressed, and was pressed last change
    {
      lastButtonState = 1;    //record the lastButtonState
    }
  }
}