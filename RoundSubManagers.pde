class RoundComponentManager implements ComponentManager {
	private RoundComponentContainer componentContainer;
	
	public RoundComponentManager(RoundComponentContainer container){
		this.componentContainer=container;
	}
	
	@Override
	public void update(){
		this.componentContainer.getBall().update();
		this.componentContainer.getCompPaddle().update();
		this.componentContainer.getUserPaddle().update();
		this.updateComponentFades();
		this.componentContainer.getRightButton().update();
		this.componentContainer.getLeftButton().update();
		this.componentContainer.getPauseButton().update();
		this.componentContainer.getTimerFont().update();
		this.componentContainer.getHitCountFont().update();
	}

	private void updateComponentFades(){
		UserPaddle userPaddle=this.componentContainer.getUserPaddle();
		Ball ball=this.componentContainer.getBall();
		userPaddle.updateFade(ball.getZ());
		ball.updateFade(ball.getZ());
	}
	
	@Override
	public void display(){
		this.componentContainer.getTimerFont().display();
		this.componentContainer.getHitCountFont().display();
		this.componentContainer.getBoard().display();
		this.componentContainer.getCompPaddle().display();
		this.componentContainer.getBall().display();
		this.componentContainer.getUserPaddle().display();
		this.componentContainer.getRightButton().display();
		this.componentContainer.getLeftButton().display();
		this.componentContainer.getPauseButton().display();
	}
	
	@Override
	public void reset(){
		this.componentContainer.getRightButton().reset();
		this.componentContainer.getLeftButton().reset();
		this.componentContainer.getPauseButton().reset();
	}
}


class CollisionManager {
	private RoundComponentContainer componentContainer;
	
	public CollisionManager(RoundComponentContainer container){
		this.componentContainer=container;
	}
	
	public void run(){
		this.runBoardCollision();
		this.runPaddleCollision();
	}
	
	private void runPaddleCollision(){
		Ball ball=this.componentContainer.getBall();
		CompPaddle compPaddle=this.componentContainer.getCompPaddle();
		UserPaddle userPaddle=this.componentContainer.getUserPaddle();
		boolean userPaddleCollided=userPaddle.externalCollisionDetection(ball);
		boolean compPaddleCollided=compPaddle.externalCollisionDetection(ball);
		if (userPaddleCollided || compPaddleCollided){
			ball.setZ(constrain(ball.getZ(),
					  (compPaddle.getZ()+compPaddle.getDepth()/2)+ball.getRadius(),
					  (userPaddle.getZ()-userPaddle.getDepth()/2)-ball.getRadius()));
			ball.setCollisionInfo((compPaddleCollided)? 'b': 'f');
			ball.runCollisionAction();
			if (userPaddleCollided){
				this.componentContainer.getHitCountFont().incrementHitCount(1); //Misplaced responsibility??
			}
		}
	}
	
	private void runBoardCollision(){
		Board board=this.componentContainer.getBoard();
		Ball ball=this.componentContainer.getBall();
		if (ball.internalCollisionDetection(board)){
			ball.setX(constrain(ball.getX(),
								(board.getX()-board.getWidth()/2)+ball.getRadius(),
								(board.getX()+board.getWidth()/2)-ball.getRadius()));
			ball.runCollisionAction();
		}
	}
}


class DifficultyManager {
	private RoundComponentContainer componentContainer;
	private AutoRestartTimer ballSpeedTimer;
	private AutoRestartTimer paddleLatencyTimer;
	private AutoRestartTimer paddleFadeChangeTimer;
	private AutoRestartTimer ballFadeTimer;
	private AutoRestartTimer ballRandomBehaviorTimer;
	
	class AutoRestartTimer extends Timer {
		public AutoRestartTimer(float stopTime){
			super(stopTime);
		}
		
		@Override
		public boolean checkTimer(){
			if (millis()-this.startTime>=this.stopTime*1000 && this.timerStarted){
				super.reset();
				super.start();
				return true;
			} else {
				return false;
			}
		}
	}
	
	public DifficultyManager(RoundComponentContainer container){
		this.componentContainer=container;
		this.ballFadeTimer=new AutoRestartTimer(20);
		this.ballSpeedTimer=new AutoRestartTimer(10);
		this.ballRandomBehaviorTimer=new AutoRestartTimer(20);
		this.paddleLatencyTimer=new AutoRestartTimer(30);
		this.paddleFadeChangeTimer=new AutoRestartTimer(60);
	}
	
	public void start(){
		this.ballSpeedTimer.start();
		this.paddleLatencyTimer.start();
		this.paddleFadeChangeTimer.start();
		this.ballFadeTimer.start();
		this.ballRandomBehaviorTimer.start();
	}
	
	public void update(){
		if (this.ballSpeedTimer.checkTimer()){
			this.incrementBallSpeed();
		}
		if (this.paddleLatencyTimer.checkTimer()){
			this.incrementPaddleAccuracy();
		}
		if (this.paddleFadeChangeTimer.checkTimer()){
			this.changePaddleFade();
		}
		if (this.ballFadeTimer.checkTimer()){
			this.changeBallFade();
		}
		if (this.ballRandomBehaviorTimer.checkTimer()){
			this.incrementBallRandomBehavior();
		}
	}
	
	private void incrementBallSpeed(){
		Ball ball=this.componentContainer.getBall();
		ball.setSpeed(ball.getSpeed()+GAME_UNIT);//(2*GAME_UNIT)
		println("10 seconds passed: Increment ball speed");
		println(String.format(
			" . Movement X,Z: %f, %f",ball.getMovementX(),ball.getMovementZ()));
		println(String.format(" . Speed: %f",ball.getSpeed()));
	}
	
	private void incrementPaddleAccuracy(){
		UserPaddle paddle=this.componentContainer.getUserPaddle();
		paddle.setMovementDelay(paddle.getMovementDelay()*2);
		println("30 seconds passed: Increment paddle latency");
		println(String.format(" . Paddle Accuracy: %f",paddle.getMovementDelay()));
	}
	
	private void changePaddleFade(){
		this.componentContainer.getUserPaddle().setFadeBothWays(true);
		println("60 seconds passed: Change paddle Fade");
	}
	
	private void changeBallFade(){
		Ball ball=this.componentContainer.getBall();
		if (!ball.getFadeOn()){
			ball.setFadeOn(true);
			this.ballFadeTimer.setTime(5);
			println("20 seconds passed: Change ball fade");
		} else {
			ball.setFadeLatency(ball.getFadeLatency()-20);
			println("5 seconds passed: Increment ball fade latency");
			println(String.format(" . Fade latency: %f",ball.getFadeLatency()));
		}
	}
	
	private void incrementBallRandomBehavior(){
		Ball ball=this.componentContainer.getBall();
		float[] ballRandomRange=ball.getRandomRange();
		ballRandomRange[0]=Math.signum(ballRandomRange[0])*(abs(ballRandomRange[0])+GAME_UNIT);
		ballRandomRange[1]=Math.signum(ballRandomRange[1])*(abs(ballRandomRange[1])+GAME_UNIT);
		ball.setRandomRange(ballRandomRange);
		println("20 seconds passed: Increment ball random range");
		println(String.format(
			" . Random Range: %f, %f",ball.getRandomRange()[0],ball.getRandomRange()[1]));
	}
	
	public void stop(){
		this.ballSpeedTimer.reset();
		this.paddleLatencyTimer.reset();
		this.paddleFadeChangeTimer.reset();
		this.ballFadeTimer.reset();
		this.ballRandomBehaviorTimer.reset();
	}
}


class RoundComponentMouseManager extends MouseManager {
	private RoundComponentContainer componentContainer;
	
	public RoundComponentMouseManager(RoundComponentContainer componentContainer){
		super();
		this.componentContainer=componentContainer;
	}
	
	@Override
	public void update(){
		if (super.running){
			this.checkForControlButtonUpdates();
			this.checkForPaddleUpdate();
		}
	}
	
	private void checkForControlButtonUpdates(){
		ControlButton rightButton=this.componentContainer.getRightButton();
		ControlButton leftButton=this.componentContainer.getLeftButton();
		PauseButton pauseButton=this.componentContainer.getPauseButton();
		if (!mousePressed && rightButton.mouseInsideObject(mouseX,mouseY)){
			rightButton.setHovered(true);
		} else if (mousePressed && rightButton.mouseInsideObject(mouseX,mouseY)){
			rightButton.setPressed(true);
		}
		if (!mousePressed && leftButton.mouseInsideObject(mouseX,mouseY)){
			leftButton.setHovered(true);
		} else if (mousePressed && leftButton.mouseInsideObject(mouseX,mouseY)){
			leftButton.setPressed(true);
		}
		if (!mousePressed && pauseButton.mouseInsideObject(mouseX,mouseY)){
			pauseButton.setHovered(true);
		} else if (mousePressed && pauseButton.mouseInsideObject(mouseX,mouseY)){
			pauseButton.setPressed(true);
		}
	}

	private void checkForPaddleUpdate(){
		ControlButton rightButton=this.componentContainer.getRightButton();
		ControlButton leftButton=this.componentContainer.getLeftButton();
		PauseButton pauseButton=this.componentContainer.getPauseButton();
		if (pmouseX!=mouseX && 
			!rightButton.mouseInsideObject(mouseX,mouseY) &&
			!leftButton.mouseInsideObject(mouseX,mouseY) &&
			!pauseButton.mouseInsideObject(mouseX,mouseY)){
			componentContainer.getUserPaddle().setFuturePosition(mouseX);
		}
	}
}


class RoundComponentKeyboardManager extends KeyboardManager{
	private RoundComponentContainer componentContainer;
	
	public RoundComponentKeyboardManager(RoundComponentContainer componentContainer){
		super();
		this.componentContainer=componentContainer;
	}
	
	@Override
	public void update(){
		if (super.running){
			UserPaddle userPaddle=this.componentContainer.getUserPaddle();
			ControlButton rightButton=this.componentContainer.getRightButton();
			ControlButton leftButton=this.componentContainer.getLeftButton();
			PauseButton pauseButton=this.componentContainer.getPauseButton();
			if (keyCode==LEFT && keyPressed){
				userPaddle.performKeyboardAction("l");
				leftButton.setHovered(true);
			} else if (keyCode==RIGHT && keyPressed){
				userPaddle.performKeyboardAction("r");
				rightButton.setHovered(true);
			} else if (key=='p' && keyPressed){
				delay(150);
				pauseButton.performKeyboardAction();
				pauseButton.setHovered(true);
			}
		}
	}
}


class RoundComponentAudioManager extends AudioManager {
	private RoundComponentContainer componentContainer;
	private boolean playBackgroundMusic;
	private boolean playSoundEffects;
	
	public RoundComponentAudioManager(PApplet parrentSketch, RoundComponentContainer componentContainer){
		super(parrentSketch);
		this.componentContainer=componentContainer;
		this.playBackgroundMusic=true;
		this.playSoundEffects=true;
		super.addAudio("ping.mp3");
		super.addAudio("paddlePing.mp3");
		super.addAudio("gameBackground.mp3");
	}
	
	public boolean getPlayBackgroundMusic(){
		return this.playBackgroundMusic;
	}
	public void setPlayBackgroundMusic(boolean playBackgroundMusic){
		this.playBackgroundMusic=playBackgroundMusic;
		if (!playBackgroundMusic){
			super.allAudio.get("gameBackground.mp3").stop();
		}
	}
	
	public boolean getPlaySoundEffects(){
		return this.playSoundEffects;
	}
	public void setPlaySoundEffects(boolean playSoundEffects){
		this.playSoundEffects=playSoundEffects;
	}
	
	@Override
	public void update(){
		super.updateAllSongs();
		this.updateBackgroundMusic();
		this.updateSoundEffects();
	}
	
	private void updateBackgroundMusic(){
		SongFile tempBackgroundAudio=super.allAudio.get("gameBackground.mp3");
		if (this.playBackgroundMusic && !tempBackgroundAudio.getIsPlaying()){
			tempBackgroundAudio.amp(0.15);
			tempBackgroundAudio.play();
		}
	}
	
	private void updateSoundEffects(){
		if (this.playSoundEffects){
			Ball tempBall=this.componentContainer.getBall();
			SoundFile audio=tempBall.playAudio(super.allAudio);
			if (audio!=null){
				audio.play();
			}
		}
	}
}
