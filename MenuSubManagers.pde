class MenuComponentManager implements ComponentManager {
	private MenuComponentContainer componentContainer;
	
	public MenuComponentManager(MenuComponentContainer componentContainer){
		this.componentContainer=componentContainer;
	}
	
	@Override
	public void update(){
		this.componentContainer.getPlayButton().update();
		this.componentContainer.getExitButton().update();
		this.componentContainer.getGameMusicToggle().update();
		this.componentContainer.getGameSFXToggle().update();
	}
	
	@Override
	public void display(){
		this.componentContainer.getMenuBackground().display();
		this.componentContainer.getSideMenu().display();
		this.componentContainer.getPlayButton().display();
		this.componentContainer.getExitButton().display();
		this.componentContainer.getGameMusicToggle().display();
		this.componentContainer.getGameSFXToggle().display();
		this.componentContainer.getRecordDisplayFont().display();
		this.componentContainer.getCurrentGameDisplayFont().display();
	}
	
	@Override
	public void reset(){
		this.componentContainer.getPlayButton().reset();
		this.componentContainer.getExitButton().reset();
		this.componentContainer.getGameMusicToggle().reset();
		this.componentContainer.getGameSFXToggle().reset();
	}
}


class MenuComponentMouseManager extends MouseManager {
	private MenuComponentContainer componentContainer;
	
	public MenuComponentMouseManager(MenuComponentContainer componentContainer){
		super();
		this.componentContainer=componentContainer;
	}
	
	@Override
	public void update(){
		if (super.running){
			this.checkForControlButtonUpdates();
			this.checkForAudioButtonUpdates();
		}
	}
	
	private void checkForControlButtonUpdates(){
		PlayButton playButton=this.componentContainer.getPlayButton();
		ExitButton exitButton=this.componentContainer.getExitButton();
		if (!mousePressed && playButton.mouseInsideObject(mouseX,mouseY)){
			playButton.setHovered(true);
		} else if (mousePressed && playButton.mouseInsideObject(mouseX,mouseY)){
			playButton.setPressed(true);
		}
		if (!mousePressed && exitButton.mouseInsideObject(mouseX,mouseY)){
			exitButton.setHovered(true);
		} else if (mousePressed && exitButton.mouseInsideObject(mouseX,mouseY)){
			exitButton.setPressed(true);
		}
	}
	
	private void checkForAudioButtonUpdates(){
		GameMusicToggle gameMusicToggle=this.componentContainer.getGameMusicToggle();
		GameMusicToggle gameSFXToggle=this.componentContainer.getGameSFXToggle();
		if (!mousePressed && gameMusicToggle.mouseInsideObject(mouseX,mouseY)){
			gameMusicToggle.setHovered(true);
		} else if (mousePressed && gameMusicToggle.mouseInsideObject(mouseX,mouseY)){
			gameMusicToggle.setPressed(true);
		}
		if (!mousePressed && gameSFXToggle.mouseInsideObject(mouseX,mouseY)){
			gameSFXToggle.setHovered(true);
		} else if (mousePressed && gameSFXToggle.mouseInsideObject(mouseX,mouseY)){
			gameSFXToggle.setPressed(true);
		}
	}
}


class MenuComponentKeyboardManager extends MouseManager {
	private MenuComponentContainer componentContainer;
	
	public MenuComponentKeyboardManager(MenuComponentContainer componentContainer){
		super();
		this.componentContainer=componentContainer;
	}
	
	@Override
	public void update(){
		if (super.running){
			ExitButton exitButton=this.componentContainer.getExitButton();
			PlayButton playButton=this.componentContainer.getPlayButton();
			if (key=='x' && keyPressed){
				exitButton.performKeyboardAction();
				exitButton.setHovered(true);
			} else if (key=='p' && keyPressed){
				delay(150);
				playButton.performKeyboardAction();
				playButton.setHovered(true);
			}
		}
	}
}


class MenuComponentAudioManager extends AudioManager {
	private MenuComponentContainer componentContainer;
	private boolean playBackgroundMusic;
	
	public MenuComponentAudioManager(PApplet parrentSketch, MenuComponentContainer componentContainer){
		super(parrentSketch);
		this.componentContainer=componentContainer;
		this.playBackgroundMusic=true;
		super.addAudio("menuBackground.mp3");
	}
	
	public boolean getPlayBackgroundMusic(){
		return this.playBackgroundMusic;
	}
	public void setPlayBackgroundMusic(boolean playBackgroundMusic){
		this.playBackgroundMusic=playBackgroundMusic;
		if (!playBackgroundMusic){
			super.allAudio.get("menuBackground.mp3").stop();
		}
	}
	
	@Override
	public void update(){
		super.updateAllSongs();
		this.updateBackgroundMusic();
	}
	
	private void updateBackgroundMusic(){
		SongFile tempBackgroundAudio=super.allAudio.get("menuBackground.mp3");
		if (this.playBackgroundMusic && !tempBackgroundAudio.getIsPlaying()){
			tempBackgroundAudio.amp(0.15);
			tempBackgroundAudio.play();
		}
	}
}
