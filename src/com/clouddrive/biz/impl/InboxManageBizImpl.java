package com.clouddrive.biz.impl;

import com.clouddrive.biz.InboxManageBiz;
import com.clouddrive.dao.impl.InboxDaoImpl;
import com.clouddrive.entity.CreateKey;
import com.clouddrive.entity.CurrentTime;
import com.clouddrive.entity.Inbox;
import com.clouddrive.entity.Share;

public class InboxManageBizImpl implements InboxManageBiz {

	private InboxDaoImpl inboxDaoImpl = new InboxDaoImpl(); 
	
	@Override
	public String insertInbox(String userName, String uuidName, String path, String illustrate) {
		String currentTime = new CurrentTime().getDateString();
		String key  = new CreateKey().createPassWord(8);
		
		Inbox inbox = new Inbox(userName, uuidName, illustrate, path, currentTime, currentTime, key);
		
		inboxDaoImpl.insert(inbox);
		return key;
	}

	@Override
	public Inbox getInboxByKey(String key) {
		Inbox inbox = inboxDaoImpl.findInboxByKey(key);
		return inbox;
	}

}
