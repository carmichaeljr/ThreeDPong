public interface KeyboardActionInterface {
	public void performKeyboardAction(String ... args);
}


abstract class KeyboardManager{
	private boolean keyPressed;
	private boolean keyReleased;
	private boolean running;
	
	public KeyboardManager(){
		this.keyPressed=false;
		this.keyReleased=false;
	}
	
	public boolean getKeyPressed(){
		return this.keyPressed;
	}
	public void setKeyPressed(boolean keyPressed){
		this.keyPressed=keyPressed;
	}
	
	public boolean getKeyReleased(){
		return this.keyReleased;
	}
	public void setKeyReleased(boolean keyReleased){
		this.keyReleased=keyReleased;
	}
	
	public void start(){
		this.running=true;
	}
	
	public void stop(){
		this.reset();
		this.running=false;
	}
	
	public void reset(){
		this.keyPressed=false;
		this.keyReleased=false;
	}
	
	public abstract void update();
}
