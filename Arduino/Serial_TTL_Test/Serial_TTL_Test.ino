const int TTL1 = 4;
const int TTL2 = 7;
const int TTL3 = 8;
const int TTL4 = 12;

int response;
int state = 0;
char data; 
int door = 0;

void safesound()
{
  //  Sound           
  Serial.println('2');
  digitalWrite(TTL2, HIGH);  
  digitalWrite(TTL3, LOW); 
  digitalWrite(TTL4, LOW);     
  delay(5000);

  Serial.println('3');
  digitalWrite(TTL2, LOW);  
  digitalWrite(TTL3, LOW);
  digitalWrite(TTL4, LOW); 
  delay(1); 
      
}


void fearsound()
{
  Serial.println('4');
  digitalWrite(TTL2, LOW);  
  digitalWrite(TTL3, HIGH); 
  digitalWrite(TTL4, LOW);  
  delay(4500);        

  Serial.println('5');
  digitalWrite(TTL2, LOW);  
  digitalWrite(TTL3, HIGH); 
  digitalWrite(TTL4, HIGH);        
  delay(500);

  Serial.println('6');
  digitalWrite(TTL2, LOW);  
  digitalWrite(TTL3, LOW); 
  digitalWrite(TTL4, LOW);   
  delay(1);     
}

void setup() {
  // setup pin modes
  pinMode(TTL1,OUTPUT);
  pinMode(TTL2, OUTPUT);         
  pinMode(TTL3, OUTPUT); 
  pinMode(TTL4,OUTPUT);                   
  Serial.begin(9600);
}


void loop() 
{  
  digitalWrite(TTL1, HIGH); 
  if (state == 0 && door == 0)
  {
    door = 1;
    delay(1000);
    Serial.println('1');
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
        delay(3000);

        fearsound();
        delay(10);
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
