

import java.util.ArrayList;

public class Map extends Drawable {

    //user can use this
    protected ArrayList<Entity> entities = new ArrayList<Entity>();

    //this is internal, and is used for collision algorithm
    //protected ArrayList<ArrayList<Tile>> tileBuckets = new ArrayList<>();
    protected Camera camera;


    public Map(int x, int y, int width, int height, Camera camera) {
        super(x, y, width, height);
        this.camera = camera;

    }

    @Override
    public void paint(int xOff, int yOff) {
        for(int i=0; i< entities.size();i++){
            entities.get(i).paint(camera);
        }
    }


    public boolean addEntity(Entity entity){
        return entities.add(entity);
    }

    public boolean removeEntity(Entity entity){
        return entities.remove(entity);
    }

    public ArrayList<Entity> getEntities(){
        return entities;
    }


    public void invalidateTileBuckets(){

    }

    public void tick(){
        super.tick();
        //System.out.println("fef");

        for(Entity e: entities){
            e.tick();
        }
    }

    public void load(String name){

    }


}
