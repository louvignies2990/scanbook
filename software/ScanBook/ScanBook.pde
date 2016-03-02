
void setup() {
  initBookScan("input/IMG_1801_bis.JPG");
  loadPicture("input/IMG_1801_bis.JPG");
  autoDetect();
  getPages();
  savePages();
  
  drawWindow();
}

void draw() {
  println("FPS: "+frameRate);
}

