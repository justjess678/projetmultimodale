import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
//import websockets.*;

int PosX = 20;
int PosY = 20;
int rectsize = 60;
int screenX = 640;
int screenY = 360;
PShape nullShape = new PShape();
ArrayList<PShape> allshapes = new ArrayList<PShape>();
Map<PShape,ArrayList<Integer>> shapeInfo = new HashMap();
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
    //put shape at location of mou
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
  int colorNum = -1;
  switch (col){
   case "red": shapecolor = color(232, 38, 34);
               colorNum = 1;
               break;
   case "blue": shapecolor = color(34, 199, 232);
               colorNum = 2;
               break;
   case "indigo": shapecolor = color(16, 17, 102);
               colorNum = 3;
               break;
   case "green": shapecolor = color(34, 226, 37);
               colorNum = 4;
               break;
   case "yellow": shapecolor = color(229, 226, 41);
               colorNum = 5;
               break;
   case "orange": shapecolor = color(224, 160, 33);
               colorNum = 6;
               break;
   case "pink": shapecolor = color(242, 205, 240);
               colorNum = 7;
               break;
   case "purple": shapecolor = color(114, 21, 109);
               colorNum = 8;
               break;
   case "black": shapecolor = color(0);
               colorNum = 9;
               break;
   case "grey": shapecolor = color(110);
               colorNum = 10;
               break;
   case "white": shapecolor = color(255);
               colorNum = 11;
               break;
   default: shapecolor = color(232, 38, 34);
               colorNum = 1;
               break;
  }
   //actual shape
   PShape myShape;int typeNum = -1;
   if(type== "rectangle"){
    myShape = createShape(RECT,0,0,shapesize*random(1,3),shapesize);
    typeNum = 1;
   }else if(type== "carre"){
    myShape = createShape(RECT,0,0,shapesize,shapesize);
    typeNum = 2;
   }else{
    myShape =  createShape(ELLIPSE,0,0,shapesize,shapesize);
    typeNum = 3;
   }
   if(type== "triangle"){
    print("NOPE\n");
    typeNum = 4;
   }
   myShape.setFill(shapecolor);
   myShape.setStroke(false);
   allshapes.add(myShape);
   ArrayList<Integer> details = new ArrayList();
   details.add(colorNum);
   details.add(typeNum);
   details.add(Math.round(x));
   details.add(Math.round(y));
   shapeInfo.put(myShape,details);
   print("vous avez cree un "+size+" "+type+" "+col+"\n");
}

void moveShape(String col, String type, String size, String newSide, String newHiPos, Boolean here, int newInMouseX, int newInMouseY){
  //find the shape to move
  PShape myShape = findShape(col, type, size);
  if(myShape != nullShape){
    float x=0;
    float y=0;
    int min = 0;
    int max = 0;
    if(!here){
      //side
      if (newSide == "mid"){
        min = round(screenX/3);
        max = round(screenX*2/3);
      }
      if (newSide == "left"){
        min = 0;
        max = round(screenX/3);
      }
      if (newSide == "right"){
        min = round(screenX*2/3);
        max = round(screenX);
      }
      x=random(min,max);
      //height
      if (newHiPos == "mid"){
        min = round(screenY/3);
        max = round(screenY*2/3);
      }
      if (newHiPos == "bottom"){
        min = 0;
        max = round(screenY/3);
      }
      if (newHiPos == "top"){
        min = round(screenY*2/3);
        max = round(screenY);
      }
      y=random(min,max);
    }else{
      //here
      
    }
  }else{
    print("Shape not found!\n");
  }
}

void deleteShape(String col, String type, String size){
  PShape myShape = findShape(col, type, size);
  if(myShape != nullShape){
    allshapes.remove(myShape);
    shapeInfo.remove(myShape);
  }else{
    print("Shape not found!\n");
  }
}

PShape findShape(String col, String type, String size){
  //handling default values
  if(col==""){col="rouge";}
  if(type==""){type="rectangle";}
  if(size==""){size="moyen";}
  Boolean isShape = false;
  for(PShape s : allshapes){
    if(s.height<=50 && size=="petit"){
      isShape=true;
    }else if(s.height<=100 && s.height>50 && size=="moyen"){
      isShape=true;
    }else if(s.height>100 && size=="grand"){
      isShape=true;
    }else{
      isShape=false;
    }
    //size is ok, check color
    if(isShape){
      ArrayList<Integer> tmp = shapeInfo.get(s);
      int colNum = tmp.get(0);
      String tmpCol = "";
      switch(colNum){
        case 1: tmpCol = "red";
                break;
        case 2: tmpCol = "blue";
                break;
        case 3: tmpCol = "indigo";
                break;
        case 4: tmpCol = "green";
                break;
        case 5: tmpCol = "yellow";
                break;
        case 6: tmpCol = "orange";
                break;
        case 7: tmpCol = "pink";
                break;
        case 8: tmpCol = "purple";
                break;
        case 9: tmpCol = "black";
                break;
        case 10: tmpCol = "grey";
                break;
        case 11: tmpCol = "white";
                break;
        default: tmpCol = "red";
                break;
      }
      if(tmpCol == col){
        isShape = true;
      }else{
        isShape = false;
      }
    }
    //color is ok, check type
    if(isShape){
      ArrayList<Integer> tmp = shapeInfo.get(s);
      int typeNum = tmp.get(1);
      String tmpType = "";
      switch(typeNum){
        case 1: tmpType = "rectangle";
                break;
        case 2: tmpType = "carre";
                break;
        case 3: tmpType = "cercle";
                break;
        case 4: tmpType = "triangle";
                print("NOPE\n");
                break;
        default: tmpType = "rectangle";
                break;
      }
      if(tmpType==type){
        isShape=true;
      }else{
        isShape= false;
      }
    }
    //final: ALL IS GOOD
    if(isShape){
      return s;
    }
  }
  return nullShape;
}

//MAIN

String position1 = "";
String position2 = "";
String forme = "";
String couleur = "";
String taille = "";
String voc = "";
String action = "";
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
  action = "creer";
  if(vocIn && souris && action=="creer"){ // voice and mouse detected to draw
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
