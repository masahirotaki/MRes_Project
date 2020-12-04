const byte TTL1 = 4;
const byte TTL2 = 7;
const byte TTL3 = 8;
char incomingBonsai;
unsigned long time_now = 0;

void fearsound()
{
  unsigned long currentTime = millis();
  
  //  Sound           
  digitalWrite(TTL2, HIGH);  
  digitalWrite(TTL3, LOW);      
  time_now = millis();
  while(millis() < time_now + 5000){
  }

  digitalWrite(TTL2, LOW);  
  digitalWrite(TTL3, LOW);    
}


void safesound()
{
  unsigned long time_now = millis();
    
  digitalWrite(TTL2, LOW); 
  digitalWrite(TTL3, HIGH);        
  time_now = millis();
  while(millis() < time_now + 4500){
  }

  digitalWrite(TTL2, HIGH); 
  digitalWrite(TTL3, HIGH);        
  time_now = millis();
  while(millis() < time_now + 500){
  }

  digitalWrite(TTL2, LOW); 
  digitalWrite(TTL3, LOW);        
}

void setup() {
  // setup pin modes
  pinMode(TTL1,OUTPUT);
  pinMode(TTL2, OUTPUT);         
  pinMode(TTL3, OUTPUT);                    
  Serial.begin(115200);
}


void loop() 
{  
  digitalWrite(TTL1, HIGH); 
  if (Serial.available())  
  {
    incomingBonsai = Serial.read();
  }
  
  if (incomingBonsai == '1')
  {  
    safesound();  
    time_now = millis();
    while(millis() < time_now + 1000){
    }

    fearsound(); 
    time_now = millis();
    while(millis() < time_now + 5000){
    }
    
    fearsound();
    time_now = millis();
    while(millis() < time_now + 500){
    }
    
    safesound();
    time_now = millis();
    while(millis() < time_now + 1000){
    }
    
    safesound();
    time_now = millis();
    while(millis() < time_now + 300){
    }
    
    fearsound();
    time_now = millis();
    while(millis() < time_now + 2000){
    }
    
    safesound();
    time_now = millis();
    while(millis() < time_now + 1000){
    }
    
    fearsound();
    time_now = millis();
    while(millis() < time_now + 2000){
    }
    
    fearsound();
    time_now = millis();
    while(millis() < time_now + 3000){
    }
    
    safesound(); 
    time_now = millis();
    while(millis() < time_now + 500){
    }
  }  
}
