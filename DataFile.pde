class DataFile {
	protected String fileName;
	
	public DataFile(String fileName){
		this.fileName=fileName;
	}
	
	protected int[] loadData(){
		String[] stringData=loadStrings(this.fileName);
		int[] intData=int(split(stringData[0],","));
		return intData;
	}
	
	protected void saveData(int[] data){
		String[] dataString=new String[]{String.format("%d,%d",data[0],data[1])};
		saveStrings(this.fileName,dataString);
	}
}
