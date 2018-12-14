

public class Collision{

    public Entity entity;
    public boolean happened=true;

    public int hitbox;

    public static final int ABOVE = 0;
    public static final int RIGHT = 1;
    public static final int BELOW = 2;
    public static final int LEFT = 3;

    public int horizontal;
    public int vDist;
    public int hDist;

    public Collision(Entity entity, int hitbox){
        this.entity = entity;
        this.hitbox = hitbox;
        horizontal = hitbox%2;


    }
    public Collision(Entity entity, int hitbox, int vD, int hD){
        this.entity = entity;
        this.hitbox = hitbox;
        horizontal = hitbox%2;
        vDist = vD;
        hDist = hD;


    }

    public boolean horizontal(){
        return horizontal==1;
    }

    public Collision(){
        happened = false;
    }

}
