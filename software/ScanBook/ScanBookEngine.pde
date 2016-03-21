import gab.opencv.*;
import org.opencv.imgproc.Imgproc;
import org.opencv.core.MatOfPoint2f;
import org.opencv.core.Point;
import org.opencv.core.Size;
import org.opencv.core.Mat;
import org.opencv.core.CvType;
import java.util.*;
import java.util.Comparator;
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
  minArea = (picture.width*picture.height)/5;
}
int autoDetect() {
  opencv.loadImage(picture);
  opencv.blur(1);
  opencv.threshold(50); 
  ArrayList<Contour> contours = opencv.findContours(false, true);
  Contour cont = null;
  PVector tab[];
  int n;
  println(contours.size() + " contours found in the picture");
  for(int i=0;i<contours.size();i++) {
    cont = contours.get(i).getPolygonApproximation();
    //drawContour(cont);
    //println("Contour "+(i+1)+" : "+cont.getPoints()+" points");
    if(cont.area()>=minArea&&cont.getPoints().size()>3) { 
      println("contour has been selected");
      contour = cont;
      println(cont.getPoints());
      //println("Contour "+(i+1)+" : "+contour.getPoints().size()+" points , size : "+contour.area());
    }
  }
  if (cont!=null) {
   println("contour found");
  return 0;
  }
  else { // si aucun contour trouvé
    return -1;
  }
}
int getPages() { 
  int pageWidth = (int)(ppi*8.267);  // in inches
  int pageHeight = (int)(ppi*11.692);
  println(pageWidth);
  println(pageHeight);
  pages.set(0,createImage(pageWidth, pageHeight, ARGB));
  pages.set(1,createImage(pageWidth, pageHeight, ARGB));
  ArrayList<PVector>points1=new ArrayList<PVector>();
  ArrayList<PVector>points2=new ArrayList<PVector>();
  points1=tri();
    points2.add(points1.get(3));//coin supérieur gauche
    points2.add(points1.get(4));//coin inférieur gauche
    points2.add(points1.get(5));//coin inférieur droit
    points2.add(points1.get(2));//coin supérieur droit
    opencv.toPImage(warpPerspective(points2, pageWidth, pageHeight), pages.get(0)); 
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
ArrayList tri()
{
  ArrayList<PVector> points = contour.getPoints();
  ArrayList<PVector>temp=new ArrayList<PVector>();
  for(int r=0;r<points.size();r++){
  temp.add(new PVector (0,0,0));
  }
  PVector prem= new PVector(0,0,0);
  boolean listordo=false;
  int taille=points.size();
  while(!listordo)
  {
    listordo=true;
  for(int i=0;i<(points.size()-1);i++) {
    if(points.get(i).x>prem.x)
    {
      prem.set(points.get(i));
      listordo=false;
    }
  }
  taille--;
  }
  for(int i=0;i<(points.size()-1);i++) {
   if(points.get(i).x==prem.x){ 
     for(int a=0;a<i;a++){
       temp.set(a,points.get(a));
     }
     for(int z=i;z<points.size();z++){
       points.set(z-i,points.get(z));
     }
     for(int e=(points.size())-i;e<points.size();e++){
       points.set(e,temp.get(e-points.size()+i));
     }
   }
  }
  return points;
}
