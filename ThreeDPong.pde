import processing.sound.*;

public GameManager gameManager;
public float GAME_UNIT;


void settings(){
	size(800,400,P3D);
	// size(displayWidth,displayHeight,P3D);
	pixelDensity(displayDensity());
	// orientation(LANDSCAPE);
}

void setup(){
	GAME_UNIT=width/800.0;
	println("Game Unit: "+GAME_UNIT);
	// println("Record Hits: "+highScoreFile.getNumOfHits());
	// println("Record Time: "+highScoreFile.getGameTime());
	gameManager=new GameManager(this);
}


void draw(){
	lights();
	perspective();
	background(20);
	
	gameManager.updateAndDisplay();
}
