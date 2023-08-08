PVector origin;

int setFrameRate = 12;
int frameLimit = 101;

PImage guide;

float theta;

PImage[] cat;
PImage[] catColor;
PImage[] catMask;

PImage[] keyBot;
PImage[] gem;
PImage[] keyFire;
PImage[] botFire;
PImage[] spear;

import java.awt.event.*;

// Load beg-end, eg. 1234 (len 4)
PImage[] load(String name, int len) {
  PImage[] array = new PImage[len];
  for (int i = 0; i < len; i++) {
    array[i] = loadImage(name + (i+1) + ".PNG");
  }
  
  return array;
}

// Load beg-end-(beg+1), eg. 123432 (len 4) - sequentially creates 123432 123432...
PImage[] loadBounce(String name, int len) {
  PImage[] array = new PImage[len + (len-2)];
  for (int i = 0; i < len; i++) {
    array[i] = loadImage(name + (i+1) + ".PNG");
  }
  
  for (int i = len; i < array.length; i++) {
    array[i] = loadImage(name + (len*2 - i - 1) + ".PNG");
    print("loadimage", i, (len*2-i - 1), "\n");
  }
  
  return array;
}

void setup(){
  size(500, 500);
  origin = new PVector(width/2, height/2);
  
  cat = loadBounce("line", 5);
  catMask = loadBounce("mask", 5);
  catColor = loadBounce("cat", 5);
  
  keyBot = load("key", 5);
  gem = load("gem", 5);
  keyFire = loadBounce("keyFire", 5);
  botFire = loadBounce("botFire", 5);
  spear = loadBounce("spear", 5);
  
  guide = loadImage("guide.PNG");
  
  frameRate(setFrameRate); // put at end to avoid RuntimeException when loading pics
  
  noFill();
}

void draw(){
  int fC = frameCount % frameLimit;
  background(0);
  // background(guide);
  
  /* SWIRLS */
  stroke(#ee826c);
  strokeWeight(2);
  
  rotateSwirl(140, 35, 5, 11, 7, fC*3.6);
  rotateSwirl(50, 215, 5, 16, 7, fC*3.6);
  rotateSwirl(80, 335, 7, 19, 7, fC*3.6);
  rotateSwirl(125, 375, 10, 27, 7, fC*3.6);
  rotateSwirl(405, 75, 10, 20, 7, fC*3.6);
  rotateSwirl(460, 215, 10, 24, 7, fC*3.6);
  rotateSwirl(450, 325, 10, 35, 7, fC*3.6);
  
  /* STARS */
  // stroke(#c0c070);
  noStroke();
  fill(#c0c070);
  rotatePosStar(470, 170, 8 - ((fC+25) % 10) - 6, 8 - ((fC+25) % 10), 4, 45);
  rotatePosStar(350, 40, 4 - (fC % 20) - 2, 4 - (fC % 20), 4, 15);
  rotatePosStar(30, 320, 8 - ((fC+40) % 25) - 6, 8 - ((fC+40) % 25), 4, -15);
  rotatePosStar(180, 390, 4 - ((fC+35) % 20) - 2, 4 - ((fC+35) % 20), 4, -30);
  rotatePosStar(50, 150, 6 - (fC % 10) - 3, 6 - (fC % 10), 4, 30);
  rotatePosStar(430, 375, 6 - ((fC+10) % 20) - 3, 6 - ((fC+10) % 20), 4, -7);
  
  rotatePosStar(75, 120, -1, -1, 4, 0);
  rotatePosStar(450, 260, -1, -1, 4, 0);
  rotatePosStar(470, 280, 1, 4, 4, 0);
  circle(40, 250, 3);
  circle(400, 400, 3);
  circle(440, 110, 3);
  circle(20, 160, 3);
  
  noFill();
  
  /* CORNERS */
  stroke(#ffc740);
  strokeWeight(1);
  rotateCircle(165, 165, 2, 2, -width/2 - 20, -height/2, fC*4);
  rotateCircle(165, 165, 2, 2, width/2 + 20, -height/2, fC*4);
  strokeWeight(2);
  rotateCircle(130, 130, 2, 2, -width/2 - 20, -height/2, fC*4);
  rotateCircle(130, 130, 2, 2, width/2 + 20, -height/2, fC*4);
  
  // fill(#ffc740);
  rotateCircleDots(-width/2 - 20, -height/2, 5, 100, 100, 40, -fC*4);
  rotateCircleDots(width/2 + 20, -height/2, 5, 100, 100, 40, fC*4);
  // noFill();
  
  strokeWeight(2);
  rotateCircle(205, 200, 2, 2, -10, -80, fC*4);
  strokeWeight(1);
  rotateCircle(315, 310, 2, 2, 0, -50, fC*4);
  strokeWeight(0.4);
  rotateCircle(345, 340, 2, 2, 0, -50, fC*4);
  
  /* HANDDRAWN */
  showFrame(keyBot, 0);
  showFrame(gem, 0);
  showFrame(keyFire, 0, 4);
  showFrame(botFire, 0, 2);
  
  showFrame(catMask, 0, 0, (int) map(sin((float)fC/4), -1, 1, -5, 7), 500, 500);
  tint(255, 52);
  showFrame(catColor, 0, 0, (int) map(sin((float)fC/4), -1, 1, -5, 7), 500, 500);
  tint(255, 255);
  showFrame(cat, 0, 0, (int) map(sin((float)fC/4), -1, 1, -5, 7), 500, 500);
  showFrame(spear, 0, 0, (int) map(sin((float)fC/4), -1, 1, -5, 7), 500, 500);
  
  /*
  if (frameCount < frameLimit) {
    String fn = "save/"+frameCount+".png";
    saveFrame(fn);
  }
  */
  
  // print(frameCount, "\n");
}

void tree(int fC, float x, float y, float angle) {
  float fC3 = map(sin((float)fC/4), -1, 1, 6, 13);
  
  pushMatrix();
  // Convert it to radians
  theta = radians(fC3);
  // Start the tree from the bottom of the screen
  translate(x, y);
  rotate(radians(angle));
  
  // Draw a line 120 pixels, move to end of line
  int len = 60;
  line(0,0,0,-len);
  translate(0,-len);
  // Start the recursive branching!
  branch(len*3);
  popMatrix();
}

void branch(float h) {
  // Each branch will be 2/3rds the size of the previous one
  h *= 0.7;
  
  // All recursive functions must have an exit condition!!!!
  // Here, ours is when the length of the branch is 2 pixels or less
  if (h > 20) {
    pushMatrix();    // Save the current state of transformation (i.e. where are we now)
    rotate(theta);   // Rotate by theta
    line(0, 0, 0, -h);  // Draw the branch
    translate(0, -h); // Move to the end of the branch
    branch(h);       // Ok, now call myself to draw two new branches!!
    popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state
    
    // Repeat the same thing, only branch off to the "left" this time!
    pushMatrix();
    rotate(-theta);
    line(0, 0, 0, -h);
    translate(0, -h);
    branch(h);
    popMatrix();
  }
}

void bubble(float x, float y, float w, float h) {
  ellipse(x, y, w * (y/height), h * (y/height));
}

void ellipsePos(float x, float y, float w, float h) {
  stroke(lerpColor(#56e2ff, #000000, ((float) w)/(1200)));
  if (w > 0 && h > 0) {
    ellipse(x, y, w, h);
    // ellipse(x, y, w + 5, h - 5);
  }
}

void showFrame(PImage[] array, float deg) {
  imageMode(CENTER);
  pushMatrix();
  translate(origin.x, origin.y);
  rotate(radians(deg));
  image(array[frameCount % array.length], 0, 0);
  popMatrix();
}

void showFrame(PImage[] array, float deg, int shift) {
  imageMode(CENTER);
  pushMatrix();
  translate(origin.x, origin.y);
  rotate(radians(deg));
  image(array[(frameCount + shift) % array.length], 0, 0);
  popMatrix();
}

void showFrame(PImage[] array, float deg, int x, int y, int h, int w) {
  imageMode(CENTER);
  pushMatrix();
  translate(origin.x, origin.y);
  rotate(radians(deg));
  image(array[frameCount % array.length], x, y, h, w);
  popMatrix();
}

void showFrame(PImage[] array, float deg, int x, int y, int h, int w, int shift) {
  imageMode(CENTER);
  pushMatrix();
  translate(origin.x, origin.y);
  rotate(radians(deg));
  image(array[(frameCount + shift) % array.length], x, y, h, w);
  popMatrix();
}

void rotateCircle(int wid, int heit, int xShift, int yShift, int x, int y, float deg) {
  pushMatrix();
  translate(origin.x + x, origin.y + y);
  rotate(radians(deg));
  ellipse(xShift, yShift, wid, heit);
  popMatrix();
}

void star(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

void posStar(float x, float y, float radius1, float radius2, int npoints) {
  if (radius1 > 0 && radius2 > 0) {
    star(x, y, radius1, radius2, npoints);
  }
  else {
    star(x, y, 1, 2, npoints);
  }
}

void rotatePosStar(float x, float y, float radius1, float radius2, int npoints, float deg) {
  pushMatrix();
  translate(x, y);
  rotate(radians(deg));
  posStar(0, 0, radius1, radius2, npoints);
  popMatrix();
}

void circleDots(float x, float y, float radDot, float radX, float radY, int npoints) {
  float angle = TWO_PI / npoints;
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radX;
    float sy = y + sin(a) * radY;
    ellipse(sx, sy, radDot, radDot);
  }
}

void rotateCircleDots(float x, float y, float radDot, float radX, float radY, int npoints, float deg) {
  pushMatrix();
  translate(origin.x + x, origin.y + y);
  rotate(radians(deg));
  circleDots(0, 0, radDot, radX, radY, npoints);
  popMatrix();
}

void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

void swirl(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  
  float prevSX = x;
  float prevSY = y;
  
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    float sx2 = x + cos(a+halfAngle) * radius1;
    float sy2 = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
    
    curve(prevSX, prevSY, sx, sy, sx2, sy2, x + cos(a+10)*(radius2*1.5), y + sin(a+10)*(radius2*1.5));
    print(cos(a)*200, sin(a)*200, "\n");
    
    prevSX = sx;
    prevSY = sy;
  }
}

void rotateSwirl(float x, float y, float radius1, float radius2, int npoints, float deg) {
  pushMatrix();
  translate(x, y);
  rotate(radians(deg));
  swirl(0, 0, radius1, radius2, npoints);
  popMatrix();
}
