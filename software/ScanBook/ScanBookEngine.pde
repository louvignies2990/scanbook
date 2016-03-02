import gab.opencv.*;
import org.opencv.imgproc.Imgproc;
import org.opencv.core.MatOfPoint2f;
import org.opencv.core.Point;
import org.opencv.core.Size;

import org.opencv.core.Mat;
import org.opencv.core.CvType;

void initBookScan(String path) {
  
  loadPicture(path);
  outputPath = "output/";
  
  opencv = new OpenCV(this,picture);
  
  ppi = 96;
  
  f = createFont("Georgia", 11);
  textFont(f);
  
  pages = new ArrayList<PImage>();
  pages.add(new PImage(10,10));
  pages.add(new PImage(10,10));
  
  initGUI();
  
}

void loadPicture(String path) {
  picture = loadImage(path);
  minArea = (picture.width*picture.height)/4;
}

int autoDetect() {
  opencv.loadImage(picture);
  opencv.blur(1);
  opencv.threshold(20);
  
  ArrayList<Contour> contours = opencv.findContours(false, true);
  Contour cont = null;
  //println(contours.size() + " contours found in the picture");
  for(int i=0;i<contours.size();i++) {
    cont = contours.get(i).getPolygonApproximation();
    //drawContour(cont,"c",true);
    //println("Contour "+(i+1)+" : "+cont.getPoints().size()+" points , size : "+cont.area());
    if(cont.getPoints().size()==6 && cont.area()>=minArea) {
      //println("a contour has been selected");
      contour = cont;
      //println("Contour "+(i+1)+" : "+contour.getPoints().size()+" points , size : "+contour.area());
    }
  }
  if (cont!=null) {
    return 0;
  }
  else { // si aucun contour trouvé
    return -1;
  }
}

int getPages() {
  
  int pageWidth = (int)(ppi*8.267);  // in inches
  int pageHeight = (int)(ppi*11.692);
  
  pages.set(0,createImage(pageWidth, pageHeight, ARGB));
  pages.set(1,createImage(pageWidth, pageHeight, ARGB));
  
  ArrayList<PVector> points1 = new ArrayList<PVector>();
  ArrayList<PVector> points2 = new ArrayList<PVector>();
  
  points1.add(contour.getPoints().get(0));
  points1.add(contour.getPoints().get(1));
  points1.add(contour.getPoints().get(2));
  points1.add(contour.getPoints().get(5));
  
  points2.add(contour.getPoints().get(5));
  points2.add(contour.getPoints().get(2));
  points2.add(contour.getPoints().get(3));
  points2.add(contour.getPoints().get(4));
  
  opencv.toPImage(warpPerspective(points1, pageWidth, pageHeight), pages.get(0));
  opencv.toPImage(warpPerspective(points2, pageWidth, pageHeight), pages.get(1));
  
  return 0;
}


void savePages() {
  pages.get(0).save(outputPath+"page1.jpg");
  pages.get(1).save(outputPath+"page2.jpg");
}

private Mat getPerspectiveTransformation(ArrayList<PVector> inputPoints, int w, int h) {
  
  // destination points : rectangle of size (w,h)
  Point[] canonicalPoints = new Point[4];
  canonicalPoints[0] = new Point(0, 0);
  canonicalPoints[1] = new Point(0, h);
  canonicalPoints[2] = new Point(w, h);
  canonicalPoints[3] = new Point(w, 0);

  MatOfPoint2f canonicalMarker = new MatOfPoint2f(canonicalPoints);
  
  // source points
  // convert form an arraylist to an array
  Point[] points = new Point[4];
  for (int i = 0; i < 4; i++) {
    points[i] = new Point(inputPoints.get(i).x, inputPoints.get(i).y);
  }
  MatOfPoint2f marker = new MatOfPoint2f(points);
  
  return Imgproc.getPerspectiveTransform(marker, canonicalMarker);
}

private Mat warpPerspective(ArrayList<PVector> inputPoints, int w, int h) {
  Mat transform = getPerspectiveTransformation(inputPoints, w, h);
  Mat unWarpedMarker = new Mat(w, h, CvType.CV_8UC1);  // matrix of pixels
  Imgproc.warpPerspective(opencv.getColor(), unWarpedMarker, transform, new Size(w, h));
  return unWarpedMarker;
}

