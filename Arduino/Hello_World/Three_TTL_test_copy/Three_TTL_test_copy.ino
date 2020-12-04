const int TTLLight = 4;
const int TTLtone = 7;
const int TTLnoise = 8;

void setup() {
  // setup pin modes
  pinMode(TTLLight, OUTPUT);         
  pinMode(TTLtone, OUTPUT);      
  pinMode(TTLnoise, OUTPUT);               
  Serial.begin(9600);
}

void loop() 
{
  digitalWrite(TTLLight, HIGH);         
  digitalWrite(TTLtone, LOW);      
  digitalWrite(TTLnoise, LOW); 
  delay(1000);

  digitalWrite(TTLLight, LOW);         
  digitalWrite(TTLtone, LOW);      
  digitalWrite(TTLnoise, LOW); 
  delay(500);

  digitalWrite(TTLLight, LOW);         
  digitalWrite(TTLtone, HIGH);      
  digitalWrite(TTLnoise, LOW); 
  delay(1000);
  
  digitalWrite(TTLLight, LOW);         
  digitalWrite(TTLtone, HIGH);      
  digitalWrite(TTLnoise, HIGH); 
  delay(1000);

  digitalWrite(TTLLight, LOW);         
  digitalWrite(TTLtone, LOW);      
  digitalWrite(TTLnoise, LOW);
  delay(1000);

}
    
    
      
