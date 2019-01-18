public interface ButtonActionInterface {
	public void performButtonAction(String ... args);
}

abstract class Button extends MovingThreeDObject implements MouseActionInterface {
	protected color mainColor;
	protected color hoverColor;
	protected color contentColor;
	protected boolean hovered;
	protected boolean pressed;
	protected ButtonActionInterface buttonAction;
	
	public Button(){
		super();
		this.mainColor=color(0,0,0);
		this.hoverColor=color(0,0,0);
		this.contentColor=color(0,0,0);
		this.hovered=false;
		this.pressed=false;
		this.buttonAction=null;
	}
	
	public color getMainColor(){
		return this.mainColor;
	}
	public void setMainColor(color mainColor){
		this.mainColor=mainColor;
	}
	
	public color getHoverColor(){
		return this.hoverColor;
	}
	public void setHoverColor(color hoverColor){
		this.hoverColor=hoverColor;
	}
	
	public color getContentColor(){
		return this.contentColor;
	}
	public void setContentColor(color contentColor){
		this.contentColor=contentColor;
	}
	
	public ButtonActionInterface getButtonAction(){
		return this.buttonAction;
	}
	public void setButtonAction(ButtonActionInterface buttonAction){
		this.buttonAction=buttonAction;
	}
	
	public boolean getHovered(){
		return this.hovered;
	}
	public void setHovered(boolean hovered){
		this.hovered=hovered;
	}
	public void setHovered(float mousex, float mousey){
		this.hovered=this.mouseInsideObject(mousex,mousey);
	}
	
	public boolean getPressed(){
		return this.pressed;
	}
	public void setPressed(boolean pressed){
		this.pressed=pressed;
	}
	public void setPressed(float mousex, float mousey){
		this.pressed=this.mouseInsideObject(mousex,mousey);
	}
	
	public boolean mouseInsideObject(float mousex, float mousey){
		if (mousex>super.getX()-super.getWidth()/2 && 
			mousex<super.getX()+super.getWidth()/2 &&
			mousey>super.getY()-super.getHeight()/2 &&
			mousey<super.getY()+super.getHeight()/2){
			return true;
		}
		return false;
	}
	
	public void setFillAndStroke(){
		if (this.hovered || this.pressed){
			fill(this.hoverColor);
			stroke(this.mainColor);
		} else {
			fill(this.mainColor);
			stroke(this.hoverColor);
		}
	}
	
	public void update(){
		if (this.pressed){
			this.performMouseAction();
		}
	}
	
	public void reset(){
		this.hovered=false;
		this.pressed=false;
	}
	
	public abstract void display();
	public abstract void performMouseAction(String ... args);
}
