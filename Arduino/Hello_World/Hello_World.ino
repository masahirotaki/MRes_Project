void setup() {
  //initialise Serial port
  Serial.begin(9600);
}

void loop() {
  int a;
  int b;
  float result;

  //print instructions, and wait until there is something in the serial buffer
  Serial.print("Enter a side value: ");
  while(!Serial.available());
  a = readSerial();
    if(a == 0)
    {
      return;
    }
  Serial.print("Enter the other side value: ");
  while(!Serial.available());
  b = readSerial();
    if(b == 0)
    {
      return;
    }
  findSide(a,b);
  
  Serial.println();
}

//readSerial takes the next integer in the Serial buffer, clears the buffer, then returns it
int readSerial()
{
  int i = Serial.parseInt();

  //checks if the received value is a valid integer
  if(i < 1 || (i%1 != 0))
  {
    Serial.println("That isn't a valid integer");
    return 0;
  }
  Serial.println(i);
  Serial.parseInt();
  return i;
}

void findSide(int x, int y)
{
  //calculate C squared by A squared + B squared
  float hypotenuse = sqrt(x*x + y*y);
  
  //print out the result
  Serial.print("Hypotenuse = ");
  Serial.println(hypotenuse);
}
