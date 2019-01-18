class GameManager implements ButtonActionInterface {
	private RoundManager gameRound;
	private MenuManager gameMenu;
	private HighScoreFile highScoreFile;
	private SettingsFile settingsFile;
	
	public GameManager(PApplet parrentSketch){
		this.highScoreFile=new HighScoreFile("data/scores.txt");
		this.settingsFile=new SettingsFile("data/settings.txt");
		this.setupGameRound(parrentSketch);
		this.setupGameMenu(parrentSketch);
		this.gameMenu.start();
	}
	
	private void setupGameMenu(PApplet parrentSketch){
		this.gameMenu=new MenuManager(parrentSketch);
		this.gameMenu.setAllButtonActions(this);
		this.gameMenu.setGameMusicStatus((this.settingsFile.getMusicOn())? true: false);
		this.gameMenu.setGameSFXStatus((this.settingsFile.getSFXOn())? true: false);
		this.setMenuDisplayText();
	}
	
	private void setupGameRound(PApplet parrentSketch){
		this.gameRound=new RoundManager(parrentSketch);
		this.gameRound.setPauseButtonAction(this);
		this.gameRound.setGameOverButtonAction(this);
		this.gameRound.setGameMusicStatus((this.settingsFile.getMusicOn())? true: false);
		this.gameRound.setGameSFXStatus((this.settingsFile.getSFXOn())? true: false);
	}
	
	public void updateAndDisplay(){
		if (!this.gameRound.getGameOver() && !this.gameRound.getGamePaused()){
			this.gameRound.updateAndDisplay();
		} else if (this.gameRound.getGamePaused()){
			this.gameMenu.updateAndDisplay();
		} else {
			this.gameMenu.updateAndDisplay();
		}
	}
	
	@Override
	public void performButtonAction(String ... args){
		if (args.length==1){
			this.performSingleActions(args[0]);
		} else if (args.length==2){
			this.performDecisionActions(args[0],args[1]);
		}
	}
	
	private void performSingleActions(String action){
		if (action.equals("pause")){
			this.gameRound.pause();
			this.startGameMenu();
		} else if (action.equals("gameover")){
			this.gameRound.stop();
			this.startGameMenu();
		}else if (action.equals("play")){
			if (!this.gameRound.getGameOver()){
				this.gameRound.resume();
			} else {
				this.gameRound.start();
			}
			this.gameMenu.stop();
		} else if(action.equals("exit")){
			exit();
		}
	}
	
	private void startGameMenu(){
		this.saveGameStats();
		this.gameMenu.start();
		this.setMenuBackground();
		this.setMenuDisplayText();
	}
	
	private void performDecisionActions(String action, String decision){
		if (action.equals("gamemusic")){
			this.gameRound.setGameMusicStatus((decision.equals("true"))? true: false);
			this.gameMenu.setGameMusicStatus((decision.equals("true"))? true: false);
			this.saveGameSettings();
		} else if (action.equals("gamesfx")){
			this.gameRound.setGameSFXStatus((decision.equals("true"))? true: false);
			this.saveGameSettings();
		}
	}
	
	private void saveGameStats(){
		int[] stats=this.gameRound.getGameStats();
		println("Current Game Stats: ");
		printArray(stats);
		if (stats[0]>this.highScoreFile.getNumOfHits()){
			println("  . Saving new highscore stats...");
			this.highScoreFile.setHitsAndTime(stats[0],stats[1]);
		}
	}
	
	private void saveGameSettings(){
		boolean[] settings=this.gameMenu.getGameSettings();
		this.settingsFile.setMusicAndSFXOn(settings);
	}
	
	//Have to place these two methods here because access to gameRound and its 
	//	components is required.
	private void setMenuBackground(){
		this.gameRound.displayComponents();
		this.gameMenu.setMenuBackground();
	}
	private void setMenuDisplayText(){
		int[] currentGame=this.gameRound.getGameStats();
		int[] recordGame=new int[]{this.highScoreFile.getNumOfHits(),
								   this.highScoreFile.getGameTime()};
		this.gameMenu.setMenuDisplayFontText(currentGame,recordGame);
	}
}
