package com.clouddrive.dao;

import com.clouddrive.entity.Share;

public interface ShareDao {
	// 查找分享
	public int countShareByKey(String key);

	public Share findShareByKey(String key);

	// 添加分享
	public int insert(Share share);
}
