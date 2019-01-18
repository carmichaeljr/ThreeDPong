class MenuManager {
	private MenuComponentContainer componentContainer;
	private MenuComponentManager componentManager;
	private MenuComponentMouseManager componentMouseManager;
	private MenuComponentKeyboardManager componentKeyboardManager;
	private MenuComponentAudioManager componentAudioManager;
	
	private MenuManager(PApplet parrentSketch){
		this.componentContainer=new MenuComponentContainer();
		this.componentManager=new MenuComponentManager(this.componentContainer);
		this.componentMouseManager=new MenuComponentMouseManager(this.componentContainer);
		this.componentKeyboardManager=new MenuComponentKeyboardManager(this.componentContainer);
		this.componentAudioManager=new MenuComponentAudioManager(parrentSketch,this.componentContainer);
	}

	public void setGameMusicStatus(boolean status){
		this.componentAudioManager.setPlayBackgroundMusic(status);
		this.componentContainer.getGameMusicToggle().setToggleOn(status);
	}
	
	public void setGameSFXStatus(boolean status){
		this.componentContainer.getGameSFXToggle().setToggleOn(status);
	}
	
	public void setAllButtonActions(ButtonActionInterface buttonAction){
		this.componentContainer.getPlayButton().setButtonAction(buttonAction);
		this.componentContainer.getExitButton().setButtonAction(buttonAction);
		this.componentContainer.getGameMusicToggle().setButtonAction(buttonAction);
		this.componentContainer.getGameSFXToggle().setButtonAction(buttonAction);
	}
	
	public void setMenuBackground(){
		this.componentContainer.getMenuBackground().setBackground();
	}
	
	public void setMenuDisplayFontText(int[] currentGame, int[] record){
		this.componentContainer.getCurrentGameDisplayFont().setDisplayText(currentGame);
		this.componentContainer.getRecordDisplayFont().setDisplayText(record);
	}
	
	public boolean[] getGameSettings(){
		GameMusicToggle gameSFXToggle=this.componentContainer.getGameSFXToggle();
		GameMusicToggle gameMusicToggle=this.componentContainer.getGameMusicToggle();
		boolean[] settings=new boolean[]{gameSFXToggle.getToggleOn(),
										 gameMusicToggle.getToggleOn()};
		return settings;
	}
	
	public void start(){
		this.componentAudioManager.start();
		this.componentMouseManager.start();
		this.componentKeyboardManager.start();
	}
	
	public void updateAndDisplay(){
		this.updateIO();
		this.updateComponents();
		this.displayComponents();
		this.resetComponentsAndIO();
	}
	
	private void updateIO(){
		this.componentAudioManager.update();
		this.componentMouseManager.update();
		this.componentKeyboardManager.update();
	}
	
	private void updateComponents(){
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
	
	public void stop(){
		this.componentAudioManager.stop();
		this.componentMouseManager.stop();
		this.componentKeyboardManager.stop();
	}
}
