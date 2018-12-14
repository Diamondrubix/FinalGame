import java.util.Random;
public class Enemy extends Actor {
  public boolean alive = true;
  public boolean top = true;
  public boolean right = true;
  public Enemy(int x, int y, int w, int h){
    super (x,y,w,h, true);
    yVelocity = speed;
  }
    public Enemy(int x, int y){
    super (x,y, true);
    yVelocity = speed;
  }
  
  public Enemy(){
    super(-100,-100,true);
    this.x = (int)(Math.random() * ((width) + 1));
    this.y = -this.Height;
    //yVelocity = -speed;
  }
    
  public Enemy(boolean t){
    super(-100,-100,true);
    top = t;
    if(top){
      this.x = (int)(Math.random() * ((width) + 1));
      this.y = -this.Height;
    }else{
      this.y = (int)(Math.random() * ((height)+1));
      Random r = new Random(); 
      right = r.nextBoolean();
      if(right){
        this.x = 0;
      }else{
        this.x = width+this.Width;
      }
    }
    //yVelocity = -speed;
  }
  
  public void kill(){
    alive = false;
  }
  
  
  public void tick(){
    if(alive){
      if(top){
        y+=speed; 
        if((y+this.Height)>height){
          //alive = false;
          this.kill();
        }
      }else{
        if(right){
          x+=speed;
          if((x+this.Width)>width){
            this.kill();
          }
        }else{
          x-=speed;
          if(x<0){
            this.kill();
          }
        }
      }
    }
     
  }
  
  public void paint(int xOffset, int yOffset){
    drawRect(x,y,Width, Height, 0, Color.BLUE);
  }

  
  
}
