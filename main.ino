/*
        Arduino Brushless Motor Control
     by Dejan, https://howtomechatronics.com
*/

#include <Servo.h>
#include <HX711.h>
Servo ESC;     // create servo object to control the ESC

HX711 scale;


// Definición de pines
const int LOADCELL_DOUT_PIN = 2;
const int LOADCELL_SCK_PIN = 3;
int toggle = 0;
const int BUTTON_PIN = 4;

int potValue;  // value from the analog pin

  static unsigned long previousMillis = 0;        // will store last time LED was updated
  //const long interval = 1000;           // interval at which to blink (milliseconds)
  unsigned long currentMillis = millis();
  static bool estadoPin=false;
  int power;
  int currentIMStatusCode;
void setup() {
  pinMode(BUTTON_PIN, INPUT);
  Serial.begin(115200);

  // Inicialización de la celda de carga
  scale.begin(LOADCELL_DOUT_PIN, LOADCELL_SCK_PIN);
  
  // Calibración de la celda de carga (ajusta los valores según tu calibración)
  scale.set_offset(210139);
  scale.set_scale(463.471313);
  
  scale.tare(); // Establece el valor actual como tara


  // Attach the ESC on pin 9
  ESC.attach(9,1000,2000); // (pin, min pulse width, max pulse width in microseconds) 
  //delay(4000);
  //ESC.write(180);           // Ajuste de inicio para el ESC
  //delay(2000);
  //ESC.write(0);   
  //delay(1000);
  power=0;
}

void loop() {
  float weight = scale.get_units(); // Lee el valor en unidades (kg)

  static bool estadoPin=false;
  
  int buttonState = digitalRead(BUTTON_PIN); 
  
  if(buttonState == HIGH){
    toggle = 1;
  }


    Serial.print(power);    // Azul
    Serial.print(","); 
    Serial.print(weight);    // naranja oscuro
    Serial.print(",");
    Serial.print(potValue);
    Serial.println();
  

  potValue = analogRead(A0);   // reads the value of the potentiometer (value between 0 and 1023)
  power = map(potValue, 0, 1023, 0, 180);   // scale it to use it with the servo library (value between 0 and 180)
  
  // Lectura del valor de la celda de carga
  if(toggle == 0){
    ESC.write(power);    // Send the signal to the ESC
  }
  if(toggle == 1){
    
    power = 140;
    ESC.write(power);
  }
  
}