package com.clouddrive.biz;

import com.clouddrive.entity.Inbox;

public interface InboxManageBiz {
	public String insertShare(String userName, String uuidName, String path, String illustrate);
	
	public Inbox getInboxByKey(String key);
}
