abstract class FloatingButton extends Button {
	private float[] constraints;
	private float zRotationMovement;
	
	public FloatingButton(){
		super();
		this.zRotationMovement=0;
		this.constraints=new float[2];
	}
	
	public float getZRotationMovement(){
		return this.zRotationMovement;
	}
	public void setZRotationMovement(float zRotationMovement){
		this.zRotationMovement=zRotationMovement;
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
	
	protected void incrementZRotation(float incrementor){
		super.setZRotation(super.getZRotation()+incrementor);
		if (super.getZRotation()>TWO_PI){
			super.setZRotation(super.getZRotation()-TWO_PI);
		} else if (super.getZRotation()<-TWO_PI){
			super.setZRotation(super.getZRotation()+TWO_PI);
		}
	}
	
	@Override
	public void update(){
		float tempX=super.x+super.movementX;
		float tempY=super.y+super.movementY;
		float tempZ=super.z+super.movementZ;
		if (tempY<this.constraints[0] || tempY>this.constraints[1]){
			super.setMovementY(-super.getMovementY());
			tempY=constrain(tempY,this.constraints[0],this.constraints[1]);
		}
		super.setPosition(tempX,tempY,tempZ);
		this.incrementZRotation(this.zRotationMovement);
		if (super.pressed){
			this.performMouseAction();
		}
	}
	
	public abstract void display();
	protected abstract void displayContent();
	public abstract void performMouseAction(String ... args);
}


abstract class ButtonWithText extends Button {
	protected ButtonFont buttonFont;
	
	public ButtonWithText(){
		super();
		this.buttonFont=new ButtonFont(1);
	}
	
	@Override
	public void setPosition(float x, float y, float z){
		super.setPosition(x,y,z);
		if (this.buttonFont!=null){
			this.updateFont();
		}
	}
	@Override
	public void setPosition(float[] pos){
		super.setPosition(pos);
		if (this.buttonFont!=null){
			this.updateFont();
		}
	}
	
	@Override
	public void setSize(float _width, float _height, float _depth){
		super.setSize(_width,_height,_depth);
		if (this.buttonFont!=null){
			this.updateFont();
		}
	}
	@Override
	public void setSize(float[] size){
		super.setSize(size);
		if (this.buttonFont!=null){
			this.updateFont();
		}
	}
	
	@Override
	public void setContentColor(color c){
		super.setContentColor(c);
		if (this.buttonFont!=null){
			this.updateFont();
		}
	}

	protected abstract void updateFont();
	public abstract void display();
	public abstract void performMouseAction(String ... args);
}


abstract class ToggleButton extends ButtonWithText {
	protected ButtonFont toggleFont;
	protected boolean toggleOn;
	
	public ToggleButton(){
		this.toggleFont=new ButtonFont(1);
		this.toggleOn=true;
		this.updateToggleFont();
		this.setToggleFontText();
	}
	
	public boolean getToggleOn(){
		return this.toggleOn;
	}
	public void setToggleOn(boolean toggleOn){
		this.toggleOn=toggleOn;
		this.setToggleFontText();
	}
	
	@Override
	public void update(){
		if (super.pressed){
			this.toggleOn=!this.toggleOn;
			this.setToggleFontText();
			this.performMouseAction();
			delay(250);
		}
	}
	
	protected abstract void updateToggleFont();
	protected abstract void setToggleFontText();
	protected abstract void updateFont();
	public abstract void display();
	public abstract void performMouseAction(String ... args);
}


class DummyButton extends Button {
	private String actionString;
	
	public DummyButton(String actionString){
		super();
		this.actionString=actionString;
	}
	
	@Override
	public void display(){
		//
	}
	
	@Override
	public void performMouseAction(String ... args){
		super.buttonAction.performButtonAction(actionString);
	}
}


class ControlButton extends FloatingButton {
	private char arrowDirection;
	
	public ControlButton(char arrowDirection){
		super();
		this.arrowDirection=arrowDirection;
	}
	
	public char getArrowDirection(){
		return this.arrowDirection;
	}
	public void setArrowDirection(char arrowDirection){
		if (arrowDirection=='l' || arrowDirection=='r'){
			this.arrowDirection=arrowDirection;
		}
	}
	
	@Override
	public void display(){
		super.setFillAndStroke();
		super.performTranslation();
		strokeWeight(3);
		box(super._width,super._height,super._depth);
		strokeWeight(1);
		super.resetTranslation();
		this.displayContent();
	}
	
	@Override
	protected void displayContent(){
		pushMatrix();
		translate(super.x,super.y,super.z+super._depth/2);
		rotateY(super.YRotation);
		strokeWeight(3);
		stroke(super.contentColor);
		if (this.arrowDirection=='r'){
			line(super._width/8,0,0,-super._width/8,-super._width/4,0);
			line(super._width/8,-1,0,-super._width/8,super._width/4,0);
		} else if (this.arrowDirection=='l'){
			line(-super._width/8,0,0,super._width/8,-super._width/4,0);
			line(-super._width/8,-1,0,super._width/8,super._width/4,0);
		}
		strokeWeight(1);
		popMatrix();
	}
	
	@Override
	public void performMouseAction(String ... args){
		super.buttonAction.performButtonAction(String.valueOf(this.arrowDirection));
	}
}


class PauseButton extends FloatingButton implements KeyboardActionInterface {
	public PauseButton(){
		super();
	}
	
	@Override
	public void incrementZRotation(float incrementor){
		super.setZRotation(super.getZRotation()+incrementor);
		if (super.getZRotation()>TWO_PI || super.getZRotation()<-TWO_PI){
			super.setZRotationMovement(super.getZRotationMovement()*-1);
		}
	}
	
	@Override
	public void display(){
		super.setFillAndStroke();
		super.performTranslation();
		strokeWeight(3);
		box(super.getWidth(),super.getHeight(),super.getDepth());
		strokeWeight(1);
		super.resetTranslation();
		this.displayContent();
	}
	
	@Override
	protected void displayContent(){
		pushMatrix();
		translate(super.x,super.y,super.z+super._depth/2);
		rotateY(super.YRotation);
		fill(super.contentColor);
		stroke(super.contentColor);
		rectMode(CENTER);
		rect(-super.getWidth()/8,0,super.getWidth()/6,super.getHeight()/2,3);
		rect(super.getWidth()/8,0,super.getWidth()/6,super.getHeight()/2,3);
		popMatrix();
	}
	
	@Override
	public void performMouseAction(String ... args){
		super.buttonAction.performButtonAction("pause");
	}
	
	@Override
	public void performKeyboardAction(String ... args){
		super.buttonAction.performButtonAction("pause");
	}
}


class PlayButton extends ButtonWithText implements KeyboardActionInterface {
	public PlayButton(){
		super();
		super.buttonFont.setDisplayText("Play");
	}
	
	@Override
	protected void updateFont(){
		super.buttonFont.setFontSize(int(super.getHeight()*0.6));
		super.buttonFont.setPosition(super.getX(),
									 super.getY()+super.getHeight()/4,
									 super.getZ()+super.getDepth()/2);
		super.buttonFont.setForegroundColor(super.getContentColor());
	}

	@Override
	public void display(){
		super.setFillAndStroke();
		super.performTranslation();
		strokeWeight(3);
		box(super.getWidth(),super.getHeight(),super.getDepth());
		strokeWeight(1);
		super.resetTranslation();
		this.displayContent();
		super.buttonFont.display();
	}
	
	public void displayContent(){
		pushMatrix();
		translate(super.x-super.getWidth()/4,super.y,super.z+super._depth/2);
		fill(super.contentColor);
		stroke(super.contentColor);
		triangle(-super._width/6,-super._height/4,
				 -super._width/6,super._height/4,
				 super._width/8,0);
		popMatrix();
	}
	
	@Override
	public void performMouseAction(String ... args){
		super.buttonAction.performButtonAction("play");
	}
	
	@Override
	public void performKeyboardAction(String ... args){
		super.buttonAction.performButtonAction("play");
	}
}


class ExitButton extends ButtonWithText implements KeyboardActionInterface {
	public ExitButton(){
		super();
		super.buttonFont.setDisplayText("Exit");
	}
	
	@Override
	protected void updateFont(){
		super.buttonFont.setFontSize(int(super.getHeight()*0.6));
		super.buttonFont.setPosition(super.getX(),
									 super.getY()+super.getHeight()/4,
									 super.getZ()+super.getDepth()/2);
		super.buttonFont.setForegroundColor(super.getContentColor());
	}

	@Override
	public void display(){
		super.setFillAndStroke();
		super.performTranslation();
		strokeWeight(3);
		box(super.getWidth(),super.getHeight(),super.getDepth());
		strokeWeight(1);
		super.resetTranslation();
		this.displayContent();
		super.buttonFont.display();
	}
	
	public void displayContent(){
		float xDist=(super.getHeight()/4)*cos(PI/4);
		float yDist=(super.getHeight()/4)*sin(PI/4);
		pushMatrix();
		translate(super.x-super.getWidth()/4,super.y,super.z+super._depth/2);
		// fill(super.contentColor);
		strokeWeight(3);
		stroke(255,0,0,100);
		line(-xDist,-yDist,xDist,yDist);
		line(xDist,-yDist,-xDist,yDist);
		strokeWeight(1);
		popMatrix();
	}
	
	@Override
	public void performMouseAction(String ... args){
		super.buttonAction.performButtonAction("exit");
	}
	
	@Override
	public void performKeyboardAction(String ... args){
		super.buttonAction.performButtonAction("exit");
	}
}


class GameMusicToggle extends ToggleButton {
	private String actionString;
	
	public GameMusicToggle(String actionString, String buttonName){
		super();
		super.buttonFont.setDisplayText(buttonName);
		this.actionString=actionString;
	}
	
	public String getActionString(){
		return this.actionString;
	}
	public void setActionString(String actionString){
		this.actionString=actionString;
	}
	
	@Override
	protected void updateFont(){
		super.buttonFont.setFontSize(int(super.getHeight()*0.5));
		super.buttonFont.setPosition(super.getX()-(11*super.getWidth()/24),
									 super.getY()+super.getHeight()/4,
									 super.getZ()+super.getDepth()/2);
		super.buttonFont.setForegroundColor(super.getContentColor());
		this.updateToggleFont();
	}
	
	@Override
	protected void updateToggleFont(){
		if (super.toggleFont!=null){
			super.toggleFont.setFontSize(int(super.getHeight()*0.25));
			super.toggleFont.setPosition(super.getX()+super.getWidth()/8,
										 super.getY()+super.getHeight()/4,
										 super.getZ()+super.getDepth()/2);
			super.toggleFont.setForegroundColor(super.getContentColor());
		}
	}
	
	@Override
	protected void setToggleFontText(){
		super.toggleFont.setDisplayText((super.toggleOn)? "On": "Off");
	}

	@Override
	public void display(){
		super.setFillAndStroke();
		super.performTranslation();
		strokeWeight(3);
		box(super.getWidth(),super.getHeight(),super.getDepth());
		super.resetTranslation();
		this.displayContent();
		strokeWeight(1);
		super.buttonFont.display();
		this.toggleFont.display();
	}
	
	public void displayContent(){
		pushMatrix();
		translate(super.x+super.getWidth()/4,super.y-super.getHeight()/4,super.z+super._depth/2);
		rectMode(CENTER);
		strokeWeight(2);
		fill((super.toggleOn)? super.getContentColor(): super.getMainColor());
		stroke(super.getContentColor());
		rect(0,0,super.getWidth()/4,super.getHeight()/4,super.getWidth()/8);
		strokeWeight(1);
		fill((super.toggleOn)? super.getMainColor(): super.getContentColor());
		if (this.toggleOn){
			rect(super.getWidth()/16,0,super.getWidth()/8,super.getHeight()/4,super.getWidth()/8);
		} else {
			rect(-super.getWidth()/16,0,super.getWidth()/8,super.getHeight()/4,super.getWidth()/8);
		}
		popMatrix();
	}
	
	@Override
	public void performMouseAction(String ... args){
		super.buttonAction.performButtonAction(this.actionString,String.format("%b",this.toggleOn));
	}
}