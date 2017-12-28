package com.clouddrive.biz.impl;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.clouddrive.biz.FileManageBiz;
import com.clouddrive.dao.impl.FileDaoImpl;
import com.clouddrive.entity.FileMessage;

public class FileManageBizImpl implements FileManageBiz {

	@Override
	public boolean delFile(String path, String uuidName) {
		String url = path+"\\"+uuidName;
		
		File file = new File(url);
		if(!file.exists()) {
			// 文件不存在
			return false;
		}
		boolean d = file.delete();
		if (!d) {
			System.out.println("删除失败！");
			return false;
		}
		FileDaoImpl fileDaoImpl = new FileDaoImpl();
		if(fileDaoImpl.delFileByUuidName(uuidName) != 0) {
			ShareManageBizImpl shareMaange = new ShareManageBizImpl();
			shareMaange.delShareByUuidName(uuidName);
			return true;
		}
		return false;
	}

	@Override
	public boolean mkdirFolder(String savePath, String fileName, String userName) {
		File folder = new File(savePath);
		if(!folder.exists() || !folder.isDirectory()) {
			System.out.println(savePath+"目录不存在，需要创建");
			folder.mkdirs();
		}
		String type = "folder";
		Date date = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String updateTime = format.format(date);
		System.out.println("fileName:" + fileName);
		FileMessage fileMessage = new FileMessage(fileName, updateTime, type, savePath, userName);
		
		FileDaoImpl fileDaoImpl = new FileDaoImpl();
		if(fileDaoImpl.insert(fileMessage) != 0) {
			return true;
		}
		return false;
	}

}
