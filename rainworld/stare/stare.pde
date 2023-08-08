import java.util.*;

PVector origin;
color bg;

color gold = #ffc740;

PImage col;
PImage colMask;
PImage mid;
PImage midMask;
PImage fore;
PImage foreMask;

String[] sky;

PImage[] cat;
PImage[] catMask;

PImage[] karma;

ParticleSystem ps;

int frameRateConst = 24;
int frameLimit = 100;
void setup() {
  size(500, 500);
  
  col = loadImage("Untitled-Artwork-2.png");
  colMask = loadImage("Untitled-Artwork-1.png");
  mid = loadImage("Untitled-Artwork-4.png");
  midMask = loadImage("Untitled-Artwork-3.png");
  fore = loadImage("Untitled-Artwork-12.png");
  foreMask = loadImage("Untitled-Artwork-11.png");
  
  sky = loadStr("/home/account/Videos/psychedelic_sky_islands/sky/dest/sky", 2000, ".jpg");
  cat = bounceArray(load("cat", 5, ".png"));
  catMask = bounceArray(loadRange("Untitled-Artwork-", 13, 21, ".png", 5));
  
  karma = loadKarma();
  
  frameRate(frameRateConst);
  strokeWeight(2);
  origin = new PVector(width/2, height/2);
}

void draw() {
  int fC = frameCount/2 % frameLimit;
  background(0);
  
  tint(255, 255);
  showFrame(sky, 0, 0, -100, 1000, 600, 0, frameCount*10);
  
  tint(darkC(100), 150);
  image(colMask, origin.x, origin.y);
  tint(darkC(50), 150);
  image(col, origin.x, origin.y);
  
  tint(darkC(80), 255);
  image(midMask, origin.x, origin.y);
  tint(darkC(30), 255);
  image(mid, origin.x, origin.y);
  
  tint(darkC(50), 255);
  image(foreMask, origin.x - 10, origin.y - 10, 520, 520);
  tint(darkC(0), 255);
  image(fore, origin.x - 10, origin.y - 10, 520, 520);
  
  tint(#FFF5E8, 255);
  showFrame(catMask, 10, 15, -27, 500, 500, fC);
  tint(#D29546, 255);
  showFrame(cat, 10, 15, -27, 500, 500, fC);
  
  saveFrame("save/"+frameCount+".png");
  print(fC, "\n");
}

color darkC(float shade) {
  return lerpColor(#5A054A, #FFD0AD, shade/255);
}

void keyPressed()
{
  if (keyCode==10) { // enter
  }
}
