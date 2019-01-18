class Board extends ThreeDObject{
	private float boxHeight;
	private float boxWidth;
	private float centerCircleRadius;
	
	public Board(){
		super(width/2,height/2,-height/2);
		super.setSize(width,0,width);
		super.setXRotation((4*PI)/9);
		this.boxWidth=this._width/20;
		this.boxHeight=this._width/5;
		this.centerCircleRadius=this._width/3;
	}
	
	public Board(float x, float y, float z, float boardAngle){
		this();
		super.setPosition(x,y,z);
		super.setSize(width,0,width);
		super.setXRotation(boardAngle);
	}
	
	@Override
	public void setWidth(float _width){
		this._width=_width;
		this._depth=this._width;
		this.boxHeight=this._width/5;
		this.boxWidth=this._width/20;
		this.centerCircleRadius=this._width/3;
	}
	
	public float getBoxWidth(){
		return this.boxWidth;
	}
	
	public float getBoxHeight(){
		return this.boxHeight;
	}
	
	public float getCenterCircleRadius(){
		return this.centerCircleRadius;
	}
	
	public float getBoardAngle(){
		return super.XRotation;
	}
	public void setBoardAngle(float newAngle){
		if(newAngle<PI/2 && newAngle>PI/4){
			super.XRotation=newAngle;
		}
	}
	
	@Override
	public void display(){
		fill(super.getForegroundColor());
		stroke(super.getStrokeColor());
		this.drawBoard();
		this.drawWalls();
	}
	
	private void drawBoard(){
		super.performTranslation();
		rectMode(CENTER);
		rect(0,0,this._width,this._depth);
		line(-this._width/2,0,this._width/2,0);
		ellipse(0,0,this.centerCircleRadius,this.centerCircleRadius);
		super.resetTranslation();
	}
	
	private void drawWalls(){
		super.performTranslation(
			(this.x-this._width/2)-this.boxWidth/2,this.y,this.z);
		box(this.boxWidth,this._depth,this.boxHeight);
		super.resetTranslation();
		super.performTranslation(
			(this.x+this._width/2)+this.boxWidth/2,this.y,this.z);
		box(this.boxWidth,this._depth,this.boxHeight);
		super.resetTranslation();
	}
}