// Librairies
import controlP5.*;

// Objet spéciaux
ControlP5 Ctrl;

// Variables
private int widthW;
private int heightW;
private int space = 20;

private int pctWidth = 300;
private int pctHeight = 300;

private int tglWidth;
private int tglHeight = 25;

private int btnWidth;
private int btnHeight = 25;

private int sldWidth;
private int sldHeight = 25;
private int sldStartRange = 0;
private int sldEndRange = 255;
private int sldCurrentRange = 50;

// Objets graphiques
private Button btnStart,btnValider,btnFinLivre,btnNextPage,btnDetect,btnManuel;
private Slider sldRegTreshold;
private Toggle tglTreshold;
private PImage picture,picture1,picture2;

// INIT
void initGui()
 {
   widthW = ((3*pctWidth)+(4*space));
   heightW = ((pctHeight+btnHeight)+(3*space));
   size(widthW,heightW);
   background(100,100,100);
   Ctrl = new ControlP5(this);
   loadPictures();
   drawWindow();
 }

void loadPictures()
 {
   picture = loadPicture("PageTest.png");
   picture1 = loadPicture("PageTest.png");
   picture2 = loadPicture("PageTest.png");
 }
 
PImage loadPicture(String path)
 {
   PImage image = loadImage(path);
   image.resize(pctWidth,pctHeight);
   return image;
 }
 
// DRAW 
void drawWindow()
 {
   btnWidth = ((pctWidth-space)/2);
   tglWidth = pctWidth/5;
   sldWidth = pctWidth - space - tglWidth;
   drawControl();
   switchButton(false);
 }
 
void drawControl()
 {
   int pctPosX = space;
   int pctPosY = space;
   drawPicture(picture,pctPosX,pctPosY);
   btnStart = drawButton("Start",0,pctPosX,(pctPosY+pctHeight+space),btnWidth,btnHeight);
   btnValider = drawButton("Valider",0,(pctPosX+pctWidth-btnWidth),(pctPosY+pctHeight+space),btnWidth,btnHeight);
   pctPosX = pctPosX + space + pctWidth;
   drawPicture(picture1,pctPosX,pctPosY);
   sldRegTreshold = drawSlider("Reglage_Treshold",sldStartRange,sldEndRange,sldCurrentRange,pctPosX,(pctPosY+pctHeight+space),sldWidth,sldHeight);
   tglTreshold = drawToggle("ON_OFF",false,(pctPosX+space+sldWidth),(pctPosY+pctHeight+space),tglWidth,tglHeight);
   pctPosX = pctPosX + space + pctWidth;
   drawPicture(picture2,pctPosX,pctPosY);
   btnDetect = drawButton("Detect",0,pctPosX,(pctPosY+pctHeight+space),btnWidth,btnHeight);
   btnManuel = drawButton("Manuel",0,(pctPosX+pctWidth-btnWidth),(pctPosY+pctHeight+space),btnWidth,btnHeight);
   btnNextPage = drawButton("NextPage",0,pctPosX,(pctPosY+pctHeight+space),btnWidth,btnHeight);
   btnFinLivre = drawButton("FinLivre",0,(pctPosX+pctWidth-btnWidth),(pctPosY+pctHeight+space),btnWidth,btnHeight);
 }

void drawPicture(PImage image,int x,int y)
 {
   image(image,x,y);
 }
 
Button drawButton(String name,int value,int x,int y,int w,int h)
 {
    Button btn = Ctrl.addButton(name,value,x,y,w,h);
    return btn;
 }
 
Toggle drawToggle(String name,boolean value,int x,int y,int w,int h)
 {
    Toggle tgl = Ctrl.addToggle(name,value,x,y,w,h);
    tgl.setMode(ControlP5.SWITCH);
    Ctrl.getController(name).getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE).setPaddingX(0);
    return tgl;
 }
 
Slider drawSlider(String name,int start,int end,int current,int x,int y,int w,int h)
 {
   Slider sld=null;
   sld = Ctrl.addSlider(name,start,end,current,x,y,w,h);
   Ctrl.getController(name).getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE).setPaddingX(0);
   Ctrl.getController(name).getValueLabel().align(ControlP5.CENTER,ControlP5.CENTER).setPaddingX(0);
   return sld;
 }
  
// INTERRACT
// Bouton '+' et '-' pour le slider
void keyPressed()
 {
   if(key == '+')
    {
      float currentValue = sldRegTreshold.getValue();
      if(currentValue < 255)
       {      
         sldRegTreshold.setValue(currentValue+1);
       }
    }
   else if(key == '-')
    {
      float currentValue = sldRegTreshold.getValue();
      if(currentValue > 0)
       {      
         sldRegTreshold.setValue(currentValue-1);
       }
    }
 }

void switchButton(boolean value)
 {
   if(value)
    {
       btnDetect.hide();
       btnManuel.hide();
       btnNextPage.show(); 
       btnFinLivre.show(); 
    }
   else
    {
       btnNextPage.hide(); 
       btnFinLivre.hide();
       btnDetect.show();
       btnManuel.show();
    }
 }

// Bouton Start
void Start(int value)
 {
   println("Bouton START : click !");
 }

// Bouton Valider
void Valider(int value)
 {
   println("Bouton VALIDER : click !");
 }

// Bouton NextPage
void NextPage(int value)
 {
   println("Bouton NEXTPAGE: click !");
 } 
 
// Bouton FinLivre
void FinLivre(int value)
 {
   println("Bouton FINLIVRE: click !");
 }

// Bouton Detect
void Detect(int value)
 {
   println("Bouton DETECT: click !");
 } 
 
// Bouton Manuel
void Manuel(int value)
 {
   println("Bouton MANUEL: click !");
 }
 
// Toggle treshold
void ON_OFF(boolean value)
 {
   println("Toggle : " + value);
 }
 
// Slider à la 'main'
void Reglage_Treshold(int value)
 {
   println("Valeur : " + value);  
 }
