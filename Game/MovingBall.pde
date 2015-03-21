public class MovingBall {

    private Game parent;
    private PVector location;
    private PVector velocity;
    public final static float radius = 20;
    
    private PVector gravityForce = new PVector(0, 0, 0);
    private final float gravityConstant = 0.1f;
    
    private final float normalForce = 1;
    private final float mu = 0.01f;
    private final float frictionMagnitude = normalForce * mu;
    private PVector friction;



    public MovingBall(Game parent) {
        location = new PVector(0, -22.5f, 0);
        velocity = new PVector(0, 0, 0);
        this.parent = parent;
    }

    // unused at the moment
    public void reset() {
        location = new PVector(0, -22.5f, 0);
        velocity = new PVector(0, 0, 0);
    }

    public void update(float rotX, float rotZ) {
        gravityForce.x = PApplet.sin(rotZ) * gravityConstant;
        gravityForce.z = -PApplet.sin(rotX) * gravityConstant;

        
        friction = velocity.get();
        friction.mult(-1);
        friction.normalize();
        friction.mult(frictionMagnitude);

        velocity.add(gravityForce);
        velocity.add(friction);
        location.add(velocity);
    }

    public void display() {
        parent.pushMatrix();
        parent.translate(location.x, location.y, location.z);
        parent.fill(255, 0, 0);
        parent.sphere(radius);
        parent.popMatrix();
    }

    public void checkCylinderCollision() {
        for (Cylinder cy : parent.cylinders) {
            float deltaX = location.x - cy.location.x;
            float deltaY = location.z - cy.location.y;
            if (PApplet.sqrt((deltaX * deltaX) + (deltaY * deltaY)) <= Cylinder.radius + 20) {
                PVector n = new PVector(deltaX, deltaY);
                n.normalize();

                PVector v = new PVector(velocity.x, velocity.z);

                float te = 2 * v.dot(n);
                n.mult(te);
                v.sub(n);

                n = new PVector(deltaX, deltaY);
                n.normalize();
                n.mult(Cylinder.radius + 20);

                //make sure the ball never gets inside a cylinder
                location.x = cy.location.x + n.x;
                location.z = cy.location.y + n.y;

                velocity.x = v.x;
                velocity.z = v.y;
            }
        }
    }

    public void checkEdges(float boundX, float boundZ) {
        if (location.x > boundX) {
            velocity.x = -velocity.x;
            location.x = boundX;
        } else if (location.x < -boundX) {
            velocity.x = -velocity.x;
            location.x = -boundX;
        }

        if (location.z > boundZ) {
            velocity.z = -velocity.z;
            location.z = boundZ;
        } else if (location.z < -boundZ) {
            velocity.z = -velocity.z;
            location.z = -boundZ;
        }
    }
}