const byte buttonPin = 2;
const byte TTLsoundcue = 4;
const byte TTLsoundA = 7;
const byte TTLsoundB = 8;
const byte TTLshock = 12;
char incomingBonsai = 0;
unsigned long time_now = 0;

void setup() {
  // setup pin modes
  pinMode(TTLshock,OUTPUT);
  pinMode(TTLsoundA, OUTPUT);         
  pinMode(TTLsoundB, OUTPUT);      
  pinMode(TTLshock, OUTPUT);               
  pinMode(buttonPin, INPUT_PULLUP);
  Serial.begin(115200);
}


void fearsound()
{
  unsigned long time_now = millis();
  while(millis() < time_now + 1000){
  }
        
  digitalWrite(TTLsoundcue, HIGH);       
  digitalWrite(TTLsoundA, LOW);  
  digitalWrite(TTLsoundB, LOW);     
  digitalWrite(TTLshock, LOW);  
  time_now = millis();
  while(millis() < time_now + 2000){
  }

  digitalWrite(TTLsoundcue, LOW);         
  digitalWrite(TTLsoundA, LOW); 
  digitalWrite(TTLsoundB, LOW);     
  digitalWrite(TTLshock, LOW); 
  time_now = millis();
  while(millis() < time_now + 2000){
  }

  digitalWrite(TTLsoundcue, LOW);         
  digitalWrite(TTLsoundA, HIGH); 
  digitalWrite(TTLsoundB, LOW);     
  digitalWrite(TTLshock, LOW); 
  time_now = millis();
  while(millis() < time_now + 4500){
  }

  digitalWrite(TTLsoundcue, LOW);         
  digitalWrite(TTLsoundA, HIGH);  
  digitalWrite(TTLsoundB, LOW);    
  digitalWrite(TTLshock, HIGH); 
  time_now = millis();
  while(millis() < time_now + 500){
  }

  digitalWrite(TTLsoundcue, LOW);         
  digitalWrite(TTLsoundA, LOW);
  digitalWrite(TTLsoundB, LOW);      
  digitalWrite(TTLshock, LOW);
  time_now = millis();
  while(millis() < time_now + 2000){
  }
}


void safesound()
{
  unsigned long time_now = millis();
  while(millis() < time_now + 1000){
  }
        
  digitalWrite(TTLsoundcue, HIGH); 
  digitalWrite(TTLsoundA, LOW);        
  digitalWrite(TTLsoundB, LOW);      
  digitalWrite(TTLshock, LOW); 
  time_now = millis();
  while(millis() < time_now + 2000){
  }

  digitalWrite(TTLsoundcue, LOW); 
  digitalWrite(TTLsoundA, LOW);        
  digitalWrite(TTLsoundB, LOW);      
  digitalWrite(TTLshock, LOW); 
  time_now = millis();
  while(millis() < time_now + 2000){
  }

  digitalWrite(TTLsoundcue, LOW);
  digitalWrite(TTLsoundA, LOW);         
  digitalWrite(TTLsoundB, HIGH);      
  digitalWrite(TTLshock, LOW); 
  time_now = millis();
  while(millis() < time_now + 5000){
  }

  digitalWrite(TTLsoundcue, LOW); 
  digitalWrite(TTLsoundA, LOW);        
  digitalWrite(TTLsoundB, LOW);      
  digitalWrite(TTLshock, LOW);
  time_now = millis();
  while(millis() < time_now + 2000){
  }
}


void loop() 
{  
  if (Serial.available()) {
  {
    incomingBonsai = Serial.read();
    
  }
   if (incomingBonsai == 1)
    unsigned long time_now = millis();
    while(millis() < time_now + 1000){
    }
    
    for(int i = 0; i<1;)
    {  
      digitalWrite(TTLsoundcue, HIGH);         
      digitalWrite(TTLsoundA, LOW);      
      digitalWrite(TTLshock, LOW); 
      time_now = millis();
      while(millis() < time_now + 2000){
      }

      digitalWrite(TTLsoundcue, LOW);         
      digitalWrite(TTLsoundA, LOW);      
      digitalWrite(TTLshock, LOW); 
      time_now = millis();
      while(millis() < time_now + 2000){
      }

      digitalWrite(TTLsoundcue, LOW);         
      digitalWrite(TTLsoundA, HIGH);      
      digitalWrite(TTLshock, LOW); 
      time_now = millis();
      while(millis() < time_now + 4500){
      }

      digitalWrite(TTLsoundcue, LOW);         
      digitalWrite(TTLsoundA, HIGH);      
      digitalWrite(TTLshock, HIGH); 
      time_now = millis();
      while(millis() < time_now + 500){
      }

      digitalWrite(TTLsoundcue, LOW);         
      digitalWrite(TTLsoundA, LOW);      
      digitalWrite(TTLshock, LOW);
      time_now = millis();
      while(millis() < time_now + 2000){
      }
      i = i + 1;
    }   
  }
}
    
    
      
