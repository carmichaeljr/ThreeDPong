class Ball extends Sphere implements AudioActionInterface {
	private boolean outOfBounds;
	private FadeFeature fadeFeature;
	private char collisionReversal;
	private float randomRange[];
	private float speed;
	
	public Ball(){
		super();
		this.outOfBounds=false;
		this.fadeFeature=new FadeFeature(510,false);
		this.fadeFeature.setFadeValue(255);
		this.fadeFeature.setFadePeriod(PI);
		this.fadeFeature.setFadeAmplitude(255);
		this.fadeFeature.setFadeOn(false);
		this.randomRange=new float[]{0.0,0.0};
		this.speed=0;
	}
	
	public Ball(float radius, float fadePeriod){
		this();
		this.fadeFeature.setFadePeriod(PI/fadePeriod);
		super.setSize(radius,radius,radius);
	}
	
	public boolean getOutOfBounds(){
		return this.outOfBounds;
	}
	
	public boolean getFadeOn(){
		return this.fadeFeature.getFadeOn();
	}
	public void setFadeOn(boolean fadeOn){
		this.fadeFeature.setFadeOn(fadeOn);
	}
	
	public float getFadeLatency(){
		return this.fadeFeature.getFadeLatency();
	}
	public void setFadeLatency(float fadeLatency){
		this.fadeFeature.setFadeLatency(constrain(fadeLatency,100,510));
	}
	
	public float[] getRandomRange(){
		return this.randomRange;
	}
	public void setRandomRange(float[] randomRange){
		if (abs(randomRange[0])<=5){
			this.randomRange[0]=randomRange[0];
		}
		if (abs(randomRange[1])<=5){
			this.randomRange[1]=randomRange[1];
		}
	}
	
	public float getSpeed(){
		return this.speed;
	}
	public void setSpeed(float speed){
		this.speed=constrain(speed,-10,10);
	}
	
	public void setCollisionInfo(char placement){
		if (placement=='f' || placement=='b' || placement=='l' || placement=='r'){
			this.outOfBounds=true;
			this.collisionReversal=placement;
		}
	}
	
	public void display(){
		super.performTranslation();
		fill(super.getForegroundColor(),this.fadeFeature.getFadeValue());
		noStroke();
		sphere(super._width);
		super.resetTranslation();
	}
	
	@Override
	public void update(){
		float tempX=super.x+super.movementX;
		float tempY=super.y+super.movementY;
		float tempZ=super.z+super.movementZ;
		super.setPosition(tempX,tempY,tempZ);
	}
	
	public void updateFade(float theta){
		if (this.fadeFeature.getFadeOn()){
			this.fadeFeature.updateFade(theta);
		} else {
			this.fadeFeature.setFadeValue(255);
		}
	}
	
	public boolean collided(ThreeDObject other){
		return false;
	}
	
	public boolean internalCollisionDetection(ThreeDObject other){
		if (other.getX()+other.getWidth()/2<super.getX()+super.getWidth()/2 &&
			other.getZ()-other.getDepth()/2<=super.getZ()-super.getDepth()/2 &&
			other.getZ()+other.getDepth()/2>=super.getZ()+super.getDepth()/2){
			this.collisionReversal='l';
			this.outOfBounds=true;
		} else if (other.getX()-other.getWidth()/2>super.getX()-super.getWidth()/2&&
				   other.getZ()-other.getDepth()/2<=super.getZ()-super.getDepth()/2 &&
				   other.getZ()+other.getDepth()/2>=super.getZ()+super.getDepth()/2){
			this.collisionReversal='r';
			this.outOfBounds=true;
		} else {
			this.outOfBounds=false;
		}
		return this.outOfBounds;
	}
	
	public boolean externalCollisionDetection(ThreeDObject other){
		return false;
	}
	
	public void runCollisionAction(){
		if( this.outOfBounds && 
		  (collisionReversal=='f' || collisionReversal=='b')){
			this.changeMovementZ();
		} else if (this.outOfBounds && 
				  (collisionReversal=='l' || collisionReversal=='r')){
			this.changeMovementX();
		}
		// this.collisionReversal=' ';
	}

	private void changeMovementX(){
		float sign=-Math.signum(super.getMovementX());
		float randomNum=random(this.randomRange[0],this.randomRange[1]);
		float newMovementX=sign*(this.speed+randomNum);
		super.setMovementX(newMovementX);
	}
	
	private void changeMovementZ(){
		float sign=-Math.signum(super.getMovementZ());
		float randomNum=random(this.randomRange[0],this.randomRange[1]);
		float newMovementZ=sign*(this.speed+randomNum);
		super.setMovementZ(newMovementZ);
	}
	
	@Override
	public SongFile playAudio(HashMap<String,SongFile> allAudio){
		float pan=map(super.getX(),0,width,-1,1);
		float amp=map(super.getZ(),-width,0,0.25,1);
		if (this.outOfBounds && (this.collisionReversal=='l' ||
			this.collisionReversal=='r')){
			allAudio.get("ping.mp3").pan(pan);
			allAudio.get("ping.mp3").amp(amp);
			return allAudio.get("ping.mp3");
		} else if (this.outOfBounds && (this.collisionReversal=='f' ||
			this.collisionReversal=='b')){
			allAudio.get("paddlePing.mp3").pan(pan);
			allAudio.get("paddlePing.mp3").amp(amp);
			return allAudio.get("paddlePing.mp3");
		} else {
			return null;
		}
	}
}
