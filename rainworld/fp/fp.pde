import java.util.*;

PVector origin;
color bg;

color gold = #ffc740;

PImage[] fp;
PImage[] fpMask;
PImage[] cat;

PImage[] karma;

ParticleSystem ps;

int frameRateConst = 24;
int frameLimit = 337;
void setup() {
  size(500, 500);
  
  fpMask = bounceArray(loadRange("Untitled-Artwork-", 2, 9, ".png"));
  fp = bounceArray(loadRange("Untitled-Artwork-", 12, 19, ".png"));
  cat = bounceArray(loadRange("Untitled-Artwork-", 21, 25, ".png"));
  
  karma = loadKarma();
  
  frameRate(frameRateConst);
  strokeWeight(2);
  origin = new PVector(width/2, height/2);
}

void draw() {
  int fC = frameCount/2 % frameLimit;
  background(0);
  
  float y = sin((float)fC/4) * 10 - 20;
  
  strokeWeight(2);
  noFill();
    
  stroke(#3e3e3e);
  // simpleMandalaRays(float x, float y, float radius1, float radius2, int numlines, float deg)
  simpleMandalaRays(origin.x + 5, origin.y + y - 90, 300, 290, 20, fC*3);
  
  stroke(#bbbbbb);
  ellipseMoveRays(origin.x, origin.y + y - 90, 200, 200, 40, 20, fC*3);
  
  // custRotatePosStar(float x, float y, float radius1, float radius2, int npoints, float deg, int cust)
  custRotatePosStar(origin.x + 5, origin.y + y - 90, 250, 350, 20, fC*3, POINTS);
  
  // fill(lerpColor(0, #666666, sin((float)fC/4)));
  // stroke(lerpColor(#ffffff, 0, sin((float)fC/4)));
  // fill(lerpColor(#000000, lerpColor(gold, #000000, 0.6), sin((float)fC/4)));
  custRotatePosStar(origin.x + 5, origin.y + y - 90, 125, 122, 3, fC*3, -1);
  custRotatePosStar(origin.x + 5, origin.y + y - 90, 125, 122, 3, fC*3 - 90, -1);
  
  // stroke(lerpColor(0, #dddddd, sin((float)fC/4)));
  // fill(lerpColor(#666666, 0, sin((float)fC/4)));
  stroke(0);
  strokeWeight(2);
  fill(lerpColor(gold, #000000, 0.7));
  // fill(lerpColor(gold, #000000, 0.6));
  custRotatePosStar(origin.x + 5, origin.y + y - 90, 55, 40, 4, fC*3, -1);
  custRotatePosStar(origin.x + 5, origin.y + y - 90, 55, 40, 4, fC*3 - 45, -1);
  noFill();
  
  stroke(#555555);
  ellipseMoveRays(origin.x + 5, origin.y + y - 90, 430, 370, 40, 20, fC*3);
  
  // void showKarma(float x, float y, float radius1, float radius2, float deg, color c)
  pushMatrix();
  translate(origin.x + 5, origin.y + y - 100);
  rotate(fC/(float)16);
  showKarma(0, 0, 300, 300, fC, #cccccc);
  popMatrix();
  
  fill(#000000);
  circle(origin.x + 3, origin.y + y - 96, 55);
  showFrame(fpMask, 0, 0, y, 500, 560, fC);
  showFrame(fp, 0, 0, y, 500, 560, fC);
  
  showFrame(cat, 0, cos((float)fC/4) * 6, sin((float)fC/4) * 6 - 15, 500, 560, fC);
  
  saveFrame("save/"+frameCount+".png");
  print(fC, "\n");
}

void keyPressed()
{
  if (keyCode==10) { // enter
  }
}
