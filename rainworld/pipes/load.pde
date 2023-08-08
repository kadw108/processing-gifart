/* ------------------ LOAD String[] ----------------- */

String[] loadString(String name, int len, String extension) {
  String[] array = new String[len];
  for (int i = 0; i < len; i++) {
    array[i] = name + (i+1) + extension;
  }
  
  return array;
}

void showFrame(String[] array, float deg, int shift, int fC) {
  imageMode(CENTER);
  pushMatrix();
  translate(origin.x, origin.y);
  rotate(radians(deg));
  PImage a = loadImage(array[(fC + shift) % array.length]);
  if (a != null) {
    image(a, 0, 0);
  }
  
  popMatrix();
}

void showFrame(String[] array, float deg, float x, float y, float h, float w, int shift, int fC) {
  imageMode(CENTER);
  pushMatrix();
  translate(origin.x+x, origin.y+y);
  rotate(radians(deg));
  PImage a = loadImage(array[(fC + shift) % array.length]);
  if (a != null) {
    image(a, 0, 0, h, w);
  }
  popMatrix();
}

/* ------------------ LOAD PImage[] ----------------- */

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

PImage[] loadRange(String name, int start, int end, String extension) {
  return loadRange(name, start, end, extension, end - start + 1);
}

PImage[] loadRange(String name, int start, int end, String extension, int leng) {
  PImage[] array = new PImage[leng];
  int next = 0;
  for (int i = start; i <= end; i++) {
    PImage nextImg = loadImage(name + (i) + extension);
    if (nextImg != null) {
      array[next] = nextImg;
      next++;
    }
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
    array[i] = loadImage(name + (len*2 - i - 2) + ".PNG");
    print("loadimage", i, (len*2-i - 2), "\n");
  }
  
  return array;
}

/* ---------------- EDIT ARRAYS -------------- */

PImage[] bounceArray(PImage[] arr) {
  int len = arr.length;
  PImage[] array = new PImage[len + (len-2)];
  for (int i = 0; i < len; i++) {
    array[i] = arr[i];
    print(i, "\n");
  }
  
  for (int i = len; i < array.length; i++) {
    array[i] = arr[len*2 - i - 2];
    print(len*2 - i - 2, "\n");
  }
  
  return array;
}

PImage[] prependEmptyStart(PImage[] array, int num) {
  PImage[] newArray = new PImage[array.length + num];
  for (int i = 0; i < num; i++) {
    newArray[i] = null;
  }
  for (int i = 0; i < array.length; i++) {
    newArray[num + i] = array[i];
  }
  return newArray;
}

PImage[] mirrorArray(PImage[] array) {
  PImage[] newArray = new PImage[array.length * 2];
  for (int i = 0; i < array.length; i++) {
    newArray[i] = array[i];
  }
  for (int i = 0; i < array.length; i++) {
    newArray[array.length + i] = array[array.length - 1 - i];
  }
  return newArray;
}

PImage[] reverse(PImage[] array) {
  PImage[] newA = new PImage[array.length];
  for (int i = 0; i < array.length; i++) {
    newA[i] = array[array.length - 1 - i];
  }
  return newA;
}

/* ------------------ GET FRAME ------------------ */

PImage getFrame(PImage[] array, int shift, int fC) {
  return array[(fC + shift) % array.length];
}

PImage getFrame(PImage[] array) {
  return array[((int)((frameCount*12) / frameRateConst)) % array.length];
}

PImage getFrameDupeLast(PImage[] array, int repeats, int fC) {
  int whichFrame = fC;
  if (whichFrame > array.length - 1) {
    whichFrame = array.length - repeats + (whichFrame % repeats);
  }
  
  return array[whichFrame];
}

/* ------------------ SHOW FRAME ----------------- */

void showFrame(PImage[] array, float deg, int fC) {
  showFrame(array, deg, 0, fC);
}

void showFrame(PImage[] array, float deg, int shift, int fC) {
  imageMode(CENTER);
  pushMatrix();
  translate(origin.x, origin.y);
  rotate(radians(deg));
  PImage a = array[(fC + shift) % array.length];
  if (a != null) {
    image(a, 0, 0);
  }
  
  popMatrix();
}

void showFrame(PImage[] array, float deg, float x, float y, float h, float w, int fC) {
  showFrame(array, deg, x, y, h, w, 0, fC);
}

// show like normal but once reaches end iterates through last [repeats] frames forever
void showFrameDupeLast(PImage[] array, float deg, float x, float y, float h, float w, int repeats, int fC) {
  imageMode(CENTER);
  pushMatrix();
  translate(origin.x+x, origin.y+y);
  rotate(radians(deg));
  int whichFrame = fC;
  if (whichFrame > array.length - 1) {
    whichFrame = array.length - repeats + (whichFrame % repeats);
  }
  PImage a = array[whichFrame];
  if (a != null) {
    image(a, 0, 0, h, w);
  }
  popMatrix();
}

void showFrame(PImage[] array, float deg, float x, float y, float h, float w, int shift, int fC) {
  imageMode(CENTER);
  pushMatrix();
  translate(origin.x+x, origin.y+y);
  rotate(radians(deg));
  PImage a = array[(fC + shift) % array.length];
  if (a != null) {
    image(a, 0, 0, h, w);
  }
  popMatrix();
}

void showFrameBounce(PImage[] array, float deg, float x, float y, float h, float w, int shift, int fC) {
  imageMode(CENTER);
  pushMatrix();
  translate(origin.x, origin.y);
  rotate(radians(deg));
  
  int bounceLength = array.length + (array.length - 1);
  
  int whichFrame = (fC + shift) % bounceLength;
  if (whichFrame > array.length - 1) {
    whichFrame = array.length - 1 - whichFrame % (array.length);
  }
  
  print(whichFrame, "\n");
  
  PImage a = array[whichFrame];
  if (a != null) {
    image(a, x, y, h, w);
  }
  
  popMatrix();
}

void showFrameBounce(PImage[] array, float deg, float x, float y, float h, float w, int fC) {
  showFrameBounce(array, deg, x, y, h, w, 0, fC);
}
