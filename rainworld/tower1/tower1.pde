import java.util.*;

PVector origin;
color bg;

color gold = #ffc740;

PImage tower;
PImage towerLights;
PImage bg1;
PImage bg2;

PImage[] cat;
PImage[] catMask;

String[] sky;

PImage[] karma;

ParticleSystem ps;

int frameRateConst = 24;
int frameLimit = 200;
void setup() {
  size(1280, 720);
  
  tower = loadImage("Untitled-Artwork-2.png");
  towerLights = loadImage("Untitled-Artwork-3.png");
  bg1 = loadImage("Untitled-Artwork-5.png");
  bg2 = loadImage("Untitled-Artwork-4.png");
  
  cat = loadRange("Untitled-Artwork-", 7, 23, ".png", 9);
  catMask = load("mask", 9, ".png");
  
  sky = loadStr("/home/account/Videos/psychedelic_sky_islands/sky/windowRain/", 800, ".jpg");
  
  karma = loadKarma();
  
  frameRate(frameRateConst);
  strokeWeight(2);
  origin = new PVector(width/2, height/2);
  
  imageMode(CENTER);
}

void draw() {
  int fC = (frameCount % frameLimit)/2;
  float fC2 = (frameCount % frameLimit)/2;
  background(100);
  
  tint(255, 255);
  showFrame(sky, 0, 0, 0, 1280, 720, 0, frameCount*10);
   
  fill(#927EFF, 65);
  rect(0, 0, width, height);
  
  line(origin.x, height, origin.x, 0);
  
  /*
  noFill();
  stroke(#EAC1FD);
  expandingShape();
  */
  
  image(tower, origin.x - 25, origin.y, 1280, 720);
  
  tint(255, sin(fC/4.0)*255);
  image(towerLights, origin.x - 25, origin.y, 1280, 720);
  
  tint(255, 170);
  image(bg2, origin.x, origin.y, 1280, 720);
  tint(255, 255);
  image(bg1, origin.x, origin.y, 1280, 720);
  
  // showFrameBounce(PImage[] array, float deg, float x, float y, float h, float w, int shift, int fC)
  tint(#7575DF, 255);
  showFrameBounce(catMask, 0, 0, 50, 1100, 618.75, 0, fC);
  tint(#17174D, 255);
  showFrameBounce(cat, 0, 0, 50, 1100, 618.75, 0, fC);
  
  imageMode(CORNER);
  image(fernField(500, #17174D, #17174d, 0, 0, height, 150), 0, 0);
  
  if (frameCount <= frameLimit)
    // saveFrame("save/"+frameCount+".png");
   
  print(frameCount, "\n");
}
