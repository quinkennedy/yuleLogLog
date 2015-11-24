void setup(){
  size(400, 400);
  background(255);
  stroke(200);
  line(0, height/2, width, height/2);
  stroke(0);
  double min = 0;
  double max = 0;
  for(int i = 0; i < width; i++){
    double g = getGauss((width/2.0 - i)/(width/10.0), 100, -100);
    if (i == 0){
      min = g;
      max = g;
    } else {
      if (min > g){
        min = g;
      }
      if (max < g){
        max = g;
      }
    }
    point(i, height/2 + (float)g);
    //Math.log
  }
  println("min:" + min);
  println("max:" + max);
  noLoop();
}

double getGauss(float curr, float maxOut, float minOut){
  float c = 1.0;
  float a = 1.0/(c*sqrt(TWO_PI));
  float b = 0.0;
  double g = a*Math.exp(-(sq(curr-b)/(2.0*sq(c))));
  return g*(maxOut-minOut)/.4+minOut;
}