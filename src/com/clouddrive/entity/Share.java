package com.clouddrive.entity;

public class Share {
	private String user;
	private String fileName;
	private String url;
	private String shareTime;
	private String key;
	public Share(String user, String fileName, String url, String shareTime, String key) {
		super();
		this.user = user;
		this.fileName = fileName;
		this.url = url;
		this.shareTime = shareTime;
		this.key = key;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getShareTime() {
		return shareTime;
	}
	public void setShareTime(String shareTime) {
		this.shareTime = shareTime;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	
	
}
