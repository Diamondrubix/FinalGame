
public class Actor extends Entity {


    public Actor(int x, int y, int w, int h, boolean collidable) {
        super(x, y, w, h, collidable);
        setHasGravity(false);
    }
    
    public Actor(int x, int y, boolean collidable){
      super(x, y, 30, 30, collidable);
        setHasGravity(false);
    }
    
    public boolean collides(Entity e){
      return this.getBounds().intersects(e.getBounds());
    }
    


    @Override
    public void tick() {
        super.tick();

    }
}
