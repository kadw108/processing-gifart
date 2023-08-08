// Given f = [0.1, 0.4] calculates noise(val), returns 0 if noise<0.1, 1 if noise<0.4, else 2
// example: int dir = segNoise(new float[] {0.3, 0.7}, new float[] {x, y, i});
int segNoise(float[] f, float[] val) {
  float n = -1;
  if (val.length == 1)
    n = noise(val[0]);
  if (val.length == 2)
    n = noise(val[0], val[1]);
  if (val.length == 3)
    n = noise(val[0], val[1], val[2]);
  
  for (int i = 0; i < f.length; i++) {
    if (n < f[i]) {
      return i;
    }
  }
  return f.length;
}