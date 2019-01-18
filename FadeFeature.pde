class FadeFeature {
	private float fadeValue;
	private float fadeShift;
	private float fadePeriod;
	private float fadeLatency;
	private float fadeAmplitude;
	private boolean fadeOn;
	
	public FadeFeature(){
		this.fadeValue=0;
		this.fadeShift=0;
		this.fadePeriod=1;
		this.fadeOn=false;
		this.fadeLatency=0;
		this.fadeAmplitude=1;
	}
	
	public FadeFeature(float fadeLatency, boolean fadeOn){
		this();
		this.fadeLatency=fadeLatency;
		this.fadeOn=fadeOn;
	}
	
	public float getFadeValue(){
		return this.fadeValue;
	}
	public void setFadeValue(float fadeValue){
		this.fadeValue=fadeValue;
		this.fadeValue=constrain(this.fadeValue,0,255);
	}
	
	public float getFadeShift(){
		return this.fadeShift;
	}
	public void setFadeShift(float fadeShift){
		this.fadeShift=fadeShift;
	}
	
	public float getFadePeriod(){
		return this.fadePeriod;
	}
	public void setFadePeriod(float fadePeriod){
		this.fadePeriod=fadePeriod;
	}
	
	public float getFadeLatency(){
		return this.fadeLatency;
	}
	public void setFadeLatency(float fadeLatency){
		this.fadeLatency=constrain(fadeLatency,-this.fadeAmplitude*2,this.fadeAmplitude*2);
	}
	
	public float getFadeAmplitude(){
		return this.fadeAmplitude;
	}
	public void setFadeAmplitude(float fadeAmplitude){
		this.fadeAmplitude=fadeAmplitude;
	}
	
	public boolean getFadeOn(){
		return this.fadeOn;
	}
	public void setFadeOn(boolean fadeOn){
		this.fadeOn=fadeOn;
	}
	
	public void incrementFadeValue(float incrementor){
		this.fadeValue+=incrementor;
		this.fadeValue=constrain(this.fadeValue,0,255);
	}
	
	public void updateFade(float theta){
		this.setFadeValue((this.fadeAmplitude*cos((this.fadePeriod)*(theta+this.fadeShift)))+this.fadeLatency);
	}
}
