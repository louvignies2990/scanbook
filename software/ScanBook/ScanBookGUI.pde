private int sizeX = 800;
private int sizeY = 640;

void initGUI() {
  size(sizeX,sizeY);
  background(100,100,100);
  raw = createGraphics(picture.width, picture.height);
}

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
  ArrayList<PVector> points = contour.getPoints();
  raw.strokeWeight(16);
  raw.stroke(0, 255, 0);
  
  for(int i=0;i<(points.size()-1);i++) {
    raw.line(points.get(i).x,points.get(i).y,points.get(i+1).x,points.get(i+1).y);
  }
  raw.line(points.get(points.size()-1).x,points.get(points.size()-1).y,points.get(0).x,points.get(0).y);
}

void drawPages(){
  image(pages.get(0), 10, 320,200,300);
  image(pages.get(1), 220, 320,200,300);
}

