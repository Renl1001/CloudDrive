package com.clouddrive.dao;

import java.util.Vector;

import com.clouddrive.entity.Inbox;

public interface InboxDao {
	// 查找收件夹
	public int countInboxByKey(String key);
	public int countInboxByUuidName(String uuidName);
	public Inbox findInboxByKey(String key);
	public Vector<Inbox> findInboxByUser(String name);

	// 添加收件夹
	public int insert(Inbox inbox);
	
	// 更新收件夹
	
	
	// 删除收件夹
	public int delInboxByKey(String key);
}
