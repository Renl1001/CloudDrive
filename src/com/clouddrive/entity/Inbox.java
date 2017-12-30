package com.clouddrive.entity;

public class Inbox {
	private String user;
	private String uuidName;
	private String illustrate;
	private String path;
	private String startTime;
	private String endTime;
	private String key;
	private String inboxName;
	public Inbox(String user, String uuidName, String illustrate, String path, String startTime, String endTime, String key) {
		super();
		this.user = user;
		this.uuidName = uuidName;
		this.illustrate = illustrate;
		this.inboxName = uuidName.substring(uuidName.indexOf("_")+1);
		this.path = path;
		this.startTime = startTime;
		this.endTime = endTime;
		this.key = key;
	}
	public String getIllustrate() {
		return illustrate;
	}
	public void setIllustrate(String illustrate) {
		this.illustrate = illustrate;
	}

	public String getInboxName() {
		return inboxName;
	}
	public void setInboxName(String inboxName) {
		this.inboxName = inboxName;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getUuidName() {
		return uuidName;
	}
	public void setUuidName(String uuidName) {
		this.uuidName = uuidName;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	
	
}
