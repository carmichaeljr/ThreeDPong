abstract class TickerFont extends Font {
	protected static final String fontName="AgencyFB-Bold-150.vlw";
	protected FadeFeature fadeFeature;
	protected float bottomHalfThetaIncrement;
	protected float bottomHalfTheta;
	protected int animationDirection;
	
	public TickerFont(int fontSize){
		super(fontName,fontSize);
		super.setFontScalar(0.8);
		this.fadeFeature=new FadeFeature(0,true);
		this.fadeFeature.setFadeAmplitude(200);
		this.fadeFeature.setFadeShift(HALF_PI);
		this.setAnimationDirection(1);
		this.bottomHalfThetaIncrement=0.1;
		this.bottomHalfTheta=0;
	}
	
	public int getAnimationDirection(){
		return this.animationDirection;
	}
	
	public void setAnimationDirection(int newDir){
		this.animationDirection=int(Math.signum(newDir));
		if (this.animationDirection==0){
			this.animationDirection=1;
		}
	}
	
	public void update(){
		if (this.thetaPastThreashold()){
			this.bottomHalfTheta+=this.bottomHalfThetaIncrement*this.animationDirection;
			this.fadeFeature.updateFade(this.bottomHalfTheta);
		}
	}
	
	public void resetAnimation(){
		this.bottomHalfTheta=0;
		this.bottomHalfThetaIncrement=0.1;
	}
	
	private boolean thetaPastThreashold(){
		//Sub 0.1 to make sure black boxes dont coverup the time and produce a flicker
		return (abs(this.bottomHalfTheta)<PI-0.1)? true: false;
	}
	
	@Override
	public void display(){
		super.setFont();
		if (this.thetaPastThreashold()){
			this.displayTopHalf();
			this.displayBottomHalf();
		} else {
			this.displayAll();
		}
	}

	private void displayTopHalf(){
		super.performTranslation();
		fill(super.getForegroundColor());
		text(this.getDisplayText(),0,0);
		translate(super.getFontWidth(this.getDisplayText())/2,-super.textHeight/4,0);
		fill(super.getBackgroundColor());
		noStroke();
		// stroke(255,0,0);
		box(super.getFontWidth(this.getDisplayText()),-super.textHeight/2-5,3);
		super.resetTranslation();
	}
	
	private void displayBottomHalf(){
		super.performTranslation();
		translate(0,-super.textHeight,0);
		rotateX(PI);
		translate(0,-super.textHeight/2,0);	//Negative again because x axis got flipped
		rotateX(this.bottomHalfTheta);
		fill(super.getForegroundColor(),this.fadeFeature.getFadeValue());
		text(this.getDisplayText(),0,super.textHeight/2);
		translate(super.getFontWidth(this.getDisplayText())/2,-super.textHeight/4,0);
		fill(super.getBackgroundColor());
		noStroke();
		// stroke(255,0,0);
		box(super.getFontWidth(this.getDisplayText()),-super.textHeight/2-5,3);
		super.resetTranslation();
	}
	
	private void displayAll(){
		super.performTranslation();
		fill(super.getForegroundColor());
		text(this.getDisplayText(),0,0);
		translate(super.getFontWidth(this.getDisplayText())/2,-super.textHeight/2,0);
		fill(super.getBackgroundColor());
		noStroke();
		box(super.getFontWidth(this.getDisplayText()),super.textHeight/20,3);
		super.resetTranslation();
	}
	
	public abstract String getDisplayText();
}


class TimerFont extends TickerFont {
	private int totalTimeInSecs;
	private int minutes;
	private int seconds;
	
	public TimerFont(int fontSize){
		super(fontSize);
		super.setFontSize(75);
	}
	
	private void setMinSec(){
		this.minutes=this.totalTimeInSecs/60;
		this.seconds=this.totalTimeInSecs%60;
	}
	
	public int getTotalTimeInSecs(){
		return this.totalTimeInSecs;
	}
	
	@Override
	public String getDisplayText(){
		this.setMinSec();
		return String.format("%02d:%02d",this.minutes,this.seconds);
	}
	
	public float getTextWidth(){
		return super.getFontWidth(String.format("%s sec",this.getDisplayText()));
	}
	
	public void incrementTime(int val){
		this.totalTimeInSecs+=val;
		super.resetAnimation();
	}
	
	@Override
	public void display(){
		super.display();
		super.performTranslation();
		float textWidth=super.getFontWidth(this.getDisplayText());
		fill(super.getForegroundColor());
		text("sec",textWidth+5,0);
		super.resetTranslation();
	}
}


class HitCountFont extends TickerFont {
	private int hitCount;
	
	public HitCountFont(int fontSize){
		super(fontSize);
		this.hitCount=0;
	}
	
	public int getHitCount(){
		return this.hitCount;
	}
	
	public void incrementHitCount(int ammount){
		this.hitCount+=ammount;
		super.resetAnimation();
	}
	
	@Override
	public String getDisplayText(){
		return String.format("%04d",this.hitCount);
	}
}


class ButtonFont extends Font {
	private static final String fontName="AgencyFB-Bold-150.vlw";
	private String buttonText;
	
	public ButtonFont(int fontSize){
		super(ButtonFont.fontName,fontSize);
		this.buttonText=new String();
	}
	
	public String getDisplayText(){
		return this.buttonText;
	}
	public void setDisplayText(String displayText){
		this.buttonText=displayText;
	}
	
	@Override
	public void display(){
		super.setFont();
		super.performTranslation();
		fill(super.getForegroundColor());
		text(this.buttonText,0,0);
		super.resetTranslation();
	}
}


class MenuDisplayFont extends Font {
	private static final String fontName="AgencyFB-Bold-150.vlw";
	private String displayTextFormat;
	private String displayText;
	
	public MenuDisplayFont(int fontSize){
		super(MenuDisplayFont.fontName,fontSize);
		this.displayTextFormat=new String();
		this.displayText=new String();
	}
	
	public String getDisplayText(){
		return this.displayText;
	}
	public void setDisplayText(int[] data){
		int minutes=data[1]/60;
		int seconds=data[1]%60;
		this.displayText=String.format(this.displayTextFormat,data[0],minutes,seconds);
	}
	
	public String getDisplayTextFormat(){
		return this.displayTextFormat;
	}
	public void setDisplayTextFormat(String newFormat){
		this.displayTextFormat=newFormat;
	}
	
	@Override
	public void display(){
		super.setFont();
		super.performTranslation();
		fill(super.getForegroundColor());
		text(this.displayText,0,0);
		super.resetTranslation();
	}
}
