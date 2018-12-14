import java.nio.FloatBuffer;
import java.awt.Color;

public class Drawable {

    protected int x;
    protected int y;
    protected int Width;
    protected int Height;
    protected boolean visible = true;
    protected int sWidth = 30;
    protected int sHeight = 30;

    public Drawable(int x, int y, int w, int h){
        this.x = x;
        this.y = y;
        this.Width = w;
        this.Height = h;
    }


    public void paint(int xOff, int yOff){

        drawRect(x+xOff,y+yOff,Width,Height,0,Color.RED);
    }

    public void paint(Camera cam){
        paint(cam.x,cam.y);
    }

    public void tick(){

    }

    public void drawRect(Rectangle rect, Color c){
        drawRect(rect.x, rect.y, rect.width, rect.height,0,c);
    }


    public void drawRect(float x, float y, float w, float h, float rot, Color c){
      fill(c.getRed(), c.getGreen(), c.getBlue());
      stroke(c.getRed(), c.getGreen(), c.getBlue());
      rect(x,y,w,h);
    }
    public void drawRect(float x, float y, float w, float h, float rot, Color c,Color stroke){
      fill(c.getRed(), c.getGreen(), c.getBlue());
      stroke(stroke.getRed(), stroke.getGreen(), stroke.getBlue());
      rect(x,y,w,h);

    }
    
    public void drawEllipse(float x, float y, float w, float h, float rot, Color c){
      fill(c.getRed(), c.getGreen(), c.getBlue());
      stroke(c.getRed(), c.getGreen(), c.getBlue());
      ellipse(x,y,w,h);
    }

    public void drawEmptyRect(float x, float y, float w, float h, float rot, Color c){
      drawRect(x,y,w,h,rot, c, new Color(255,255,255));
    }


    public int getX() {
        return x;
    }

    public void setX(int x) {
        this.x = x;
    }

    public int getY() {
        return y;
    }

    public void setY(int y) {
        this.y = y;
    }

    public int getWidth() {
        return this.Width;
    }

    public void setWidth(int w) {
        this.Width = w;
    }

    public int getHeight() {
        return this.Height;
    }

    public void setHeight(int h) {
        this.Height = h;
    }


    public boolean isVisible() {
        return visible;
    }

    public void setVisible(boolean visible) {
        this.visible = visible;
    }
}
