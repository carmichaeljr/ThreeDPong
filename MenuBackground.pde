class MenuBackground extends ThreeDObject {
	private final int matrixSize=10;
	private PImage glassTexture;
	private PImage tempBackground;
	
	public MenuBackground(){
		super();
		this.tempBackground=loadImage("tempBackground.jpg");
		this.tempBackground.resize(pixelWidth,pixelHeight);
		this.glassTexture=loadImage("glassTexture.jpg");
		this.glassTexture.resize(pixelWidth,pixelHeight);
		this.glassTexture.filter(GRAY);
	}
	
	public void setBackground(){
		loadPixels();
		this.glassTexture.loadPixels();
		this.tempBackground.loadPixels();
		for(int x=0; x<pixelWidth; x+=2){
			for(int y=0; y<pixelHeight; y++){
				int location=x+y*pixelWidth;
				color blurC=this.convolution(x,y);
				float b1=brightness(blurC);
				float b2=brightness(this.glassTexture.pixels[location]);
				this.tempBackground.pixels[location]=color(min(b1*1.4,b2));
				this.tempBackground.pixels[(x+1)+y*pixelWidth]=color(min(b1*1.4,b2));
			}
		}
		this.tempBackground.updatePixels();
	}
	
	private color convolution(int x, int y){
		float rTotal=0.0;
		float gTotal=0.0;
		float bTotal=0.0;
		float blurFactor=(float)1/(matrixSize*matrixSize);
		int offset=matrixSize/2;
		for(int i=0; i<matrixSize; i++){
			for(int j=0; j<matrixSize; j++){
				int xLocation=x+j-offset;
				int yLocation=y+j-offset;
				int location=xLocation+pixelWidth*yLocation;
				location=constrain(location,0,pixels.length-1);
				rTotal+=red(pixels[location])*blurFactor;//matrix[i][j];
				gTotal+=green(pixels[location])*blurFactor;//matrix[i][j];
				bTotal+=blue(pixels[location])*blurFactor;//matrix[i][j];
			}
		}
		rTotal=constrain(rTotal,0,255);
		gTotal=constrain(gTotal,0,255);
		bTotal=constrain(bTotal,0,255);
		return color(rTotal,gTotal,bTotal);
	}
	
	public void display(){
		super.performTranslation();
		image(this.tempBackground,0,0,width,height);
		super.resetTranslation();
		
	}
}

