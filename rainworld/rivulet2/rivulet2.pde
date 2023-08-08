PVector origin;

int setFrameRate = 14;
int frameLimit = 101;

PImage guide;

float theta;

PImage[] cat;
PImage[] catColor;
PImage[] catMask;

PImage[] bubbleA;
PImage[] bubbleB;

PImage[] frond;

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
  
  cat = loadBounce("rivulet", 6);
  catMask = loadBounce("rivuletM", 6);
  catColor = loadBounce("rivuletC", 6);
  
  bubbleA = load("bubbleA", 50);
  bubbleB = load("bubbleB", 50);
  
  frond = loadBounce("Untitled-Artwork-", 9);
  
  guide = loadImage("guide.png");
  
  frameRate(setFrameRate); // put at end to avoid RuntimeException when loading pics
  
  noFill();
  strokeWeight(2);
}

void draw(){
  int fC = frameCount % frameLimit;
  background(0);
  
  stroke(#ff8dba);
  tree(fC, -5, height-250, 25);
  tree(fC, origin.x+45, height+55, 56);
  
  showFrame(frond, 0, 0, 0, 600, 600, 5);
    
  // stroke(lerpColor(#56e2ff, #000000, ((float) fC)/frameLimit));
  ellipsePos(origin.x + 40, origin.y + 90, fC*12 - 900, fC*12 - 900);
  ellipsePos(origin.x + 40, origin.y + 90, fC*12 - 750, fC*12 - 750);
  ellipsePos(origin.x + 40, origin.y + 90, fC*12 - 600, fC*12 - 600);
  
  ellipsePos(origin.x + 40, origin.y + 90, fC*12, fC*12);
  ellipsePos(origin.x + 40, origin.y + 90, fC*12 - 150, fC*12 - 150);
  ellipsePos(origin.x + 40, origin.y + 90, fC*12 - 300, fC*12 - 300);
 
  ellipsePos(origin.x + 40, origin.y + 90, fC*12 + 600, fC*12 + 600);
  ellipsePos(origin.x + 40, origin.y + 90, fC*12 + 450, fC*12 + 450);
  ellipsePos(origin.x + 40, origin.y + 90, fC*12 + 300, fC*12 + 300);
  
  blendMode(LIGHTEST);
  showFrame(bubbleA, 0, 0, 0, 500, 500);
  showFrame(bubbleA, 30, -70, 0, 550, 650, 2);
  showFrame(bubbleA, -10, 170, 0, 500, 500, 20);
  showFrame(bubbleA, -20, 200, 0, 600, 700, 39);
  showFrame(bubbleA, -25, -90, 0, 580, 650, 10);
  showFrame(bubbleA, 15, -120, 0, 500, 500, 30);
  
  showFrame(bubbleB, -30, 0, 0, 500, 500);
  showFrame(bubbleB, -30, -70, 0, 550, 650, 4);
  showFrame(bubbleB, 20, 200, 0, 600, 700, 42);
  showFrame(bubbleB, 25, -90, 0, 580, 650, 13);
  showFrame(bubbleB, -15, -150, 0, 500, 500, 33);
  showFrame(bubbleB, 10, 170, 0, 500, 500, 16);
  showFrame(bubbleB, 20, -250, 0, 500, 600, 7);
  showFrame(bubbleB, 0, -200, 0, 500, 600, 20);
  showFrame(bubbleB, 0, 200, 0, 500, 600, 30);
  showFrame(bubbleB, 5, -60, 0, 500, 600, 10);
  showFrame(bubbleB, -5, 60, 0, 500, 600, 25);
  showFrame(bubbleB, 15, 200, 0, 500, 600, 46);
  blendMode(BLEND);
  /*
  stroke(#ffffff);
  int fC2 = frameCount;
  bubble(origin.x + map(sin((float)fC/5), -1, 1, -50, 50), height - fC2*12, 25, 25);
  bubble(origin.x + map(sin((float)fC/5), -1, 1, -80, 0), (height - fC2*10 - 100)%500, 25, 25);
  print("test", (height - fC2*10 - 100)%500, "\n");
  bubble(origin.x + map(sin((float)fC/5), -1, 1, 150, 200), height - fC2*6, 25, 25);
  
  bubble(origin.x + map(sin((float)fC/5), -1, 1, -140, -180), height - fC2*10 - 200, 25, 25);
  bubble(origin.x + map(sin((float)fC/5), -1, 1, 100, 120), height - fC2*12 - 280, 25, 25);
  bubble(origin.x + map(sin((float)fC/5), -1, 1, 150, 200), height - fC2*5 - 380, 25, 25);
  bubble(origin.x + map(sin((float)fC/5), -1, 1, -200, -40), height - fC2*10 - 50, 25, 25);
  bubble(origin.x + map(sin((float)fC/5), -1, 1, -250, -100), height - fC2*12 - 40, 25, 25);
  */
  
  showFrame(catMask, 0, 0, (int) map(sin((float)fC/4), -1, 1, -5, 7), 500, 500);
  tint(255, 52);
  showFrame(catColor, 0, 0, (int) map(sin((float)fC/4), -1, 1, -5, 7), 500, 500);
  tint(255, 255);
  showFrame(cat, 0, 0, (int) map(sin((float)fC/4), -1, 1, -5, 7), 500, 500);
  
  if (frameCount < frameLimit) {
    String fn = "save/"+frameCount+".png";
    saveFrame(fn);
  }
  
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

void rotateCircle(int wid, int heit, int xShift, int yShift, int deg) {
  pushMatrix();
  translate(origin.x, origin.y);
  rotate(radians(deg));
  ellipse(xShift, yShift, wid, heit);
  popMatrix();
}
