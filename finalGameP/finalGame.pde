import processing.serial.*;
import java.util.ArrayList;
import java.awt.Rectangle;

Map map = new Map(0,0,0,0, new Camera(0,0));
Player player;
spotlight sl;
int Score = 0;
int tempo = 20;
int energyCap = 200;
int energy = 200;
boolean paused = false;
boolean gameOver = false;
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
public ArrayList<String> keys = new ArrayList<String>();
GameManager gm;
Serial myPort;
void setup(){
  myPort = new Serial(this, Serial.list()[0], 115200);
     myPort.bufferUntil('\n');
  println("GameStart");
  //size(900, 600);
  size(1700, 1000);
  background(0,0,0);
  stroke(255,255,255);
  fill(0,100,255);
  gm = new GameManager();
  player = new Player(width/2,height/2);
  sl = new spotlight(width/2, height/2);
}

boolean first =true;
//used only to setup a constant length tick.
void draw(){    
  gm.sync();
  if(first){
    delay(2000);
    first = false;
  }
  
  tick();
  keyInputs();
  //should prolly not be here cuz pain is now tied to fps // then again, I don't think I can use threads...
  paint();
  textSize(16);
  fill(255,255,255);
  text("Score:"+Score, 50, 50);
  text("Energy:"+energy, width-150, 50);
  text("MaxEnergy:"+energyCap, width-450, 50);
}
boolean swapEnemy = true;
int energyCount = 0;
boolean noMore = false;
void tick(){
  if(!paused){
    energyCount++;
    if(energyCount>5 && energy< energyCap){
      energy++;
      energyCount = 0;
    }
  boolean foundDead = false;
  if(Score%3==0 && !noMore){
    noMore = true;
    tempo++;
    //:"+Score%5);
    //println("tempo:"+tempo);
  }
  player.tick();
  map.tick();
  for(int i =enemies.size(); i <tempo; i++){
    enemies.add(new Enemy(swapEnemy));
    swapEnemy = !swapEnemy;
  }
  
  for(int i =0; i<enemies.size();i++){
    Enemy temp = enemies.get(i);
    if(temp.alive){
      foundDead = true;
    }
    enemies.get(i).tick();
    
    if(player.collides(enemies.get(i))){
      paused = true;
      player.gameOver();
      println("GAME OVER");
    }
   
  }
  
  if(foundDead){
     for(int i =0; i<enemies.size();i++){
      Enemy temp = enemies.get(i);
      if(!temp.alive){
        enemies.remove(i);
        Score++;
        noMore = false;
        
     }
  }
  }
  }
  
  
}




void paint(){
   betterClear();

   sl.paint();
   player.paint(0,0);
   map.paint(0,0);
   for(int i =0; i<enemies.size();i++){
    enemies.get(i).paint(0,0);
  }
  //player.paint(0,0);

  
}

//all things involving keys go here
void keyInputs(){
   //key inputs
 if(bmove){
     //println("iKey "+iKey);
if(keys.contains("s")){
    player.moveUp();
  }else if(keys.contains("w")){
    player.moveDown();
  }
  if(keys.contains("d")){
    player.moveRight();
  }else if(keys.contains("a")){
    player.moveLeft();
  }
  if(keys.contains("f")){
    sl.fire();
  }
 }
}





public boolean bmove = false;
//user interface area
//serial
int joyX = 0;
int joyY = 0;
double pitch = 0; //on x
double roll =0; //on y
int joyXBase = 0;
int joyYBase = 0;
double pitchBase = 0;
double rollBase =0;
boolean a = false;
boolean b = false;
int serialCount = 0;
int deadSpace = 10;
int unsprint = 0;
void serialEvent (Serial myPort) {

  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');
  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    
      if(serialCount < 22){

        if(inString.contains("joystick")){
          if(inString.substring(8,9).equals("X")){
            joyXBase = Integer.parseInt(inString.substring(10,inString.length()));
            //println("joyXBase:"+joyXBase);
            serialCount++;
          }else if(inString.substring(8,9).equals("Y")){
            joyYBase = Integer.parseInt(inString.substring(10, inString.length()));
            //println("joyYBase:"+joyYBase);
            serialCount++;
          }
        }else if(inString.contains("pitch:")){
          pitchBase = Double.parseDouble(inString.substring(6,inString.length()));
          //println("pitchBase:"+pitchBase);
          serialCount+=10;
        }else if(inString.contains("roll:")){
          rollBase = Double.parseDouble(inString.substring(5,inString.length()));
          //println("rollBase:"+rollBase);
          serialCount+=10;
        }
      }else{   
        if(inString.contains("joystick")){
          if(inString.substring(8,9).equals("X")){
            joyX = Integer.parseInt(inString.substring(10,inString.length())) - joyXBase;
            //println("joyX:"+joyX);
            if(joyX>deadSpace){
              player.moveDown();
            }
            if(joyX<-deadSpace){
              player.moveUp();
            }
            
          }
          if(inString.substring(8,9).equals("Y")){
            joyY = Integer.parseInt(inString.substring(10,inString.length())) - joyYBase;
            //println("joyY:"+joyY);
             if(joyY>deadSpace){
              player.moveRight();
            }
            if(joyY<-deadSpace){
              player.moveLeft();
            }
          }
            
        }
        if(inString.contains("pitch:")){
          pitch = Double.parseDouble(inString.substring(6,inString.length())) - pitchBase;
          //println("pitch:"+pitch);
          if(pitch>deadSpace){
            sl.moveLeft(pitch/5);
          }
          if(pitch<-deadSpace){
            sl.moveRight(pitch/5);
          }
          
        }
        if(inString.contains("roll:")){
          roll = Double.parseDouble(inString.substring(5,inString.length())) - rollBase;
          //println("roll:"+roll);
          if(roll>deadSpace){
            sl.moveUp(roll/5);
          }
          if(roll<-deadSpace){
            sl.moveDown(roll/5);
          }
        }else{
          //println("misc:"+inString);
        }
        if(inString.contains("button:a")&&energy>0){
          sl.fire();
          energy--;
          if(energy<=0){
            energyCount = -500;
          }
          
        }
        if(inString.contains("button:b")){
          player.sprint(true);
        }else{
          unsprint++;
          if(unsprint>4){
          player.sprint(false);
          unsprint =0;
          }
        }
      }
  }
}
//KEY MANAGER AREA
void keyPressed(){
  bmove = true;
 
 
 if(!dups(String.valueOf(key))){
  keys.add(String.valueOf(key));
 }
   if(key == 'l'){
    //save
    //save("furbyDrawing.png");ss
    //saves based on fram
     saveFrame("drawing-######.png");
  }
}

void keyReleased(){
  
  keys.remove(String.valueOf(key));
  if(keys.size() == 0){
    bmove = false;
  }
}
boolean dups(String k){
  for(int i =0; i <keys.size();i++){
          //println("dup "+keys.get(i)+" key "+k);
    if(keys.get(i).equals(k)){
      //println("true");
      return true;
    }
  }
  //println("false");
  return false;
}

//util
void betterClear(){
  clear();
  background(0,0,0);
}
