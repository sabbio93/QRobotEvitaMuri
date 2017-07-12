package it.unibo.sonarrasp;

import java.io.*;

public class SonarRasp {
	private BufferedReader readerC;
	public void startSonarC(int pinTrig, int pinEcho){
		try{
			Process p=Runtime.getRuntime().exec("sudo ./SonarAlone "+pinTrig+" "+pinEcho);
			readerC=new BufferedReader(new InputStreamReader(p.getInputStream()));
			getDistanceFromSonar();
		} catch (Exception e){
			e.printStackTrace();
		}
	}
	public String getDistanceFromSonar(){
		try{
			String inpS=readerC.readLine();
			return "d("+inpS+")";
		} catch (Exception e){
			e.printStackTrace();
			return "d("+Integer.MAX_VALUE+")";
		}
	}
}
