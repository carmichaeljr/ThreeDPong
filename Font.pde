abstract class Font extends ThreeDObject{
	PFont font;
	private String fontName;
	private int fontSize;
	private float fontScalar;
	private float textHeight;
	
	public Font(String fontName, int fontSize){
		super();
		this.fontName=fontName;
		this.fontSize=fontSize;
		this.fontScalar=1;
		this.initilizeFont();
	}
	
	public void setFontSize(int newSize){
		this.fontSize=newSize;
		this.initilizeFont();
	}
	
	public void setFontName(String newFont){
		this.fontName=newFont;
		this.initilizeFont();
	}
	
	public float getFontWidth(String text){
		return textWidth(text);
	}
	
	public float getFontScalar(){
		return this.fontScalar;
	}
	
	public void setFontScalar(float fontScalar){
		if(fontScalar>0){
			this.fontScalar=fontScalar;
		}
		this.calculateTextHeight();
	}
	
	private void initilizeFont(){
		this.font=loadFont(this.fontName);
		this.setFont();
		this.calculateTextHeight();
	}
	
	protected void setFont(){
		textFont(this.font);
		textSize(this.fontSize);
	}
	
	public void calculateTextHeight(){
		this.textHeight=(textAscent()+textDescent())*this.fontScalar;
		// println("Text height: "+this.textHeight);
	}
	
	public abstract void display();
}
