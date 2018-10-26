import java.util.ArrayList;
//import websockets.*;

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

void createShape(float inMouseX, float inMouseY, Boolean here, String side, String hiPos, String col, String type, String size){
  //handling default values
  if (side == ""){ side="mid"; }
  if (hiPos == ""){ hiPos="mid"; }
  if (col == ""){ col="red"; }
  if (type == ""){ type="rectangle"; }
  if (size == ""){ size="medium"; }
  float x=0;
  float y=0;
  int min = 0;
  int max = 0;
  if(!here){
  //side
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
  }else{
  x = inMouseX;
  y = inMouseY;
  }
  //size
  float shapesize=0;
  if (size == "moyen"){
    min = 50;
    max = 100;
  }else if (size == "petit"){
    min = 10;
    max = 50;
  }else{
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
   if(type== "rectangle"){
    myShape = createShape(RECT,0,0,shapesize*random(1,3),shapesize);
   }else{
    myShape =  createShape(ELLIPSE,0,0,shapesize,shapesize);
   }
   myShape.setFill(shapecolor);
   myShape.setStroke(false);
   allshapes.add(myShape);
   allX.add(x);
   allY.add(y);
   print("vous avez cree un "+size+" "+type+" "+col+"\n");
}

void moveShape(String col, String type, String size, String newSide, String newHiPos, Boolean here, int newInMouseX, int newInMouseY, int newX,int newY){
  //find the shape to move
  
  if(!here){
    
  }else{
  
  }
}


String position1 = "";
String position2 = "";
String forme = "";
String couleur = "";
String taille = "";
String voc ="";
float sourisX = 0.0f;
float sourisY = 0.0f;
Boolean vocIn = false;
Boolean souris = false;

void draw(){
  noStroke();
  background(255);
  //draws each shape
  for(int i=0;i<allshapes.size();i++){
    shape(allshapes.get(i),allX.get(i),allY.get(i));
  }
  //GET VOCAL INPUT
  //example sra5 output
  voc = "sra5 Parsed=\'cetobjet\' NP=\'0\' Num_A=\'0\'";
 
  position1 = "ici";
  position2 = "";
  forme = "rectangle";
  couleur = "rouge";
  taille = "moyen";
  if(vocIn && souris){ // voice and mouse detected
      createShape(mouseX, mouseY, (position1 == "ici"), position2, position1, couleur, forme, taille);
      vocIn = false;
      souris = false;
    }
}

//for testing only - this simulates voice input
void keyPressed(){
  vocIn = true;
  print("voice input detected\n");
}

void mouseClicked() {
  souris = true;
  print("mouse clicked detected\n");
  sourisX = mouseX;
  sourisY = mouseY;
}

