PVector origin;

int setFrameRate = 12;
int frameLimit = 101;

import java.awt.event.*;

// Load beg-end, eg. 1234 (len 4)
PImage[] load(String name, int len) {
  PImage[] array = new PImage[len];
  for (int i = 0; i < len; i++) {
    array[i] = loadImage(name + (i+1) + ".png");
  }
  
  return array;
}

// Load beg-end-(beg+1), eg. 123432 (len 4) - sequentially creates 123432 123432...
PImage[] loadBounce(String name, int len) {
  PImage[] array = new PImage[len + (len-2)];
  for (int i = 0; i < len; i++) {
    array[i] = loadImage(name + (i+1) + ".png");
  }
  
  for (int i = len; i < array.length; i++) {
    array[i] = loadImage(name + (len*2 - i - 1) + ".png");
    print(i, (len*2-i - 1), "\n");
  }
  
  return array;
}

void setup(){
  size(500, 500);
  origin = new PVector(width/2, height/2);
  
  frameRate(setFrameRate); // put at end to avoid RuntimeException when loading pics
  
  noFill();
  strokeWeight(2);
}

void draw(){
  int fC = frameCount % (frameLimit*2);
  background(0);
 
  noStroke();
  fill(#ffffff);
  // snow(origin.x + map(sin((float)fC/5), -1, 1, -20, 20), fC*6, 6, 1, 6);
  snow(origin.x + map(sin((float)fC/5), -1, 1, -20, 20), fC*6, 8 - ((fC) % 30) - 6, 8 - ((fC) % 30), 6);
  
  String fn = "save/"+"snowB"+frameCount+".png";
  saveFrame(fn);
  
  print(frameCount, "\n");
}

void bubble(float x, float y, float w, float h) {
  ellipse(x, y, w * (y/height), h * (y/height));
}

void snow(float x, float y, float r1, float r2, int npoints) {
  posStar(x, y, r1 * constrain((height - y + height/2)/height, 0, 1), r2 * constrain((height - y + height/2)/height, 0, 1), npoints);
}

void ellipsePos(float x, float y, float w, float h) {
  stroke(lerpColor(#56e2ff, #000000, ((float) w)/(1000)));
  if (w > 0 && h > 0) {
    ellipse(x, y, w, h);
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

void showFrame(PImage[] array, float deg, int x, int y, int h, int w) {
  imageMode(CENTER);
  pushMatrix();
  translate(origin.x, origin.y);
  rotate(radians(deg));
  image(array[frameCount % array.length], x, y, h, w);
  popMatrix();
}

void rotateCircle(int wid, int heit, int xShift, int yShift, int deg) {
  pushMatrix();
  translate(origin.x, origin.y);
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
