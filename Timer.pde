class Timer {
	protected float startTime;
	protected float stopTime;
	boolean timerStarted;
	
	public Timer(){
		this.startTime=0;
		this.stopTime=0;
		this.timerStarted=false;
	}
	
	public Timer(float stopTime){
		this.startTime=0;
		this.stopTime=stopTime;
		this.timerStarted=false;
	}
	
	public float getTime(){
		return this.stopTime;
	}
	
	public void setTime(float stopTime){
		this.stopTime=stopTime;
	}
	
	public boolean getTimerStarted(){
		return this.timerStarted;
	}
	
	
	public boolean checkTimer(){
		if (millis()-this.startTime>=this.stopTime*1000 && this.timerStarted){
			return true;
		} else {
			return false;
		}
	}
	
	public void start(){
		this.startTime=millis();
		this.timerStarted=true;
	}
	
	public void reset(){
		this.startTime=0;
		this.timerStarted=false;
	}
}
