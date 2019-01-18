abstract class Sphere extends MovingThreeDObject implements CollisionDetection{
	public Sphere(){
		super.setSize(0,0,0);
	}
	public Sphere(float radius){
		super.setSize(radius,radius,radius);
	}
	
	public float getRadius(){
		return super._width;
	}
	public void setRadius(float radius){
		super.setSize(radius,radius,radius);
	}
	
	@Override
	public void setWidth(float width){
		super.setWidth(width);
		super.setHeight(width);
		super.setDepth(width);
	}
	@Override
	public void setHeight(float height){
		super.setWidth(height);
		super.setHeight(height);
		super.setDepth(height);
	}
	@Override
	public void setDepth(float depth){
		super.setWidth(depth);
		super.setHeight(depth);
		super.setDepth(depth);
	}
	
	public abstract void update();
	public abstract boolean collided(ThreeDObject other);
	public abstract boolean internalCollisionDetection(ThreeDObject other);
	public abstract boolean externalCollisionDetection(ThreeDObject other);
}