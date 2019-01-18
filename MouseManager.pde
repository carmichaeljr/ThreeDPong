public interface MouseActionInterface {
	public void performMouseAction(String ... args);
}


abstract class MouseManager {
	private boolean mousePressed;
	private boolean mouseDragged;
	private boolean mouseReleased;
	private boolean running;
	
	public MouseManager(){
		this.mousePressed=false;
		this.mouseDragged=false;
		this.mouseReleased=false;
		this.running=false;
	}
	
	public boolean getMousePressed(){
		return this.mousePressed;
	}
	public void setMousePressed(boolean mousePressed){
		if (this.running){
			this.mousePressed=mousePressed;
		}
	}
	
	public boolean getMouseDragged(){
		return this.mouseDragged;
	}
	public void setMouseDragged(boolean mouseDragged){
		if (this.running){
			this.mouseDragged=mouseDragged;
		}
	}
	
	public boolean getMouseReleased(){
		return this.mouseReleased;
	}
	public void setMouseReleased(boolean mouseReleased){
		if (this.running){
			this.mouseReleased=mouseReleased;
		}
	}
	
	public void start(){
		this.running=true;
	}
	
	public void stop(){
		this.reset();
		this.running=false;
	}
	
	public void reset(){
		this.mousePressed=false;
		this.mouseDragged=false;
		this.mouseReleased=false;
	}
	
	public abstract void update();
}
