
#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/sleep.h>
#include <avr/wdt.h>

const int vauhti=8;

ISR(WDT_vect) {}

void nokosleep(int secs){
  while (secs>vauhti) {
    wdt_enable(WDTO_8S);
    WDTCR |= (1<<WDIE) ;
    sleep_mode();
    wdt_disable();
    secs=secs-vauhti-1;
  }
  delay(secs*100);
 }

const int red=PB3;
const int green=PB4;
const int netti=PB0;
int halytys=0;

void kyttays() {
  if (halytys==1) {
    digitalWrite(netti,HIGH);
    nokosleep(40);
    digitalWrite(netti,LOW);
  }
  else halytys=1;
  for(int i=1;i<20;i++){
    digitalWrite(red,LOW);
    delay(30);
    digitalWrite(red,HIGH);
    nokosleep(30);
  }
}
  

void setup() {
  DIDR0 = 0x3F; //Disable digital input buffers on all ADC0-ADC5 pins.
  sei(); // Enable global interrupts  
  set_sleep_mode(SLEEP_MODE_PWR_DOWN);// Use the Power Down sleep mode
  analogReference(DEFAULT);  // Use Vcc as reference (or INTERNAL for 1.1V)
  pinMode(green, OUTPUT);
  pinMode(red, OUTPUT);
  pinMode(netti, OUTPUT);
  digitalWrite(green, HIGH);
  digitalWrite(red, HIGH);
  digitalWrite(netti,HIGH);
  delay(1000);
  digitalWrite(green, LOW);
  delay(1000);
  digitalWrite(red, LOW);
  delay(1000);
  digitalWrite(green, HIGH);
  digitalWrite(red, HIGH);
  delay(5000);
  digitalWrite(netti,LOW);
}

void loop() {
  digitalWrite(netti,LOW);
  digitalWrite(green, HIGH);
  digitalWrite(red, HIGH);
  int adc_value = (analogRead(1)/10)-40;  
  digitalWrite(green,LOW);
  delay(30);
  digitalWrite(green,HIGH);
  if (adc_value<0) {
    digitalWrite(red,LOW);
    kyttays();
  }
  else if (adc_value>10) kyttays();
  else halytys=0;
  nokosleep(30);
}

