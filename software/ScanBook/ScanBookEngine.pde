import gab.opencv.*;
import org.opencv.imgproc.Imgproc;
import org.opencv.core.MatOfPoint2f;
import org.opencv.core.Point;
import org.opencv.core.Size;
import org.opencv.core.Mat;
import org.opencv.core.CvType;
import java.util.*;
void initBookScan(String path) {
  loadPicture(path);
  outputPath = "output/";
  opencv = new OpenCV(this,picture);
<<<<<<< HEAD
  ppi = 96;
=======
  opencv.useGray();
  
  previewOCV = new OpenCV(this,pictureSmall);
  previewOCV.useGray();
  
  ppi = 96;
  threshold=40;
  
>>>>>>> ee07bd95062f502a232245e4e8ed88c492c8a0d2
  f = createFont("Georgia", 11);
  textFont(f);
  pages = new ArrayList<PImage>();
  pages.add(new PImage(10,10));
  pages.add(new PImage(10,10));
  initGUI(); 
}
void loadPicture(String path) {
  picture = loadImage(path);
<<<<<<< HEAD
  minArea = (picture.width*picture.height)/5;
=======
  pictureSmall = loadImage(path);
  pictureSmall.resize(400,300);
  minArea = (picture.width*picture.height)/4;
>>>>>>> ee07bd95062f502a232245e4e8ed88c492c8a0d2
}
int autoDetect() {
  opencv.loadImage(picture);
<<<<<<< HEAD
  opencv.blur(1);
  opencv.threshold(25); 
=======
  //opencv.blur(5);
  opencv.threshold(threshold);
  
>>>>>>> ee07bd95062f502a232245e4e8ed88c492c8a0d2
  ArrayList<Contour> contours = opencv.findContours(false, true);
  Contour cont = null;
  PVector tab[];
  int n;
  println(contours.size() + " contours found in the picture");
  for(int i=0;i<contours.size();i++) {
    cont = contours.get(i).getPolygonApproximation();
<<<<<<< HEAD
    //drawContour(cont);
    println("Contour "+(i+1)+" : "+cont.getPoints()+" points");
    if(cont.area()>=minArea&&cont.getPoints().size()>3) { 
      println("contour has been selected");
=======
    //drawContour(cont,"c",true);
    println("Contour "+(i+1)+" : "+cont.getPoints().size()+" points , size : "+cont.area());
    if(cont.getPoints().size()==6 && cont.area()>=minArea) {
      //println("a contour has been selected");
>>>>>>> ee07bd95062f502a232245e4e8ed88c492c8a0d2
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
  pages.set(0,createImage(pageWidth, pageHeight, ARGB));
  pages.set(1,createImage(pageWidth, pageHeight, ARGB));
  ArrayList<PVector> points1 = new ArrayList<PVector>();
  Collections.sort(points1,new comp());
  for(int i=0;i<(points1.size()-1);i++) {
  println(i, contour.getPoints().get(i).x, contour.getPoints().get(i).y);}
//  if (contour.getPoints().size()==4){
//  points1.add(contour.getPoints().get(0));
//  points1.add(contour.getPoints().get(1));
//  points1.add(contour.getPoints().get(2));
//  points1.add(contour.getPoints().get(3));
//opencv.toPImage(warpPerspective(points1, pageWidth, pageHeight), pages.get(0)); }
//  if(contour.getPoints().size()==6)
//  {
//    points1.add(contour.getPoints().get(1));
//  points1.add(contour.getPoints().get(4));
//  points1.add(contour.getPoints().get(5));
//  points1.add(contour.getPoints().get(0));
//  opencv.toPImage(warpPerspective(points1, pageWidth, pageHeight), pages.get(0)); 
//}
//if(contour.getPoints().size()==7)
//  {
//    points1.add(contour.getPoints().get(2));
//  points1.add(contour.getPoints().get(5));
//  points1.add(contour.getPoints().get(6));
//  points1.add(contour.getPoints().get(0));
//  opencv.toPImage(warpPerspective(points1, pageWidth, pageHeight), pages.get(0)); 
//}
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
public class comp
        implements Comparator<PVector> {

        public int compare(final Point a, final Point b) {
            if (a.x < b.x) {
                return -1;
            }
            else if (a.x > b.x) {
                return 1;
            }
            else {
                return 0;
            }
        }
    }
