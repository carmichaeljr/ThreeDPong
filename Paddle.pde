abstract class Paddle extends MovingThreeDObject implements CollisionDetection{
	protected float constraints[];
	
	public Paddle(){
		super();
		this.constraints=new float[2];
		this.constraints[0]=0;
		this.constraints[1]=width;
	}
	
	public float[] getConstraints(){
		return this.constraints;
	}
	public void setConstraints(float[] constraints){
		this.constraints[0]=constraints[0];
		this.constraints[1]=constraints[1];
	}
	public void setConstraints(float min, float max){
		this.constraints[0]=min;
		this.constraints[1]=max;
	}
	
	public void display(){
		super.performTranslation();
		noStroke();
		fill(super.getForegroundColor());//0,0,100,
		box(super.getWidth(),super.getHeight(),super.getDepth());
		super.resetTranslation();
	}
	
	public abstract void update();
	public abstract boolean collided(ThreeDObject other);
	public abstract boolean internalCollisionDetection(ThreeDObject other);
	public abstract boolean externalCollisionDetection(ThreeDObject other);
}
