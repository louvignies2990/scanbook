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

