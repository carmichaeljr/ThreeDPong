public interface CollisionDetection {
	public boolean collided(ThreeDObject other);
	public boolean internalCollisionDetection(ThreeDObject other);
	public boolean externalCollisionDetection(ThreeDObject other);
}


abstract class MovingThreeDObject extends ThreeDObject{
	protected float movementX;
	protected float movementY;
	protected float movementZ;
	
	public MovingThreeDObject(){
		super();
		this.setMovement(0,0,0);
	}
	
	public MovingThreeDObject(float x, float y, float z){
		super();
		this.setMovement(x,y,z);
	}
	
	public float getMovementX(){
		return this.movementX;
	}
	public void setMovementX(float movementX){
		this.movementX=movementX;
	}
	
	public float getMovementY(){
		return this.movementY;
	}
	public void setMovementY(float movementY){
		this.movementY=movementY;
	}
	
	public float getMovementZ(){
		return this.movementZ;
	}
	public void setMovementZ(float movementZ){
		this.movementZ=movementZ;
	}
	
	public void setMovement(float[] movement){
		this.setMovementX(movement[0]);
		this.setMovementY(movement[1]);
		this.setMovementZ(movement[2]);
	}
	public void setMovement(float x, float y, float z){
		this.setMovementX(x);
		this.setMovementY(y);
		this.setMovementZ(z);
	}
	
	public abstract void update();
}
