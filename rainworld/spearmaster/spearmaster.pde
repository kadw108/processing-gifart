PVector origin;

int setFrameRate = 12;
int frameLimit = 101;

PImage guide;

float theta;

PImage[] cat;
PImage[] catColor;
PImage[] catMask;
PImage[] spear;
PImage[] spines;

PImage[] vines;

import java.awt.event.*;
import java.util.*;

// Load beg-end, eg. 1234 (len 4)
PImage[] load(String name, int len) {
  return load(name, len, ".PNG");
}

PImage[] load(String name, int len, String extension) {
  PImage[] array = new PImage[len];
  for (int i = 0; i < len; i++) {
    array[i] = loadImage(name + (i+1) + extension);
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
  
  Collections.reverse(Arrays.asList(cat));
  Collections.reverse(Arrays.asList(catMask));
  Collections.reverse(Arrays.asList(catColor));
  
  spines = loadBounce("spines", 5);
  spear = loadBounce("spear", 5);
  
  guide = loadImage("guide.PNG");
  
  vines = loadBounce("vines", 5);
  
  frameRate(setFrameRate); // put at end to avoid RuntimeException when loading pics
  
  noFill();
}

void draw(){
  int fC = frameCount % frameLimit;
  background(0);
  // background(guide);
  
  /* HALO */
  strokeWeight(2);
  
  stroke(#f0f0f0);
  // stroke(#ffc942);
  
  // custRotatePosStar(float x, float y, float radius1, float radius2, int npoints, float deg, int cust)
  custRotatePosStar(origin.x+10, origin.y - 110, 80, 70, 30, fC*3.6, TRIANGLE_STRIP);
  
  // stroke(lerpColor(#b379f7, #000000, 0.2));
  // stroke(#fff7a7);
  stroke(#ffc740);
  
  // rotateEllipseSwirl(float x, float y, float radx, float rady, float diff, int npoints, float deg)
  ellipseTriMoveRays(origin.x+5, origin.y - 110, 125, 105, 10, 20, fC*3.6);
  ellipseMoveRays(origin.x+5, origin.y - 110, 165, 155, 15, 45, fC*3.6);
  
  // upper corners
  stroke(lerpColor(#ffc740, #000000, 0.15));
  strokeWeight(2);
  ellipseMoveRays(0, 0, 100, 100, 10, 30, -fC*3.6);
  custRotatePosStar(0, 0, 70, 50, 25, -fC*3.6, LINES);
  custRotatePosStar(0, 0, 35, 25, 10, -fC*3.6, TRIANGLE_STRIP);
  ellipseMoveRays(width, 0, 100, 100, 10, 30, fC*3.6);
  custRotatePosStar(width, 0, 70, 50, 25, fC*3.6, LINES);
  custRotatePosStar(width, 0, 35, 25, 10, fC*3.6, TRIANGLE_STRIP);
  
  // lower corners
  stroke(lerpColor(#ffffff, #000000, 0.2));
  rotatePosStar(0, height, 30, 15, 25, -fC*3.6);
  custRotatePosStar(0, height, 40, 45, 35, -fC*3.6, LINES);
  rotatePosStar(width, height, 30, 15, 25, fC*3.6);
  custRotatePosStar(width, height, 40, 45, 35, fC*3.6, LINES);
  
  /* HANDDRAWN */
  showFrame(catMask, 0, 0, (int) map(sin((float)fC/4), -1, 1, -5, 5), 500, 500);
  tint(255, 52);
  showFrame(catColor, 0, 0, (int) map(sin((float)fC/4), -1, 1, -5, 5), 500, 500);
  tint(255, 255);
  showFrame(cat, 0, 0, (int) map(sin((float)fC/4), -1, 1, -5, 5), 500, 500);
  showFrame(spines, 0, 0, (int) map(sin((float)fC/4), -1, 1, -5, 5), 500, 500);
  showFrame(spear, 0, 0, (int) map(sin((float)fC/4), -1, 1, -5, 5), 500, 500);
  
  tint(255, 225);
  showFrame(vines, 0, 0, 0, 500, 500);
  tint(255, 255);
  
  if (frameCount < frameLimit) {
    String fn = "save/"+frameCount+".png";
    saveFrame(fn);
  }
  
  print(frameCount, "\n");
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

void snow(float x, float y, float r1, float r2, int npoints) {
  posStar(x, y, r1 * constrain((height - y + height/2)/height, 0, 1), r2 * constrain((height - y + height/2)/height, 0, 1), npoints);
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
  translate(origin.x+x, origin.y+y);
  rotate(radians(deg));
  image(array[frameCount % array.length], 0, 0, h, w);
  popMatrix();
}

void showFrame(PImage[] array, float deg, int x, int y, int h, int w, int shift) {
  imageMode(CENTER);
  pushMatrix();
  translate(origin.x+x, origin.y+y);
  rotate(radians(deg));
  image(array[(frameCount + shift) % array.length], 0, 0, h, w);
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

void custStar(float x, float y, float radius1, float radius2, int npoints, int cust) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  beginShape(cust);
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

void custRotatePosStar(float x, float y, float radius1, float radius2, int npoints, float deg, int cust) {
  pushMatrix();
  translate(x, y);
  rotate(radians(deg));
  
  if (radius1 > 0 && radius2 > 0) {
    custStar(0, 0, radius1, radius2, npoints, cust);
  }
  else {
    custStar(0, 0, 1, 2, npoints, cust);
  }
  
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

void circleStars(float x, float y, float radDot, float radX, float radY, int npoints, int nStarPoints, float starDeg) {
  float angle = TWO_PI / npoints;
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radX;
    float sy = y + sin(a) * radY;
    rotatePosStar(sx, sy, radDot, radDot/4, nStarPoints, starDeg);
  }
}

void rotateCircleStars(float x, float y, float radDot, float radX, float radY, int npoints, float deg, int nStarPoints) {
  pushMatrix();
  translate(origin.x + x, origin.y + y);
  rotate(radians(deg));
  circleStars(0, 0, radDot, radX, radY, npoints, nStarPoints, deg);
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

// Use with ellipseMoveRays for trippy triangle effect
void ellipseSwirlMoveRays(float x, float y, float radx, float rady, float diff, int npoints, float shiftDeg) {
  float angle = TWO_PI / npoints;
  float shift = radians(shiftDeg);
  
  // get sx and sy of last "curve" to use as ref for first curve
  float prevSX = 0;
  float prevSY = 0;
  for (float a = 0; a < TWO_PI; a += angle) {
    prevSX = x + cos(a+shift) * radx;
    prevSY = y + sin(a+shift) * rady;
  }
  
  // actually draw "curves" (triangles)
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a+shift) * radx;
    float sy = y + sin(a+shift) * rady;
    float sx2 = x + cos(a+shift) * (radx - diff);
    float sy2 = y + sin(a+shift) * (rady - diff);
    
    curve(prevSX, prevSY, sx, sy, sx2, sy2, x + cos(a+10)*(radx*1.5), y + sin(a+10)*(rady*1.5));
    
    prevSX = sx;
    prevSY = sy;
  }
}

void ellipseMoveRays(float x, float y, float radx, float rady, float diff, int npoints, float shiftDeg) {
  float angle = TWO_PI / npoints;
  float shift = radians(shiftDeg);
  
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a+shift) * radx;
    float sy = y + sin(a+shift) * rady;
    
    float sx2 = x + cos(a+shift) * (radx - diff);
    float sy2 = y + sin(a+shift) * (rady - diff);
    
    line(sx, sy, sx2, sy2);
  }
}

void ellipseTriMoveRays(float x, float y, float radx, float rady, float diff, int npoints, float shiftDeg) {
  ellipseMoveRays(x, y, radx, rady, diff, npoints, shiftDeg);
  ellipseSwirlMoveRays(x, y, radx, rady, diff, npoints, shiftDeg);
}
