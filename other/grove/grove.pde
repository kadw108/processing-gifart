import java.util.*;

PVector origin;
color bg;

color gold = #ffc740;

PImage trees;
PImage[] eyes1;
PImage[] tears;
PImage[] starsBG;
PImage[] eyes2;
PImage[] flowers;
PImage[] river;

PImage[] star;
PImage[] cube;
PImage swan;
PImage angel;
PImage redGlyph;
PImage boxMask;
PImage[] dialogue;

PImage[] karma;

ParticleSystem ps;

int frameRateConst = 50;
int frameLimit = 200;
void setup() {
  size(600, 400);
  
  trees = loadImage("Grove-1.png");
  eyes1 = mirrorArray(loadRange("eyesA", 1, 5, ".png"));
  tears = loadRange("Grove-", 5, 14, ".png");
  starsBG = loadRange("starsbg", 1, 3, ".png");
  eyes2 = mirrorArray(loadRange("Grove-", 17, 20, ".png"));
  flowers = mirrorArray(prependEmptyStart(loadRange("Grove-", 21, 26, ".png"), 1));
  river = loadRange("Grove-", 27, 32, ".png");
  star = loadRange("Grove-", 33, 40, ".png");
  cube = loadRange("Grove-", 41, 43, ".png");
  swan = loadImage("Grove-47.png");
  angel = loadImage("Grove-48.png");
  redGlyph = loadImage("Grove-49.png");
  boxMask = loadImage("Grove-50.png");
  dialogue = loadRange("Grove-", 51, 53, ".png");
  
  karma = loadKarma();
  
  frameRate(frameRateConst);
  strokeWeight(2);
  origin = new PVector(width/2, height/2);
  
  imageMode(CENTER);
}

void draw() {
  int fC = (frameCount % frameLimit)/5;
  float fC2 = (frameCount % frameLimit)/5;
  background(0);
  
  float fC3 = map(sin(fC2/8 - PI/2), -1, 1, -255, 255);
  tint(160, fC3);
  image(trees, origin.x, origin.y);
  
  tint(255, fC3);
  PImage a = getFrameDupeLast(flowers, 1, (((int) (fC * 0.8)) + 10) % 20);
  if (a != null)
  image(a, origin.x, origin.y);
  
  image(getFrame(river), origin.x, origin.y + sin(fC2/4) * 8 + sin((fC2+10)/4) * 4 - 18);
  
  tint(255, 255);
  image(getFrameDupeLast(eyes1, 1, fC % 20), origin.x, origin.y);
  image(getFrameDupeLast(tears, 1, fC % 20), origin.x, origin.y);
  
  float t2 = map(sin(fC2), -1, 1, 200, 255);
  tint(160, t2);
  showFrame(starsBG, 0, fC/2);
  
  float t = map(sin(fC2/8 + PI/2), -1, 1, 0, 255);
  tint(160, t);
  image(getFrameDupeLast(eyes2, 1, fC % 40), origin.x, origin.y);

  tint(255, 255);

  // showFrame(star, 0, int(fC));
  
  if (frameCount % frameLimit > 100) {
    tint(255, map(sin(fC2/8), -1, 1, -2000, 255));
    image(redGlyph, origin.x, origin.y);
  }
  
  /*
  if (frameCount % frameLimit > 150) {
    tint(255, map(sin(fC2/8 + PI/2), -1, 1, -2000, 255));
    image(swan, origin.x, origin.y);
  }
  */
  
  /*
  if (frameCount % frameLimit > 350) {
    fill(0, ((float)(frameCount%frameLimit - 350)/50)*255);
    rect(0, 0, width, height);
    
    tint(255, ((float)(frameCount%frameLimit - 350)/50)*255);
    image(swan, origin.x, origin.y);
    image(boxMask, origin.x, origin.y);
    showFrame(dialogue, 0, fC);
  } */
  
  if (frameCount <= frameLimit)
    saveFrame("save/"+frameCount+".png");
   
  print(frameCount, "\n");
}
