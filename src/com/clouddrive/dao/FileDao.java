package com.clouddrive.dao;

import java.util.Vector;

import com.clouddrive.entity.FileMessage;

public interface FileDao {
	// 查找文件
	public Vector<FileMessage> findFilesByPath(String path);

	// 添加文件
	public int insert(FileMessage file);
}
