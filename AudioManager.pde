public interface AudioActionInterface {
	public SongFile playAudio(HashMap<String,SongFile> allAudio);
}

abstract class AudioManager {
	protected HashMap<String,SongFile> allAudio;
	protected PApplet parrentSketch;
	private boolean running;
	
	public AudioManager(PApplet parrentSketch){
		this.allAudio=new HashMap<String,SongFile>();
		this.parrentSketch=parrentSketch;
	}
	
	public void addAudio(String filePath){
		SongFile tempAudioFile=new SongFile(parrentSketch,filePath);
		this.allAudio.put(filePath,tempAudioFile);
	}
	
	public void start(){
		this.running=true;
	}
	
	public void stop(){
		for(String audioName: this.allAudio.keySet()){
			SongFile tempAudio=this.allAudio.get(audioName);
			// println("Name: "+audioName+"  isPlaying():"+tempAudio.getIsPlaying());
			if (tempAudio.getIsPlaying()){
				tempAudio.stop();
			}
		}
		this.running=false;
	}
	
	public void pause(){
		for(String audioName: this.allAudio.keySet()){
			SongFile tempAudio=this.allAudio.get(audioName);
			// println("Name: "+audioName+"  isPlaying():"+tempAudio.getIsPlaying());
			if (tempAudio.getIsPlaying()){
				tempAudio.pause();
			}
		}
		this.running=false;
	}
	
	protected void updateAllSongs(){
		for(String audioName: this.allAudio.keySet()){
			this.allAudio.get(audioName).update();
		}
	}
	
	public abstract void update();
}