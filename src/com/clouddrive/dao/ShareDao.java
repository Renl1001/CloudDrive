package com.clouddrive.dao;

import java.util.Vector;

import com.clouddrive.entity.Share;

public interface ShareDao {
	// 查找分享
	public int countShareByKey(String key);

	public Share findShareByKey(String key);
	
	public Vector<Share> findShareByUser(String name);

	// 添加分享
	public int insert(Share share);
	
	// 更新分享
	public int updateDownloadByKey(String key);
	
	// 删除分享
	public int delShareByKey(String key);
}
