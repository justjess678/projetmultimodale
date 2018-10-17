import java.util.ArrayList;
import websockets.*;

int PosX = 20;
int PosY = 20;
int rectsize = 60;
int screenX = 640;
int screenY = 360;
ArrayList<PShape> allshapes = new ArrayList<PShape>();
ArrayList<Float> allX = new ArrayList<Float>();
ArrayList<Float> allY = new ArrayList<Float>();

void setup(){
  size(640, 360);
  background(255); 
}

void createShape(String side, String hiPos, String col, String type, String size){
  //handling default values
  if (side == ""){ side="mid"; }
  if (hiPos == ""){ hiPos="mid"; }
  if (col == ""){ col="red"; }
  if (type == ""){ type="rectangle"; }
  if (size == ""){ size="medium"; }
  //side
  float x=0;
  int min = 0;
  int max = 0;
  if (side == "mid"){
    min = round(screenX/3);
    max = round(screenX*2/3);
  }
  if (side == "left"){
    min = 0;
    max = round(screenX/3);
  }
  if (side == "right"){
    min = round(screenX*2/3);
    max = round(screenX);
  }
  x=random(min,max);
  //height
  float y=0;
  if (hiPos == "mid"){
    min = round(screenY/3);
    max = round(screenY*2/3);
  }
  if (hiPos == "bottom"){
    min = 0;
    max = round(screenY/3);
  }
  if (hiPos == "top"){
    min = round(screenY*2/3);
    max = round(screenY);
  }
  y=random(min,max);
  //size
  float shapesize=0;
  if (size == "medium"){
    min = 50;
    max = 100;
  }
  if (size == "small"){
    min = 10;
    max = 50;
  }
  if (size == "big"){
    min = 100;
    max = 200;
  }
  shapesize=random(min,max);
  //colours
  color shapecolor = color(232, 38, 34);
  switch (col){
   case "red": shapecolor = color(232, 38, 34);
   case "blue": shapecolor = color(34, 199, 232);
   case "indigo": shapecolor = color(16, 17, 102);
   case "green": shapecolor = color(34, 226, 37);
   case "yellow": shapecolor = color(229, 226, 41);
   case "orange": shapecolor = color(224, 160, 33);
   case "pink": shapecolor = color(242, 205, 240);
   case "purple": shapecolor = color(114, 21, 109);
   case "black": shapecolor = color(0);
   case "grey": shapecolor = color(110);
   case "white": shapecolor = color(255);
   default: shapecolor = color(232, 38, 34);
  }
   //actual shape
   PShape myShape;
   switch(type){
    case "rectangle": myShape = createShape(RECT,0,0,shapesize,shapesize);
    case "triangle": myShape =  createShape(TRIANGLE,0,0,shapesize,shapesize);
    default: myShape =  createShape(ELLIPSE,0,0,shapesize,shapesize);
   }
   myShape.setFill(shapecolor);
   myShape.setStroke(false);
   allshapes.add(myShape);
   allX.add(x);
   allY.add(y);
}

void moveShape(String col, String type, String size, String newSide="", String newHiPos="",int newX=-1000,int newY=-1000){
  
}

void draw(){
  noStroke();
  background(255);
  //draws each shape
  for(int i=0;i<allshapes.size();i++){
    shape(allshapes.get(i),allX.get(i),allY.get(i));
  }
}

void keyPressed() {
  if(key == CODED) {
    if(keyCode == LEFT) PosX--;
    if(keyCode == RIGHT) PosX++;
    if(keyCode == UP) PosY--;
    if(keyCode == DOWN) PosY++;
  }
}
