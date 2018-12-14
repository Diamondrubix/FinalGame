
public class Player extends Actor {

    public boolean boundBoxes = false;



    public Player(int x, int y) {
        //super(x, y, Tile.size, Tile.size,true);
        super(x, y,true);
    }
    
    void sprint(boolean s){
      if(!gameOver){
      if(s){
        speed = ogSpeed+2;
      }else{
        speed = ogSpeed;
      }
      }
    }
    
   
    void gameOver(){
      ogSpeed = 0;
      speed = 0;
    }
    


    public void paint(int xOffset, int yOffset){

        //super.paint(xOffset,yOffset);
        drawRect(x,y,this.Width, this.Height, 0,Color.GREEN);

        if(boundBoxes) {
             drawRect(collideBounds,Color.CYAN);
        }

    }

    public void tick(){
        super.tick();
    }
    
    public void moveUp(){
      if(y<height-this.Height){
      y+=speed;
      }
    }
    public void moveDown(){
      if(y>0){
         y-=speed;
      }
    }
    public void moveRight(){
     if((x+this.Width+30) < width){
      x+=speed;
     }
      
    }
    public void moveLeft(){
      if(x>0){
      x-=speed;
      }
    }


}
