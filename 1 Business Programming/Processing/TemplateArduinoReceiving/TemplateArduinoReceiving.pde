
import processing.serial.*;
import java.util.*;


Serial myPort; 
Scanner scan;
int startX;
int startY;
int sDim = 200;
int count = 0;
int tCRT = 0; 


void setup()
{
    size(1280,720,P3D);
   String portName = Serial.list()[1];
   
   myPort = new Serial(this,portName,9600);
   
   
}


void draw()
{
    
    background(122);
    lights();
    
    if(myPort.available()>0)
    {
        scan = new Scanner(myPort.readString());
        while(scan.hasNextInt())
        {
            tCRT = scan.nextInt();
        }
        print(tCRT);
    }
}