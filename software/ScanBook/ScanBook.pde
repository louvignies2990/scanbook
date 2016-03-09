<<<<<<< HEAD
void setup() {
  initBookScan("input/test4.JPG");
  loadPicture("input/test4.JPG");
  autoDetect();
  getPages();
  //savePages(); 
  drawWindow();
=======
boolean continuer = false;
void setup() {
  initBookScan("input/DSCN1723.JPG");
  loadPicture("input/DSCN1723.JPG");
  
}

void keyPressed() {
  if (keyCode == UP && threshold <= 250) {
    threshold+=5;
  } else if (keyCode == DOWN && threshold >= 5) {
    threshold-=5;
  } else if (keyCode == ENTER) {
    continuer = true;
  }
  //opencv.loadImage(picture);
  //opencv.threshold(threshold);
  drawThreshold();
  println("Threshold = " + threshold);
>>>>>>> ee07bd95062f502a232245e4e8ed88c492c8a0d2
}
void draw() {
  //println("FPS: "+frameRate);
  if(continuer) {  
    autoDetect();
    drawThreshold();
    if(contour!=null) {
      getPages();
      savePages();
      drawWindow();
    }
  }
  continuer = false;
  
}
