public class Spark{
  color c;
  float posX, posY;
  float speedY;
  float frequency, phase, amplitude;
  int startMillis;
  int maxAge;
  float size;
  
  public Spark(){
    init();
  }
  
  public void init(){
    int selected = (int)random(0, 3);
    Colors[] allColors = new Colors[]{Colors.red, Colors.orange, Colors.yellow};
    float[] allSpeeds = new float[]{30, 70, 120};
    int alpha = (int)random(100, 250);
    int blue = (int)random(0, 50);
    switch(allColors[selected]){
      case red:
        c = color((int)random(200, 255), (int)random(0, 50), blue, alpha);
        break;
      case orange:
        c = color((int)random(150, 255), (int)random(50, 150), blue, alpha);
        break;
      case yellow:
        int red = (int)random(150, 255);
        c = color(red, (int)random(150, red), blue, alpha);
        break;
    }
    posX = pow(random(1), 1.3)*width/6*(random(1) < .5 ? -1 : 1) + width/2;
    posY = height*4/5;
    speedY = allSpeeds[selected]+random(-10, 10);
    float speedFalloff = (float)getGauss((width/2 - posX)/(width/20), 30, -30);
    speedY += speedFalloff;
    speedY = max(1, speedY);
    frequency = random(.5, 2);
    phase = random(1);
    amplitude = random(.5, 2);
    startMillis = millis();
    maxAge = (int)random(500, 2000);
    size = random(1, 10);
  }
  
  public void draw(){
    int deltaMillis = millis() - startMillis;
    if (deltaMillis > maxAge){
      init();
    } else {
      float currX = amplitude*sin(TWO_PI*frequency*deltaMillis/1000+phase) + posX;
      float currY = posY - speedY*deltaMillis/1000;
      noStroke();
      fill(c);
      rect(currX, currY, size, size);
    }
  }
}

public enum Colors{
  red,
  orange,
  yellow
}

double getGauss(float curr, float maxOut, float minOut){
  float c = 1.0;
  float a = 1.0/(c*sqrt(TWO_PI));
  float b = 0.0;
  double g = a*Math.exp(-(sq(curr-b)/(2.0*sq(c))));
  return g*(maxOut-minOut)/.4+minOut;
}

Spark[] sparks = new Spark[500];
boolean record = false;

void setup(){
  size(800, 450);
  for(int i = 0; i < sparks.length; i++){
    sparks[i] = new Spark();
  }
}

void draw(){
  background(0);
  for(int i = 0; i < sparks.length; i++){
    sparks[i].draw();
  }
  if (record){
    saveFrame();
  }
}

void keyPressed(){
  switch(key){
    case 'r':
    case 'R':
      record = !record;
      break;
  }
}