
import java.awt.Rectangle;
import java.util.ArrayList;

public class Entity extends Drawable {
    
    protected boolean collidable = true;
    protected boolean hasGravity = false;
    public final double gravitySpeed = .3;
    public float terminalVelocity = 200;
    public float yVelocity = 0;
    public float xVelocity = 0;
    public ArrayList<Map> maps = new ArrayList<Map>();
    public Rectangle bounds;
    public Rectangle collideBounds;
    protected int ogSpeed = 2;
    protected int speed = ogSpeed;

    public Camera camera;


    public Entity(int x, int y, int w, int h, boolean collidable) {
        super(x, y, w, h);
        this.collidable = collidable;
        this.bounds = new Rectangle(x,y,width,height);
        this.collideBounds = new Rectangle(x,y,width,height);
    }

    public Entity(int x, int y, int width, int height) {
        super(x, y, width, height);
        this.bounds = new Rectangle(x,y,width,height);
        this.collideBounds = new Rectangle(x,y,width,height);
    }


    public boolean isCollidable() {
        return collidable;
    }

    public void setCollidable(boolean collidable) {
        this.collidable = collidable;
    }

    public boolean hasGravity() {
        return hasGravity;
    }

    public void setHasGravity(boolean hasGravity) {
        this.hasGravity = hasGravity;
    }


    public void attachToMap(Map map){
        maps.add(map);
    }

    public Rectangle getBounds(){
        return new Rectangle(x,y,Width,Height);
    }




    public Collision isTouching(float dx, float dy){
        if(!isCollidable())return new Collision();
        collideBounds = new Rectangle((int)(x+dx),(int)(y+dy),width,height);
        for(Map map: maps){
            for(Entity entity : map.getEntities()){
                if(collideBounds.intersects(entity.getBounds()) && entity.isCollidable() && entity!=this) {
                    //once you found the colliding tile pass it into this function to get directions
                    return applyDirection(entity);
                }
            }
        }
        return new Collision();
    }


    //once the colliding tile is found you need this to find the direction info
    private Collision applyDirection(Entity entity){
        int vDist = y-entity.getY();
        int hDist = x-entity.getX();
        int hitbox = -1;

        if (y >entity.getY()) {
            hitbox = Collision.ABOVE;
        } else if(y<entity.getY()) {
            hitbox = Collision.BELOW;
        }else if (x < entity.getX()) {
            hitbox = Collision.RIGHT;
        } else if (x > entity.getX()) {
            hitbox = Collision.LEFT;
        }
        return new Collision(entity, hitbox,vDist,hDist);

    }

    public void moveBy(float dx, float dy){
        Collision touching = isTouching(dx,dy);

        int oldY = 0;
        int oldX = 0;

        if(isAttachedToCamera()){
            oldY = y;
            oldX = x;
        }

        if(!touching.happened){
            x += dx;
            y += dy;

        }else{



            if(Math.abs(touching.vDist)> Math.abs(touching.hDist)){
                if(touching.hitbox==touching.BELOW){
                    yVelocity = 0;
                    y = touching.entity.getY()-touching.entity.getHeight();
                }else if(touching.hitbox==touching.ABOVE) {
                    yVelocity = 0;
                    y = touching.entity.getY() + touching.entity.getHeight();
                }
            }else {
                if (touching.hitbox == touching.RIGHT) {
                    y += dy;
                    xVelocity = 0;
                    x = touching.entity.getX() - width;
                } else if (touching.hitbox == touching.LEFT) {
                    y += dy;
                    xVelocity = 0;
                    x = touching.entity.getX() + touching.entity.getWidth();
                }
            }



        }

        if(isAttachedToCamera()) {
            int camChangeY = oldY - y ;
            int camChangeX = oldX - x ;
            camera.y += camChangeY;
            camera.x += camChangeX;
        }

    }

    public void launch(int dx, int dy){
        xVelocity+=dx;
        yVelocity+=dy;
    }

    public boolean isAttachedToCamera(){
        return camera != null;
    }

    public void attachCamera(Camera camera){
        this.camera = camera;
        camera.focus(this);
    }

    //this is stupid
    public boolean isResting(){
        return yVelocity < 1;
    }

    public void tick(){

        moveBy(xVelocity, yVelocity);

        if(hasGravity){
            yVelocity += gravitySpeed;
        }

        if( yVelocity > terminalVelocity)yVelocity=terminalVelocity;


    }

}
