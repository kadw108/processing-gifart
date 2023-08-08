PVector origin;

int setFrameRate = 12;
int frameLimit = 101;


int counter = 0;

PImage guide;

float theta;

PImage[] cat;
PImage[] catColor;
PImage[] catMask;
PImage[] tongue;

PImage[] mark;
PImage[] wreath;

PImage[] snowA;
PImage[] snowB;

import java.awt.event.*;

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
  
  tongue = loadBounce("tongue", 5);
  mark = load("markw", 4);
  wreath = loadBounce("wreath", 5);
  
  guide = loadImage("guide2.png");
  
  snowA = load("snowA", 100, ".png");
  snowB = load("snowB", 100, ".png");
  
  frameRate(setFrameRate); // put at end to avoid RuntimeException when loading pics
  
  noFill();
}

void draw(){
  float fC = frameCount % frameLimit;
  background(0);
  // background(guide);
  
  /* EXTRA HALO */
  // rotateCircleStars(float x, float y, float radDot, float radX, float radY, int npoints, float deg, int nStarPoints) 
  noStroke();
  stroke(#cccccc);
  strokeWeight(1);
  // rotateCircleStars(0, -30, 10, 300, 300, 30, fC*3.6, 7);
  // rotatePosStar(float x, float y, float radius1, float radius2, int npoints, float deg)
  custRotatePosStar(origin.x, origin.y-30, 300, 290, 60, 150 + fC*1.2, POINTS);
  noFill();
  
  /* SNOW */
  /*
  blendMode(LIGHTEST);
  showFrame(snowB, 0, 120, 0, 500, 500, 95);
  showFrame(snowB, 30, -140, 0, 550, 650, 4);
  showFrame(snowB, -10, 170, 0, 500, 500, 20);
  showFrame(snowB, -20, 200, 0, 600, 700, 69);
  showFrame(snowB, -25, -90, 0, 580, 650, 40);
  showFrame(snowB, 15, -120, 0, 500, 500, 80);
  
  showFrame(snowA, -30, -120, 0, 500, 500);
  showFrame(snowA, -30, -70, 0, 550, 650, 4);
  showFrame(snowA, 20, 200, 0, 600, 700, 52);
  showFrame(snowA, 25, -380, 0, 580, 650, 83);
  showFrame(snowA, -15, -150, 0, 500, 500, 33);
  showFrame(snowA, 10, 170, 0, 500, 500, 16);
  showFrame(snowA, 20, -250, 0, 500, 600, 90);
  showFrame(snowA, 0, -200, 0, 500, 600, 20);
  showFrame(snowA, 0, 200, 0, 500, 600, 80);
  showFrame(snowA, 5, -120, 0, 500, 600, 40);
  showFrame(snowA, -5, 120, 0, 500, 600, 25);
  showFrame(snowA, 15, 200, 0, 500, 600, 86);
  blendMode(BLEND);
  */
  /*
  fill(#ffffff);
  noStroke();
  int fC2 = frameCount % 200;
  snow(origin.x + map(sin((float)fC/5), -1, 1, -50, 50), fC2*12, 25, 5, 6);
  snow(origin.x + map(sin((float)fC/5), -1, 1, -80, 0), (fC2*10 + 100)%500, 25, 5, 6);
  print("test", (height - fC2*10 - 100)%500, "\n");
  snow(origin.x + map(sin((float)fC/5), -1, 1, 150, 200), fC2*6, 25, 5, 6);
  
  bubble(origin.x + map(sin((float)fC/5), -1, 1, -140, -180), fC2*10 + 200, 25, 25);
  bubble(origin.x + map(sin((float)fC/5), -1, 1, 100, 120), fC2*12 + 280, 25, 25);
  bubble(origin.x + map(sin((float)fC/5), -1, 1, 150, 200), fC2*5 + 380, 25, 25);
  bubble(origin.x + map(sin((float)fC/5), -1, 1, -200, -40), fC2*10 + 50, 25, 25);
  bubble(origin.x + map(sin((float)fC/5), -1, 1, -250, -100), fC2*12 + 40, 25, 25);
  
  noFill();
  */
  
  /* DIAMOND */
  strokeWeight(2);
  // stroke(#ffc400);
  // stroke(#fff79c);
  stroke(#ffffff);
  float stroke;
  
  /*
  if (true) {
    stroke = map(sin((float)fC/4 + 15), -1, 1, -1, 1);
    if (stroke > 0) {
      strokeWeight(constrain(stroke, 0, 1));
      rotatePosStar(origin.x, origin.y-68, 160, 110, 4, 45);
    }
    
    stroke = map(sin((float)fC/4), -1, 1, -1, 1);
    if (stroke > 0) {
      strokeWeight(constrain(stroke, 0, 1));
      rotatePosStar(origin.x, origin.y-68, 168, 118, 4, 45);
    }
    
    stroke = map(sin((float)fC/4 + 5), -1, 1, -1, 1);
    if (stroke > 0) {
      strokeWeight(constrain(stroke, 0, 1));
      rotatePosStar(origin.x, origin.y-68, 176, 126, 4, 45);
    }
    
    stroke = map(sin((float)fC/4 + 10), -1, 1, -1, 1);
    if (stroke > 0) {
      strokeWeight(constrain(stroke, 0, 1));
      rotatePosStar(origin.x, origin.y-68, 184, 134, 4, 45);
    }
  }
  if (fC % 25 == 0) {
    counter++;
  }
  */
  float sizeC = (fC % (frameLimit/5)) * 12;
  stroke(lerpColor(#ffffff, #000000, sizeC/210));
  rotatePosStar(origin.x, origin.y-68, sizeC, sizeC-50, 4, 45);
  
  stroke(lerpColor(#ffffff, #000000, (sizeC-10)/210));
  rotatePosStar(origin.x, origin.y-68, sizeC-10, sizeC-60, 4, 45);
  
  /* RAYS */
  strokeWeight(1);
  stroke(#ffffff);

  
  // Transp top 1
  stroke = map(sin((float)fC/4), -1, 1, 2, 1);
  strokeWeight(stroke);
  
  line(origin.x, -50, 0 - 40, origin.y - 30); // 1
  line(origin.x, -50, width + 40, origin.y - 30); // 1
  
  /*
  line(origin.x-180, origin.y-40, 0 - 40, origin.y + 50); // 2
  line(origin.x-140, origin.y, 0 - 40, origin.y + 130); // 3
  line(origin.x-100, origin.y+40, 0 - 40, origin.y + 200); // 4
  
  line(origin.x+180, origin.y-40, width + 40, origin.y + 50); // 2
  line(origin.x+140, origin.y, width + 40, origin.y + 130); // 3
  line(origin.x+100, origin.y+40, width + 40, origin.y + 200); // 4
  */
  
  // Transp top 2
  stroke = map(sin((float)fC/4), -1, 1, 1, 2);
  strokeWeight(stroke);
  line(origin.x, -40, 0 - 40, origin.y - 20);
  line(origin.x, -40, width + 40, origin.y - 20);
  
  // Transp 2
  stroke = map(sin((float)fC/4), -1, 1, 0.6, 1);
  strokeWeight(stroke);

  line(origin.x-180, origin.y-30, 0 - 40, origin.y + 60);
  line(origin.x-140, origin.y+10, 0 - 40, origin.y + 140);
  line(origin.x-100, origin.y+50, 0 - 40, origin.y + 210);
  
  line(origin.x+180, origin.y-30, width + 40, origin.y + 60);
  line(origin.x+140, origin.y+10, width + 40, origin.y + 140);
  line(origin.x+100, origin.y+50, width + 40, origin.y + 210);
  
  /* HANDDRAWN */
  showFrame(wreath, fC*3.6, 0, -70, 500, 500);
  
  showFrame(catMask, 0, 0, (int) map(sin((float)fC/4), -1, 1, -5, 7), 500, 500);
  tint(255, 52);
  showFrame(catColor, 0, 0, (int) map(sin((float)fC/4), -1, 1, -5, 7), 500, 500);
  tint(255, 255);
  showFrame(cat, 0, 0, (int) map(sin((float)fC/4), -1, 1, -5, 7), 500, 500);
  showFrame(tongue, 0, 0, (int) map(sin((float)fC/4), -1, 1, -5, 7), 500, 500);
  
  tint(255, map(sin((float)fC/5), -1, 1, -100, 255) + 100);
  showFrame(mark, 0, 0, (int) map(sin((float)fC/4), -1, 1, -5, 7) - 30, 420, 420);
  showFrame(mark, 0, 0, (int) map(sin((float)fC/4), -1, 1, -5, 7) - 30, 420, 420, 3);
  // image(mark[0], origin.x, origin.y + (int) map(sin((float)fC/4), -1, 1, -5, 7) -30, 420, 420);
  tint(255, 255);
  
  /*
  if (frameCount < frameLimit) {
    String fn = "save/"+frameCount+".png";
    saveFrame(fn);
  }
  */
  
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
