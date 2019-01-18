public interface ComponentManager {
	public void update();
	public void display();
	public void reset();
}


class RoundComponentContainer {
	private float[] center;
	private Ball ball;
	private Board board;
	private UserPaddle userPaddle;
	private CompPaddle compPaddle;
	private ControlButton rightButton;
	private ControlButton leftButton;
	private PauseButton pauseButton;
	private DummyButton gameOverButton;
	private TimerFont timerFont;
	private HitCountFont hitCountFont;
	
	public RoundComponentContainer(){
		this.center=new float[]{width/2.0,height/2.0,-width/2.0};
		this.reset();
		this.setupPauseButton();
		this.setupGameOverButton();
	}
	
	public void reset(){
		this.setupBoard();
		this.setupBall();
		this.setupCompPaddle();
		this.setupUserPaddle();
		this.setupRightButton();
		this.setupLeftButton();
		this.setupTimerFont();
		this.setupHitCountFont();
	}
	
	private void setupBoard(){
		this.board=new Board(center[0],center[1],center[2],85*(PI/180));
		this.board.setWidth(width);
		this.board.setForegroundColor(color(150));
		this.board.setStrokeColor(color(200));
	}

	private void setupBall(){
		this.ball=new Ball(board.getWidth()/20,board.getWidth());
		this.ball.setPosition(center[0],center[1]-(ball.getRadius()*1.5),center[2]);
		this.ball.setXRotation(85*(PI/180));
		this.ball.setMovement(random(5*GAME_UNIT,7*GAME_UNIT),0,random(-7*GAME_UNIT,-5*GAME_UNIT));
		this.ball.setSpeed(5*GAME_UNIT);
		this.ball.setRandomRange(new float[]{-GAME_UNIT,GAME_UNIT});
		this.ball.setForegroundColor(color(255,242,2));
	}

	private void setupCompPaddle(){
		this.compPaddle=new CompPaddle(ball);
		this.compPaddle.setSize(board.getWidth()/4,10,ball.getHeight()*3);
		this.compPaddle.setPosition(center[0],center[1]-ball.getHeight(),center[2]-board.getDepth()/2);
		this.compPaddle.setConstraints(center[0]-board.getWidth()/2,center[0]+board.getWidth()/2);
		this.compPaddle.setXRotation(85*(PI/180));
		this.compPaddle.setForegroundColor(color(141,183,252,100));
	}

	private void setupUserPaddle(){
		this.userPaddle=new UserPaddle(1,this.board.getWidth());
		this.userPaddle.setSize(board.getWidth()/4,10,ball.getHeight()*3);
		this.userPaddle.setPosition(center[0],center[1]-ball.getHeight(),center[2]+board.getDepth()/2);
		this.userPaddle.setConstraints(center[0]-board.getWidth()/2,center[0]+board.getWidth()/2);
		this.userPaddle.setXRotation(85*(PI/180));
		this.userPaddle.setForegroundColor(color(255,68,68));
		this.userPaddle.setStrokeColor(color(255,68,68));
	}
	
	private void setupLeftButton(){
		this.leftButton=new ControlButton('l');
		this.leftButton.setSize((height-board.getY())/2,(height-board.getY())/2,5);//20
		this.leftButton.setPosition(board.getX()-board.getWidth()/2+this.leftButton.getWidth(),
									board.getY()+board.getBoxHeight()/2,0);//50
		// this.leftButton.setYRotation(PI/6);
		this.leftButton.setZRotationMovement(-PI/96);
		this.leftButton.setMovement(0,0.1,0);
		this.leftButton.setConstraints(this.leftButton.getY()-25,this.leftButton.getY()+15);
		this.leftButton.setMainColor(color(255,0));
		this.leftButton.setHoverColor(color(141,183,252,100));
		this.leftButton.setContentColor(color(57,92,150));
		this.leftButton.setButtonAction(this.userPaddle);
	}
	
	private void setupRightButton(){
		this.rightButton=new ControlButton('r');
		this.rightButton.setSize((height-board.getY())/2,(height-board.getY())/2,5);//20
		this.rightButton.setPosition(board.getX()+board.getWidth()/2-this.rightButton.getWidth(),
									 board.getY()+board.getBoxHeight()/2,0);//50
		// this.rightButton.setYRotation(-PI/6);
		this.rightButton.setZRotationMovement(PI/96);
		this.rightButton.setMovement(0,0.1,0);
		this.rightButton.setConstraints(this.rightButton.getY()-20,this.rightButton.getY()+15);
		this.rightButton.setMainColor(color(255,0));
		this.rightButton.setHoverColor(color(141,183,252,100));
		this.rightButton.setContentColor(color(57,92,150));
		this.rightButton.setButtonAction(this.userPaddle);
	}
	
	private void setupPauseButton(){
		this.pauseButton=new PauseButton();
		this.pauseButton.setSize(this.board.getBoxHeight()/3,this.board.getBoxHeight()/3,5);
		this.pauseButton.setPosition(width-this.board.getBoxHeight()/4,this.board.getBoxHeight()/4,0);
		this.pauseButton.setZRotationMovement(PI/96);
		this.pauseButton.setMovement(0,0.1,0);
		this.pauseButton.setConstraints(this.pauseButton.getY()-10,this.pauseButton.getY()+10);
		this.pauseButton.setMainColor(color(255,0));
		this.pauseButton.setHoverColor(color(141,183,252,100));
		this.pauseButton.setContentColor(color(57,92,150));
	}
	
	private void setupGameOverButton(){
		this.gameOverButton=new DummyButton("gameover");
	}
	
	private void setupTimerFont(){
		this.timerFont=new TimerFont(int(this.board.getBoxHeight()/2));
		float textLength=this.timerFont.getTextWidth();
		this.timerFont.setPosition(this.board.getX()+this.board.getWidth()/2,
								   this.board.getY()-this.board.getBoxHeight()/2,-textLength-5);
		this.timerFont.setRotation(0,-HALF_PI,0);
		this.timerFont.setAnimationDirection(-1);
		this.timerFont.setForegroundColor(color(255));
		this.timerFont.setBackgroundColor(color(20));
	}
	
	private void setupHitCountFont(){
		this.hitCountFont=new HitCountFont(int(this.board.getBoxHeight()));
		this.hitCountFont.setPosition(this.board.getX()-this.board.getWidth()/2,
									  this.board.getY()-this.board.getBoxHeight()/2,0);
		this.hitCountFont.setRotation(0,HALF_PI,0);
		this.hitCountFont.setAnimationDirection(-1);
		this.hitCountFont.setForegroundColor(color(255));
		this.hitCountFont.setBackgroundColor(color(20));
	}
	
	public Board getBoard(){
		return this.board;
	}
	
	public Ball getBall(){
		return this.ball;
	}
	
	public CompPaddle getCompPaddle(){
		return this.compPaddle;
	}
	
	public UserPaddle getUserPaddle(){
		return this.userPaddle;
	}
	
	public ControlButton getRightButton(){
		return this.rightButton;
	}
	
	public ControlButton getLeftButton(){
		return this.leftButton;
	}
	
	public PauseButton getPauseButton(){
		return this.pauseButton;
	}
	
	public DummyButton getGameOverButton(){
		return this.gameOverButton;
	}
	
	public TimerFont getTimerFont(){
		return this.timerFont;
	}
	
	public HitCountFont getHitCountFont(){
		return this.hitCountFont;
	}
}


class MenuComponentContainer {
	private SideMenu sideMenu;
	private PlayButton playButton;
	private ExitButton exitButton;
	private MenuBackground menuBackground;
	private GameMusicToggle gameMusicToggle;
	private GameMusicToggle gameSFXToggle;
	private MenuDisplayFont recordDisplayFont;
	private MenuDisplayFont currentGameDisplayFont;
	
	public MenuComponentContainer(){
		this.setupMenuBackground();
		this.setupSideMenu();
		this.setupPlayButton();
		this.setupExitButton();
		this.setupGameMusicToggle();
		this.setupGameSFXToggle();
		this.setupRecordDisplayFont();
		this.setupCurrentGameDisplayFont();
	}
	
	private void setupMenuBackground(){
		this.menuBackground=new MenuBackground();
	}
	
	private void setupSideMenu(){
		this.sideMenu=new SideMenu();
		this.sideMenu.setSize(width/5,height,5);
		this.sideMenu.setPosition(width/10,height/2,0);
		this.sideMenu.setForegroundColor(color(255,50));//color(141,183,252,150)
		this.sideMenu.setStrokeColor(color(141,183,252,150));
	}
	
	private void setupPlayButton(){
		this.playButton=new PlayButton();
		this.playButton.setSize(width/5,height/5,5);
		this.playButton.setPosition(width/10,height/10,0);
		this.playButton.setMainColor(color(141,183,252,200));
		this.playButton.setHoverColor(color(255,0));
		this.playButton.setContentColor(color(57,92,150));
	}

	private void setupExitButton(){
		this.exitButton=new ExitButton();
		this.exitButton.setSize(width/5,height/5,5);
		this.exitButton.setPosition(width/10,3*height/10,0);
		this.exitButton.setMainColor(color(141,183,252,200));
		this.exitButton.setHoverColor(color(255,0));
		this.exitButton.setContentColor(color(57,92,150));
	}
	
	private void setupGameMusicToggle(){
		this.gameMusicToggle=new GameMusicToggle("gamemusic","Music");
		this.gameMusicToggle.setSize(width/5,height/5,5);
		this.gameMusicToggle.setPosition(width/10,7*height/10,0);
		this.gameMusicToggle.setMainColor(color(141,183,252,200));
		this.gameMusicToggle.setHoverColor(color(255,100));
		this.gameMusicToggle.setContentColor(color(57,92,150));
	}
	
	private void setupGameSFXToggle(){
		this.gameSFXToggle=new GameMusicToggle("gamesfx","SFX");
		this.gameSFXToggle.setSize(width/5,height/5,5);
		this.gameSFXToggle.setPosition(width/10,9*height/10,0);
		this.gameSFXToggle.setMainColor(color(141,183,252,200));
		this.gameSFXToggle.setHoverColor(color(255,100));
		this.gameSFXToggle.setContentColor(color(57,92,150));
	}
	
	private void setupRecordDisplayFont(){
		this.recordDisplayFont=new MenuDisplayFont(height/8);
		this.recordDisplayFont.setPosition(this.sideMenu.getWidth()*1.2,3*height/5,0);
		this.recordDisplayFont.setForegroundColor(color(183,209,255));
		this.recordDisplayFont.setDisplayTextFormat("Record:\n%04d hits at %02d:%02d sec");
		this.recordDisplayFont.setDisplayText(new int[]{0,0});
	}
	
	private void setupCurrentGameDisplayFont(){
		this.currentGameDisplayFont=new MenuDisplayFont(height/8);
		this.currentGameDisplayFont.setPosition(this.sideMenu.getWidth()*1.2,1*height/5,0);
		this.currentGameDisplayFont.setForegroundColor(color(183,209,255));
		this.currentGameDisplayFont.setDisplayTextFormat("Current Game:\n%04d hits at %02d:%02d sec");
		this.currentGameDisplayFont.setDisplayText(new int[]{0,0});
	}
	
	public MenuBackground getMenuBackground(){
		return this.menuBackground;
	}
	
	public SideMenu getSideMenu(){
		return this.sideMenu;
	}
	
	public PlayButton getPlayButton(){
		return this.playButton;
	}
	
	public ExitButton getExitButton(){
		return this.exitButton;
	}
	
	public GameMusicToggle getGameMusicToggle(){
		return this.gameMusicToggle;
	}
	
	public GameMusicToggle getGameSFXToggle(){
		return this.gameSFXToggle;
	}
	
	public MenuDisplayFont getRecordDisplayFont(){
		return this.recordDisplayFont;
	}
	
	public MenuDisplayFont getCurrentGameDisplayFont(){
		return this.currentGameDisplayFont;
	}
}

