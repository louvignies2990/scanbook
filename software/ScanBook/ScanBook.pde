void setup() {
  initBookScan("input/test4.JPG");
  loadPicture("input/test4.JPG");
  autoDetect();
  getPages();
  //savePages(); 
  drawWindow();
}
void draw() {
  println("FPS: "+frameRate);
}
