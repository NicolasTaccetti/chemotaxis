boolean isArmyOne;
PFont f;
int warsPlayed;
int advantage1;
int advantage2;
Wars thisWar;


void setup() {  
  
    f=createFont("Arial",50,true);
    thisWar=new Wars(500,1000);
   size(1000, 1000);
   background(255);
   warsPlayed=0;
   
}

void draw()  {
  background(255);

    thisWar.createCountries();
    thisWar.simulateBattle();
    
  if(thisWar.getArmy1().size()<=0){
    //noLoop();
    stroke(0);
    textFont(f);
    
    textAlign(CENTER);
    text("GAME OVER\nRED WINS",width/2,height/2);
    }
  if(thisWar.getArmy2().size()<=0){
    //noLoop();
    stroke(0);
    textFont(f);
    
    textAlign(CENTER);
    text("GAME OVER\nBLUE WINS",width/2,height/2);
    }
}

class Troops {
     int xPos;
      int yPos;
     int size;
     boolean isAlive;

  Troops() {
       if(isArmyOne){
           xPos=0;
       }
       else{
         xPos=width;
       }
         yPos=500;
         size=(int)(Math.random()*20)+5;   
     
  }
  void drawTroop() {
    if(isAlive){
    if(isArmyOne){
    fill(255,0,0);
    }
    else{
      fill(0,0,255);
    }
    ellipse(xPos,yPos,size,size);
    }
  }
  void moveTroop() {
       yPos+=(int)(Math.random()*5)+1;
       if(isArmyOne){
         xPos+=(int)(Math.random()*20)-5;
       }
       else{
         xPos-=(int)(Math.random()*20)-5;
   }
  }
  
  void skirmish(Troops other){
    if(Math.abs(xPos-other.xPos)<10&&Math.abs(yPos-other.yPos)<10){
  if(size>other.size){
  other.isAlive=false;
}
  else if(other.size>size){
    isAlive=false;
   }
}
  }
  boolean getIsAlive() {
    return isAlive;
  }
}

class Wars {
     ArrayList<Troops> army1;
ArrayList<Troops> army2;
     
     Wars (int country1, int country2) {
     army1= new ArrayList<Troops>(country1);
       isArmyOne=true;
      for(int i=0;i<country1;i++) {
        army1.add(new Troops());
      }
      army2= new ArrayList<Troops>(country2);
      for(int i=0;i<country2;i++) {
        army2.add(new Troops());
      }
     }
       ArrayList<Troops> getArmy1(){
         return army1;
       }
       ArrayList<Troops> getArmy2(){
         return army2;
       }
      void mousePressed() {//adds reinforcements
   if(army1.size()<200){
      army1.add(new Troops());
      }
     if(army2.size()<200){
       army2.add(new Troops());
     }
   }

   void createCountries() {
     //creates borders
     //first country
    
     int beginx1=(int)(Math.random()*1000)+1;
      int beginy1=(int)(Math.random()*1000)+1;
      int beginx2= (int)(Math.random()*1000)+1;
      int beginy2=(int)(Math.random()*1000)+1;
       if(warsPlayed==0){
         fill(255,0,0);
     stroke(255,0,0);
     beginShape();//first country
     curveVertex(beginx1, beginy1);
     curveVertex(beginx1,beginy1);
     while(mouseX!=beginx1 && mouseY!=beginy1){
       int x=mouseX;
       int y=mouseY;
       fill(255,0,0,5);
     curveVertex(mouseX,mouseY);
     triangle(x,y,beginx1,beginy1,mouseX,mouseY);
     }
     curveVertex(beginx1, beginy1);
     curveVertex(beginx1,beginy1);
     endShape();
     
     //other country
     stroke(0,0,255);
     beginShape();
     curveVertex(beginx2, beginy2);
     curveVertex(beginx2,beginy2);
     while(mouseX!=beginx2 && mouseY!=beginy2){
       int x=mouseX;
       int y=mouseY;
       fill(0,0,255,5);
     curveVertex(mouseX,mouseY);
     triangle(x,y,beginx2,beginy2,mouseX,mouseY);
     }
     curveVertex(beginx2, beginy2);
     curveVertex(beginx2,beginy2);
     endShape();
       }
       
     else{
       if(army1.size()>army2.size()){
         stroke(0,0,255);
         float theta=0;
         advantage1++;
         advantage2--;
         int timer=0;
         // int x=(beginx1-beginx2)/(int)(mouseX/Math.abs(advantage));
         //int y=(beginy1-beginy2)/(int)(mouseY/Math.abs(advantage));
         float x=advantage1*(beginx1-beginx2)*(sin(theta));
         float y=advantage1*(beginx1-beginx2)*(sin(theta));
     beginShape();
     curveVertex(beginx1, beginy1);
     curveVertex(beginx1,beginy1);
     
     //while(x!=0&&y!=0){
     //curveVertex(beginx1+(x/(int)(mouseX/Math.abs(advantage))),beginy1+(y/(int)(mouseY/Math.abs(advantage))));
     //  triangle(beginx1+x,beginy1+y,beginx1,beginy1,beginx1+(x/(int)(mouseX/Math.abs(advantage))),beginy1+(y/(int)(mouseY/Math.abs(advantage))));
     //x/=(int)(mouseX/Math.abs(advantage));
     //y/=(int)(mouseY/Math.abs(advantage));
     //}
     while(timer<100){
     curveVertex(beginx1+x/mouseX,beginy1+x/mouseY);
       triangle(beginx1+x,beginy1+y,beginx1,beginy1,beginx1+x/mouseX,beginy1+y/mouseY);
       theta+=TWO_PI/25.0;
     x=advantage1*(beginx1-beginx2)*(sin(theta));
     y=advantage1*(beginx1-beginx2)*(sin(theta));
     timer++;
     println(timer);
     }
     curveVertex(beginx1, beginy1);
     curveVertex(beginx1,beginy1);
     endShape();
       }
       
       else if(army2.size()>army1.size()){
         float theta=PI;
         advantage2++;
         advantage1--;
         int timer=0;
         float x=advantage2*(beginx2-beginx1)*(sin(theta));
         float y=advantage2*(beginx2-beginx1)*(sin(theta));
         //int x=(beginx2-beginx1)/(int)(mouseX/Math.abs(advantage));
         //int y=(beginy2-beginy1)/(int)(mouseX/Math.abs(advantage));
         
          beginShape();
     curveVertex(beginx2, beginy2);
     curveVertex(beginx2,beginy2);
     
     while(timer<100){
     curveVertex(beginx2+x/mouseX,beginy2+x/mouseY);
       triangle(beginx2+x,beginy2+y,beginx2,beginy2,beginx2+x/mouseX,beginy2+y/mouseY);
       theta+=TWO_PI/25.0;
     x=advantage2*(beginx2-beginx1)*(sin(theta));
     y=advantage2*(beginx2-beginx1)*(sin(theta));
     timer++;
     println(timer);
     }
     curveVertex(beginx2, beginy2);
     curveVertex(beginx2,beginy2);
     endShape();
       }
     }
     warsPlayed++;
   }


   void simulateBattle() {
     
      for(int j=army1.size()-1;j>=0;j--){
        army1.get(j).moveTroop();
        
        for(int i=army2.size()-1;i>=0;i--){
          
        if(j==army1.size()-1){
           army2.get(i).moveTroop();
        }
        army1.get(i).skirmish(army2.get(i));
        if(!army2.get(i).getIsAlive()){
          army2.remove(i);
        }
        if(!army1.get(j).getIsAlive()){
          army1.remove(j);
        }
        army2.get(i).drawTroop();
       
      }
      army1.get(j).drawTroop();
      
     }

   }

}
