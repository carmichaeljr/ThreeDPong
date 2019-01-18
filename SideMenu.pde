class SideMenu extends ThreeDObject {
	public SideMenu(){
		super();
	}
	
	@Override
	public void display(){
		super.performTranslation();
		fill(super.getForegroundColor());
		stroke(super.getStrokeColor());
		box(super.getWidth(),super.getHeight(),super.getDepth());
		super.resetTranslation();
	}
}