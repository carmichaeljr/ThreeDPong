class HighScoreFile extends DataFile {
	public HighScoreFile(String fileName){
		super(fileName);
	}
	
	public int getNumOfHits(){
		return super.loadData()[0];
	}
	public void setNumOfHits(int numOfHits){
		int[] data=super.loadData();
		data[0]=numOfHits;
		super.saveData(data);
	}
	
	public int getGameTime(){
		return super.loadData()[1];
	}
	public void setGameTime(int time){
		int[] data=super.loadData();
		data[1]=time;
		super.saveData(data);
	}
	
	public void setHitsAndTime(int numOfHits, int time){
		this.setNumOfHits(numOfHits);
		this.setGameTime(time);
	}
}


class SettingsFile extends DataFile {
	public SettingsFile(String fileName){
		super(fileName);
	}
	
	public boolean getSFXOn(){
		return (super.loadData()[0]==1)? true: false;
	}
	public void setSFXOn(boolean onOff){
		int[] data=super.loadData();
		data[0]=(onOff)? 1: 0;
		super.saveData(data);
	}
	
	public boolean getMusicOn(){
		return (super.loadData()[1]==1)? true: false;
	}
	public void setMusicOn(boolean onOff){
		int[] data=super.loadData();
		data[1]=(onOff)? 1: 0;
		super.saveData(data);
	}
	
	public void setMusicAndSFXOn(boolean[] settings){
		this.setSFXOn(settings[0]);
		this.setMusicOn(settings[1]);
	}
}
