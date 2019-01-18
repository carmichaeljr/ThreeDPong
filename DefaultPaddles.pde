class CompPaddle extends Paddle {
	private ThreeDObject correspondingObject;
	
	public CompPaddle(ThreeDObject correspondingObject){
		super();
		this.setCorrespondingObject(correspondingObject);
	}
	
	public ThreeDObject getCorrespondingObject(){
		return this.correspondingObject;
	}
	public void setCorrespondingObject(ThreeDObject correspondingObject){
		this.correspondingObject=correspondingObject;
	}
	
	public void update(){
		if (this.correspondingObject.getX()-super._width/2>super.constraints[0] &&
			this.correspondingObject.getX()+super._width/2<super.constraints[1]){
			super.setX(this.correspondingObject.getX());
		}
	}
	
	public boolean collided(ThreeDObject other){
		return false;
	}
	public boolean internalCollisionDetection(ThreeDObject other){
		return false;
	}
	
	public boolean externalCollisionDetection(ThreeDObject other){
		if (other.getZ()-other.getDepth()/2<=super.z+super._depth/2){
			return true;
		} else {
			return false;
		}
	}
}


class UserPaddle extends Paddle implements ButtonActionInterface,KeyboardActionInterface{
	private FadeFeature fadeFeature;
	private float movementDelay;
	private float fadeLength;
	private boolean fadeBothWays;
	private float futurePosition;
	
	public UserPaddle(){
		super();
		this.fadeLength=1;
		this.fadeFeature=new FadeFeature();
		this.fadeFeature.setFadePeriod(PI);
		this.fadeFeature.setFadeAmplitude(255);
		this.movementDelay=0;
		this.futurePosition=0;
		this.setFadeBothWays(false);
	}
	public UserPaddle(float movementDelay, float fadeLength){
		this();
		this.fadeLength=fadeLength;
		this.fadeFeature.setFadePeriod(PI/this.fadeLength);
		this.setMovementDelay(movementDelay);
	}
	
	public float getMovementDelay(){
		return this.movementDelay;
	}
	public void setMovementDelay(float newDelay){
		if (newDelay>0 && newDelay<=32){
			this.movementDelay=newDelay;
		}
	}
	
	public float getFuturePosition(){
		return this.futurePosition;
	}
	public void setFuturePosition(float futurePosition){
		this.futurePosition=constrain(futurePosition,
									  super.constraints[0],super.constraints[1]);
	}
	
	public boolean getFadeBothWays(){
		return this.fadeBothWays;
	}
	public void setFadeBothWays(boolean fadeBothWays){
		this.fadeBothWays=fadeBothWays;
		if (this.fadeBothWays){
			this.fadeFeature.setFadePeriod(TWO_PI/this.fadeLength);
			this.fadeFeature.setFadeLatency(0);
		} else {
			this.fadeFeature.setFadePeriod(PI/this.fadeLength);
			this.fadeFeature.setFadeLatency(-128);
		}
	}
	
	@Override
	public void update(){
		float distance=(this.futurePosition-super.x)/this.movementDelay;
		float tempX=super.x+distance;
		if (tempX-super._width/2>super.constraints[0] &&
			tempX+super._width/2<super.constraints[1]){
			super.setX(super.getX()+distance);
		}
	}
	
	public void updateFade(float theta){
		this.fadeFeature.updateFade(theta);
	}
	
	@Override
	public void display(){
		super.performTranslation();
		noStroke();
		fill(super.getForegroundColor(),this.fadeFeature.getFadeValue());
		box(super.getWidth(),super.getHeight(),super.getDepth());
		stroke(super.getStrokeColor());
		noFill();
		box(super.getWidth(),super.getHeight(),super.getDepth());
		super.resetTranslation();
	}
	
	public boolean collided(ThreeDObject other){
		return false;
	}
	public boolean internalCollisionDetection(ThreeDObject other){
		return false;
	}
	
	public boolean externalCollisionDetection(ThreeDObject other){
		if ((other.getZ()+other.getDepth()/2>=super.z-super._depth/2 && 
			 other.getZ()+other.getDepth()/2<=super.z) &&//+super._depth/2 
			(other.getX()-other.getWidth()/2<super.x+super._width/2 &&
			 other.getX()+other.getWidth()/2>super.x-super._width/2)){
			return true;
		} else {
			return false;
		}
	}
	
	@Override
	public void performButtonAction(String ... args){
		if (args.length>0){
			this.incrementPosition(args[0].toLowerCase().charAt(0));
		}
	}
	@Override
	public void performKeyboardAction(String ... args){
		if (args.length>0){
			this.incrementPosition(args[0].toLowerCase().charAt(0));
		}
	}
	
	private void incrementPosition(char direction){
		float multiplier=map(this.movementDelay,1,32,16,32);
		// float multiplier=16;
		if (Character.toLowerCase(direction)=='l'){
			this.setFuturePosition(this.getX()-(multiplier*GAME_UNIT));
		} else if (Character.toLowerCase(direction)=='r'){
			this.setFuturePosition(this.getX()+(multiplier*GAME_UNIT));
		}
	}
}
