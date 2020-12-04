const int TTL1 = 4;
const int TTL2 = 7;
const int TTL3 = 8;
int response;
char data = 0; 

void safesound()
{
  //  Sound           
  digitalWrite(TTL2, HIGH);  
  digitalWrite(TTL3, LOW);   
  delay(5000);

  digitalWrite(TTL2, LOW);  
  digitalWrite(TTL3, LOW);    
}


void fearsound()
{
  digitalWrite(TTL2, LOW); 
  digitalWrite(TTL3, HIGH);
  delay(4500);        

  digitalWrite(TTL2, HIGH); 
  digitalWrite(TTL3, HIGH);        
  delay(500);

  digitalWrite(TTL2, LOW); 
  digitalWrite(TTL3, LOW);        
}

void setup() {
  // setup pin modes
  pinMode(TTL1,OUTPUT);
  pinMode(TTL2, OUTPUT);         
  pinMode(TTL3, OUTPUT);                    
  Serial.begin(9600);
}


void loop() 
{  
  digitalWrite(TTL1, HIGH); 
  
  if (response == 1)
    {  
      safesound();  
      delay(1000);
  
      fearsound(); 
      delay(5000);
      
      fearsound();
      delay(500);
  
      
      safesound();
      delay(3000);
  
      safesound();
      delay(500);
  
      fearsound();
      delay(4000);
  }  
}


void serialEvent()
{
  while (Serial.available())  
  {
    data = (char)Serial.read();
    
    if (data == 'A')
    {  
      response = 1;
    }  
  }
}
