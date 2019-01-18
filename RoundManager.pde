class RoundManager {
	private RoundComponentContainer componentContainer;
	private RoundComponentManager componentManager;
	private CollisionManager collisionManager;
	private DifficultyManager difficultyManager;
	private RoundComponentAudioManager componentAudioManager;
	private RoundComponentMouseManager componentMouseManager;
	private RoundComponentKeyboardManager componentKeyboardManager;
	private Timer gameTimer;
	private int gameSeconds;
	private boolean gameOver;
	private boolean gamePaused;
	
	public RoundManager(PApplet parrentSketch){
		this.componentContainer=new RoundComponentContainer();
		this.componentAudioManager=new RoundComponentAudioManager(parrentSketch,this.componentContainer);
		this.componentMouseManager=new RoundComponentMouseManager(this.componentContainer);
		this.componentKeyboardManager=new RoundComponentKeyboardManager(this.componentContainer);
		this.componentManager=new RoundComponentManager(this.componentContainer);
		this.collisionManager=new CollisionManager(this.componentContainer);
		this.difficultyManager=new DifficultyManager(this.componentContainer);
		this.gameTimer=new Timer(1);
		this.gameSeconds=0;
		this.gameOver=true;
		this.gamePaused=false;
	}
	
	public boolean getGameOver(){
		return this.gameOver;
	}
	
	public boolean getGamePaused(){
		return this.gamePaused;
	}
	public void setGamePaused(boolean paused){
		this.gamePaused=paused;
	}
	
	public int[] getGameStats(){
		int[] stats=new int[]{this.componentContainer.getHitCountFont().getHitCount(),
							  this.componentContainer.getTimerFont().getTotalTimeInSecs()};
		return stats;
	}
	
	public void setPauseButtonAction(ButtonActionInterface buttonAction){
		this.componentContainer.getPauseButton().setButtonAction(buttonAction);
	}
	
	public void setGameOverButtonAction(ButtonActionInterface buttonAction){
		this.componentContainer.getGameOverButton().setButtonAction(buttonAction);
	}
	
	public void setGameMusicStatus(boolean status){
		this.componentAudioManager.setPlayBackgroundMusic(status);
	}
	
	public void setGameSFXStatus(boolean status){
		this.componentAudioManager.setPlaySoundEffects(status);
	}
	
	public void start(){
		this.componentContainer.reset();
		this.resume();
	}
	
	public void updateAndDisplay(){
		this.updateIO();
		this.updateComponents();
		this.displayComponents();
		this.resetComponentsAndIO();
		this.updateRoundTimer();
		this.updateGameOver();
	}
	
	private void updateIO(){
		this.componentAudioManager.update();
		this.componentMouseManager.update();
		this.componentKeyboardManager.update();
	}
	
	private void updateComponents(){
		this.difficultyManager.update();
		this.collisionManager.run();
		this.componentManager.update();
	}
	
	public void displayComponents(){
		this.componentManager.display();
	}
	
	private void resetComponentsAndIO(){
		this.componentManager.reset();
		this.componentMouseManager.reset();
		this.componentKeyboardManager.reset();
	}
	
	private void updateRoundTimer(){
		if (this.gameTimer.checkTimer()){
			this.gameTimer.reset();
			this.gameTimer.start();
			this.gameSeconds+=1;
			this.componentContainer.getTimerFont().incrementTime(1);
			println(String.format("Game Time: %d",gameSeconds));
		}
	}
	
	private void updateGameOver(){
		Ball ball=this.componentContainer.getBall();
		if (ball.getZ()>=0){
			this.gameOver=true;
			this.componentContainer.getGameOverButton().performMouseAction();
		}
	}
	
	public void pause(){
		this.componentAudioManager.pause();
		this.stopNonPauseManagers();
	}
	
	public void resume(){
		this.componentAudioManager.start();
		this.componentMouseManager.start();
		this.componentKeyboardManager.start();
		this.difficultyManager.start();
		this.gameTimer.start();
		this.gamePaused=false;
		this.gameOver=false;
	
	}
	
	public void stop(){
		this.componentAudioManager.stop();
		this.stopNonPauseManagers();
	}
	
	private void stopNonPauseManagers(){
		this.componentMouseManager.stop();
		this.componentKeyboardManager.stop();
		this.difficultyManager.stop();
		this.gameTimer.reset();
		this.gamePaused=true;
	}
}
