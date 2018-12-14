public class spotlight extends Actor {
  Color c = Color.YELLOW;
  public boolean friendlyFire = false;
  public spotlight(int x, int y){
    super(x, y, 100, 100, true);
    speed = 5;
    
  }
  
  void fire(){
    c = Color.RED;
    for(int i =0; i <enemies.size();i++){
      if(this.collides(enemies.get(i))){
        enemies.get(i).kill();        
      }
    }
    
   if(this.collides(player)){
        if(!friendlyFire){
          energyCap = energyCap -20;
          friendlyFire = true;
        }
      }else{
        friendlyFire = false;
      }
      
  }
  
  void paint(){
    drawEllipse(x+Width/2,y+Height/2,Width,Height, 0, c);
    //drawRect(getBounds(),Color.CYAN);
    c = Color.YELLOW;
  }
  
      public void moveUp(double s){
      y+=s;
    }
    public void moveDown(double s){
      y+=s;
    }
    public void moveRight(double s){
      x-=s;
    }
    public void moveLeft(double s){
      x-=s;
    }

  
  
}
