import processing.core.*;

public class Arch {  
    PShape arch;
    public PVector location;
    Game parent;
    
    public final static float columnCenter = 36;
    public final static float columnBoard = 40;
    public final static float columnHeight = 0;
    public final static float columnRadius = 30;
    public final static float archWidth = 52;
    public final static float sizeForPrev = 15;
    
    public int archId;

    public Arch(float posX, float posY, int id, Game parent) {
        location = new PVector(posX , posY );
        this.parent = parent;
        arch = parent.loadShape("arch.obj");
        arch.scale(1);
        this.archId = id;
    }

    public void display(boolean isPlaceable) {
        parent.pushMatrix();
        
        parent.translate(location.x+120, -100, location.y);
        
        parent.rotateX((float) Math.PI);
        if(!isPlaceable) arch.setFill(parent.color(255,0,0));
        parent.shape(arch);
        parent.popMatrix();
    }

    public void display() {
        parent.pushMatrix();
        parent.translate(location.x+120, -99, location.y);
        parent.rotateX((float) Math.PI);
      //  parent.rotateY((float) Math.PI / 2);
        parent.shape(arch);
        parent.popMatrix();
    }


}