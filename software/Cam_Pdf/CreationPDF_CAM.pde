import processing.video.*;
import processing.pdf.*;

PGraphicsPDF pdf;
Capture cam=null;
boolean photo=false;
boolean start=false;
boolean debut=false;

void setup() 
{
  size(640, 480);
  String[] cameras = Capture.list(); 
  if (cameras.length == 0) 
   {
      println("There are no cameras available for capture.");
      exit();
   } 
  else 
   {
      println("Available cameras:");
      for (int i = 0; i < cameras.length; i++) 
       {
          println(cameras[i]);
       }
      cam = new Capture(this, cameras[0]);
      cam.start();   
   }      
}

void keyPressed()
 {
   if(keyCode==UP)
    {
      if(start==false)
       {
         pdf = (PGraphicsPDF)beginRecord(PDF, "Test.pdf");  
         start=true;
       }
      if(photo==false)
       {
        photo=true;
       }
    }
   else if(keyCode==DOWN)
    {
      endRecord();
      exit();
    }    
 }
 
void draw() 
 {
    if(cam.available()) 
     {
        if(photo==true)
         {
           if(debut==false)
            {
              debut=true;
            }
           else
            {
              pdf.nextPage();
            }
           photo=false;
           cam.read();
           image(cam, 0, 0);
         }
     }
 }
