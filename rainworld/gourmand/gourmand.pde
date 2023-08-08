PVector origin;

int setFrameRate = 12;

PImage guide;

PImage[] centis;
PImage[] fruits;
PImage[] fly;
PImage[] gour;
PImage[] gourColor;
PImage mask;

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
  
  centis = load("centis", 4);
  fruits = load("fruits", 5);
  fly = loadBounce("fly", 4);
  gour = loadBounce("gour", 5);
  gourColor = loadBounce("gourC", 5);
  
  guide = loadImage("guide.jpeg");
  mask = loadImage("mask.png");
  
  frameRate(setFrameRate); // put at end to avoid RuntimeException when loading pics
  
  noFill();
}

void draw(){
  // int fC = frameCount % 135;
  int fC = frameCount;
  
  stroke(#fff7a7);
  background(0);
  // background(guide);
 
  showFrame(centis, fC * 5, 0, 0, 500, 500); // rotates setFrameRate*5 degrees per second
  showFrame(fruits, fC * 5, 0, 0, 500, 500);
  
  showFrame(fly, 0, 0, 20, 525, 525);

  strokeWeight(2);
  rotateCircle(270, 250, -10, -10, fC*5);
  rotateCircle(250, 270, -10, -10, fC*5);
  
  stroke(#c0c070);
  ellipse(0 - 50, height + 10, 325, 325);
  ellipse(width + 50, height + 10, 325, 325);
  ellipse(0 - 50, 0 - 10, 325, 325);
  ellipse(width + 50, 0 - 10, 325, 325);

  rotateCircle(635, 655, 0, 0, fC*5);
  
  image(mask, origin.x, origin.y + (int) map(sin((float)fC/3), -1, 1, 25, 35), 490, 490);
  
  tint(255, 42);
  showFrame(gourColor, 0, 0, (int) map(sin((float)fC/3), -1, 1, 25, 35), 490, 490);
  tint(255, 255);
  showFrame(gour, 0, 0, (int) map(sin((float)fC/3), -1, 1, 25, 35), 490, 490);
  
  String fn = "save/"+frameCount+".png";
  saveFrame(fn);
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
