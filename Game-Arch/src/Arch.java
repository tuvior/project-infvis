import processing.core.*;

public class Arch {  
    PShape arch;
    public PVector location;
    Game parent;
    
    public final static float columnCenter = 36;
    public final static float columnBoard = 32;
    public final static float columnHeight = 5;
    public final static float columnRadius = 15;
    public final static float archWidth = 40;
    public final static float sizeForPrev = 15;

    public Arch(float posX, float posY, Game parent) {
        location = new PVector(posX , posY );
        this.parent = parent;
       // arch = parent.loadShape("simpleArch.obj");
        arch = parent.loadShape("arch_center.obj");
        arch.scale(5);
    }

    public void display(boolean isPlaceable) {
        parent.pushMatrix();
        parent.translate(location.x, 0, location.y);
        parent.rotateX((float) Math.PI);
        parent.rotateY((float) Math.PI / 2);
        if(!isPlaceable) arch.setFill(parent.color(255,0,0));
        parent.shape(arch);
        parent.popMatrix();
    }

    public void display() {
        parent.pushMatrix();
        parent.translate(location.x, 0, location.y);
        parent.rotateX((float) Math.PI);
        parent.rotateY((float) Math.PI / 2);
        parent.shape(arch);
        parent.popMatrix();
    }


}