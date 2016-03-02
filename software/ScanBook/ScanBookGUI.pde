private int sizeX = 900;
private int sizeY = 640;


void initGUI() {
  size(sizeX,sizeY);
  background(100,100,100);
  raw = createGraphics(picture.width, picture.height);
}

void drawWindow() {
  image(pictureSmall,10,10,450,300);
  drawContour(10,10,450,300);
  drawPages();
}

void drawContour(int posX, int posY, int sizeX, int sizeY) {
  raw.beginDraw();
  
  ArrayList<PVector> points = contour.getPoints();
  raw.strokeWeight(16);
  raw.stroke(0, 255, 0);
  
  for(int i=0;i<(points.size()-1);i++) {
    raw.line(points.get(i).x,points.get(i).y,points.get(i+1).x,points.get(i+1).y);
  }
  raw.line(points.get(points.size()-1).x,points.get(points.size()-1).y,points.get(0).x,points.get(0).y);
   
  raw.endDraw();
  image(raw,posX,posY,sizeX,sizeY);
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

