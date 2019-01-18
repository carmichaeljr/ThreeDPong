abstract class ThreeDObject{
	protected float x;
	protected float y;
	protected float z;
	protected float _width;
	protected float _height;
	protected float _depth;
	protected float XRotation;
	protected float YRotation;
	protected float ZRotation;
	protected color foreground;
	protected color background;
	protected color stroke;
	
	public ThreeDObject(){
		this.setPosition(0,0,0);
		this.setSize(0,0,0);
		this.setRotation(0,0,0);
		this.setColors(color(0,0,0),color(0,0,0),color(0,0,0));
	}
	
	public ThreeDObject(float x, float y, float z){
		this();
		this.setPosition(x,y,z);
	}
	
	public float getX(){
		return this.x;
	}
	public void setX(float x){
		this.x=x;
	}
	
	public float getY(){
		return this.y;
	}
	public void setY(float y){
		this.y=y;
	}
	
	public float getZ(){
		return this.z;
	}
	public void setZ(float z){
		this.z=z;
	}
	
	public float[] getPosition(){
		return new float[]{this.x,this.y,this.z};
	}
	public void setPosition(float[] pos){
		this.setX(pos[0]);
		this.setY(pos[1]);
		this.setZ(pos[2]);
	}
	public void setPosition(float x, float y, float z){
		this.setX(x);
		this.setY(y);
		this.setZ(z);
	}
	
	public float getWidth(){
		return this._width;
	}
	public void setWidth(float _width){
		this._width=_width;
	}
	
	public float getHeight(){
		return this._height;
	}
	public void setHeight(float _height){
		this._height=_height;
	}
	
	public float getDepth(){
		return this._depth;
	}
	public void setDepth(float _depth){
		this._depth=_depth;
	}
	
	public float[] getSize(){
		return new float[]{this._width,this._height,this._depth};
	}
	public void setSize(float[] size){
		this.setWidth(size[0]);
		this.setHeight(size[1]);
		this.setDepth(size[2]);
	}
	public void setSize(float _width, float _height, float _depth){
		this.setWidth(_width);
		this.setHeight(_height);
		this.setDepth(_depth);
	}
	
	public color getForegroundColor(){
		return this.foreground;
	}
	public void setForegroundColor(color foreground){
		this.foreground=foreground;
	}
	
	public color getBackgroundColor(){
		return this.background;
	}
	public void setBackgroundColor(color background){
		this.background=background;
	}
	
	public color getStrokeColor(){
		return this.stroke;
	}
	public void setStrokeColor(color stroke){
		this.stroke=stroke;
	}
	
	public void setColors(color foreground, color background, color stroke){
		this.foreground=foreground;
		this.background=background;
		this.stroke=stroke;
	}
	
	public float getXRotation(){
		return this.XRotation;
	}
	public void setXRotation(float xRotation){
		this.XRotation=xRotation;
	}
	
	public float getYRotation(){
		return this.YRotation;
	}
	public void setYRotation(float yRotation){
		this.YRotation=yRotation;
	}
	
	public float getZRotation(){
		return this.ZRotation;
	}
	public void setZRotation(float zRotation){
		this.ZRotation=zRotation;
	}
	
	public float[] getRotation(){
		return new float[]{this.XRotation,this.YRotation,this.ZRotation};
	}
	public void setRotation(float[] rotation){
		this.setXRotation(rotation[0]);
		this.setYRotation(rotation[1]);
		this.setZRotation(rotation[2]);
	}
	
	public void setRotation(float xRotation, float yRotation, float zRotation){
		this.setXRotation(xRotation);
		this.setYRotation(yRotation);
		this.setZRotation(zRotation);
	}
	
	protected void performTranslation(float x, float y, float z){
		pushMatrix();
		translate(x,y,z);
		rotateX(this.XRotation);
		rotateY(this.YRotation);
		rotateZ(this.ZRotation);
	}
	protected void performTranslation(){
		pushMatrix();
		translate(this.x,this.y,this.z);
		rotateX(this.XRotation);
		rotateY(this.YRotation);
		rotateZ(this.ZRotation);
	}
	
	protected void resetTranslation(){
		popMatrix();
	}
	
	public abstract void display();
}
