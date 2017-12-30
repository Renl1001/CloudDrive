package com.clouddrive.biz;

import com.clouddrive.entity.Inbox;

public interface InboxManageBiz {
	public String insertInbox(String userName, String uuidName, String path, String illustrate);
	
	public Inbox getInboxByKey(String key);
}
