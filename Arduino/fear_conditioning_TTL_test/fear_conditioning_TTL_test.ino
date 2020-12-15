const int TTL1 = 4;
const int TTL2 = 7;
const int TTL3 = 8;
int TTL4 = 12;
int response;
int state = 0;
char data; 
char door = '0';

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
  pinMode(TTL4,INPUT);                   
  Serial.begin(9600);
}


void loop() 
{  
  digitalWrite(TTL1, HIGH); 
  if (digitalRead(TTL4) == HIGH && door == '0')
  {
    door = '1';
    delay(1000);
    Serial.println('1');
  }

  if (digitalRead(TTL4) == LOW)
  {
  door = '0';    
  }

  if (state == 1)
  {
    response = 0;
    state = 0;
  }
  
  else if (state == 0)
    if (response == 1)
      {  
        response = 0;
        state = 1;
        safesound();  
        delay(1000);
    
        fearsound(); 
        delay(5000);
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
