#include <iostream>
#include <wiringPi.h>
#include <fstream>
#include <cmath>
#include <cstdlib>
//#define TRIG 4	//Wiring Pi
//#define ECHO 5	//Wiring Pi
using namespace std;
int trig=4, echo=5;
/* In the directory: of SonarAlone.c:
1)  [ sudo ../../pi-blaster/pi-blaster ] if servo
2)  g++  SonarAlone.c -l wiringPi -o  SonarAlone
*/
void setup(){
	wiringPiSetup();
	pinMode(trig, OUTPUT);
	pinMode(echo, INPUT);
	//TRIG pin must start LOW
	digitalWrite(trig, LOW);
	delay(30);
}
int getCM(){
	//Send trig pulse
	digitalWrite(trig, HIGH);
	delayMicroseconds(20);
	digitalWrite(trig, LOW);

	//Wait for echo start
	while (digitalRead(echo)==LOW);

	//Wait for echo end
	long startTime=micros();
	while (digitalRead(echo)==HIGH);
	long travelTime=micros()-startTime;

	//Get distance in cm
	int distance=travelTime/58;

	return distance;
}
int main(int argc, char* argv[]){
	if (argc>=2){
		trig=atoi(argv[1]);
		echo=atoi(argv[2]);
	}
	setup();
	while (1){
		int cm=getCM();
		cout<<cm<<endl;
		delay(300);
	}
	return 0;
}
