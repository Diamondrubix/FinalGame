static abstract class staticTile{
     static int size = 30;
 }
public class Tile extends Entity {

    public Tile(int x, int y) {
        super(x, y, staticTile.size, staticTile.size);
        //setHasGravity(false);
    }

    public void paint(int xOff,int yOff){
        drawRect(x+xOff,y+yOff,width,height,0,Color.GREEN);
    }
    
}
