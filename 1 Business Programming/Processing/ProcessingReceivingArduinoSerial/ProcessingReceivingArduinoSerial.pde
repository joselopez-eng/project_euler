
import processing.serial.*;
import java.util.*;


Serial myPort; // Create object from the serial class




String values; // store the data received from the serial port
int largestValue = 0;
int distance = 0;
int angle = 0;
int baseUnit = 800/100; // We want a scale factor so 8 vertical pixels equal 1cm in distance
int yPos = height;
int distanceFromCenter;
int dy = 20;
boolean isHitting = false;
int scale = int((.85)*width);
PImage img;

/*Is there a way to skip a method for a certain amount of time?*/
void setup()
{
    size(1600,800);
    surface.setResizable(true);
    String portName = Serial.list()[1];
    myPort = new Serial(this,portName,9600); 
   
    
    img = loadImage("pimage.png");
    background(50);
    delay(90); //This delay is important since it allows the arduino and processing continue to start without stopping the program
}
void draw()
{
   //background(60);
  //  println(myPort.size());
    if(myPort.available()>0)
    {
        // if the data is available
        //values.trim()
        values = myPort.readString();//reads the inputted string until the new line character
       
        
       
           /*Code to parse the string and store the values into angle and distance*/
           int index1 = values.indexOf(" ");
           String angleString = values.substring(0,index1);
           String distanceString = values.substring(angleString.length()+1, values.length());
           
           //storng values into angle and distance
           angle = int(angleString);
           distance = int(distanceString.trim());
          
         
           pushMatrix();
           //translate(0,-40);
           translate(0,-height/20);
           textSize(40);
           drawLine();
           drawObject();
           drawPolarGrid();
           popMatrix();
           drawData();
           if(angle==180)
              
           image(img,0,height-50,300,75);
           
           // distance = int(valuesSplit[1]);
        
       myPort.clear();//clears the serial port list of inputted distances
    }

     
} 
void drawObject()
{
    pushMatrix();
    translate(width/2,height);
    strokeWeight(9);
    stroke(255,25,25);
    //int distancePixels = distance*baseUnit;
    int distancePixels = (width/200)*distance;
    //int distancePixels = (width/180)*distance;
    if(distance<100)
    {
        //line(distancePixels*cos(radians(angle)),-distancePixels*sin(radians(angle)),950*cos(radians(angle)),-950*sin(radians(angle)));
        //I am not scaling the starting point
        line(distancePixels*cos(radians(angle)),-distancePixels*sin(radians(angle)),(width/2)*cos(radians(angle)),(-width/2)*sin(radians(angle)));
    }
    popMatrix();
    
}
    
void drawLine()
{
    
    pushMatrix();
    strokeWeight(9);
    stroke(50,220,255);
    translate(width/2,height);
    //line(0,0,height*.95*cos(radians(angle)),-height*.95*sin(radians(angle)));
    line(0,0,(width/2)*cos(radians(angle)), (-width/2)*sin(radians(angle)));
 
    popMatrix();
    
    
    
    
    
}
void drawPolarGrid()
{
        int diameter = width;
        int store = width/2;
        
        //int diameter = width-(width/20);
        int size = 100;
    for(int i = 0; i < 10; i ++)
    {   stroke(50,150,255);
        strokeWeight(3);
        noFill();
        
        arc((width/2),height,diameter,diameter,PI,PI+PI);
        textSize(20);
        stroke(0);
        fill(255);
        int cm = 100-(i*10);
        text("  "+ cm,(width/2)+diameter/2,height-(height/40));
        text("  "+ cm,(width/2)-diameter/2,height-(height/40));
        text(""+ cm,(width/2), height-(diameter/2));
        diameter= diameter-(width/10);
        
        stroke(0);
        
    }
        textSize(40);
    
}

void drawData()
{
   
   // rect(0,0,width,height/30);
   //stroke(50,150,255);
    fill(30);
    rect(0,height-(height/19),width,height/20);
    
    //Text Display the Data on Distance and Angle
    fill(255);
    text("Distance: " + distance, width-(width/2),height-(height/100));
    text("Angle: " + angle, width-(width/5), height-(height/100));
    
}

void mousePressed()
{
    redraw();
}

 