private int sizeX = 900;
private int sizeY = 640;
<<<<<<< HEAD
=======


>>>>>>> ee07bd95062f502a232245e4e8ed88c492c8a0d2
void initGUI() {
  size(sizeX,sizeY);
  background(100,100,100);
  raw = createGraphics(picture.width, picture.height);
}
<<<<<<< HEAD
void drawWindow() { 
  drawRaw();
  drawPages();
}
void drawRaw() {
  raw.beginDraw();
  raw.image(picture,0,0);
  drawContour();
  raw.endDraw(); 
  image(raw,0,0,450,300);
}
void drawContour(){
=======

void drawWindow() {
  image(pictureSmall,10,10,450,300);
  drawContour(10,10,450,300);
  drawPages();
}

void drawContour(int posX, int posY, int sizeX, int sizeY) {
  raw.beginDraw();
  
>>>>>>> ee07bd95062f502a232245e4e8ed88c492c8a0d2
  ArrayList<PVector> points = contour.getPoints();
  raw.strokeWeight(16);
  raw.stroke(0, 255, 0); 
  raw.textFont(createFont("Georgia", 150));
  contour.draw();
  fill(200,200,200);
  int n;
  n=points.size()-1;
  for(int i=0;i<(points.size()-1);i++) {
    raw.line(points.get(i).x,points.get(i).y,points.get(i+1).x,points.get(i+1).y);
    raw.text(i, points.get(i).x, points.get(i).y);
  }
  raw.line(points.get(points.size()-1).x,points.get(points.size()-1).y,points.get(0).x,points.get(0).y);
<<<<<<< HEAD
  fill(255,0);
=======
   
  raw.endDraw();
  image(raw,posX,posY,sizeX,sizeY);
>>>>>>> ee07bd95062f502a232245e4e8ed88c492c8a0d2
}
void drawPages(){
  image(pages.get(0), 470, 10,200,300);
  image(pages.get(1), 680, 10,200,300);
}

void drawThreshold() {
  previewOCV.loadImage(pictureSmall);
  //previewOCV.blur(1);
  previewOCV.threshold(threshold);
  image(previewOCV.getSnapshot(), 10,320,450,300);
}
