class SongFile extends SoundFile {
	private boolean isPlaying;
	private int songPauseTime;
	private long startTime;
	private long pauseTime;
	private int pauseTimeCorrection;

	public SongFile(PApplet sketch, String songName){
		super(sketch,songName);
		this.isPlaying=false;
		this.startTime=-1;
		this.pauseTime=-1;
		this.songPauseTime=-1;
		this.pauseTimeCorrection=0;
	}
	
	public boolean getIsPlaying(){
		return this.isPlaying;
	}

	public void update(){
		if (this.isPlaying && this.getCurrentTime()>=super.duration()){
			// println("isPlaying: "+this.isPlaying);
			this.stop();
		}
	}

	public void pause(){
		this.songPauseTime=int((System.currentTimeMillis()-this.startTime)/1000)-this.pauseTimeCorrection;
		this.pauseTime=System.currentTimeMillis();
		super.stop();
		this.isPlaying=false;
		// println("Pause time: "+this.songPauseTime+" seconds");
	}

	@Override
	public void stop(){
		super.stop();
		this.startTime=-1;
		this.songPauseTime=-1;
		this.pauseTimeCorrection=0;
		this.isPlaying=false;
		super.cue(0);
	}

	@Override
	public void play(){
		if (this.songPauseTime>=0){
			this.pauseTimeCorrection+=int((System.currentTimeMillis()-this.pauseTime)/1000);
			// println("PauseTimeCorrection: "+this.pauseTimeCorrection);
			super.cue(this.songPauseTime);
		} else {
			this.songPauseTime=-1;
			this.startTime=System.currentTimeMillis();
		}
		super.play();
		this.isPlaying=true;
	}

	public float getProgress(){
		return this.getCurrentTime()/super.duration();
	}

	private int getCurrentTime(){
		if (this.startTime>=0 && this.isPlaying){
			return int((System.currentTimeMillis()-this.startTime)/1000)-this.pauseTimeCorrection;
		} else {
			return 0;
		}
	}
}