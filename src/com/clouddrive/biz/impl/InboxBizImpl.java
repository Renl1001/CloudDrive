package com.clouddrive.biz.impl;

import java.io.File;

import com.clouddrive.biz.InboxBiz;
import com.clouddrive.dao.impl.FileDaoImpl;
import com.clouddrive.dao.impl.InboxDaoImpl;

public class InboxBizImpl implements InboxBiz {

	private InboxDaoImpl inboxDaoImpl = new InboxDaoImpl(); 
	
	@Override
	public boolean delInbox(String path, String key) {
		File file = new File(path);
		System.out.println("path:"+path);
		if (!file.exists()) {
			// 文件不存在
			System.out.println("文件不存在");
			return false;
		}
		if (file.isDirectory()) {
			// 如果是文件夹
			System.out.println("删除文件夹");
			String[] children = file.list();
            //递归删除目录中的子目录下
            for (int i=0; i<children.length; i++) {
                boolean success = deleteFile(new File(file, children[i]));
                if (!success) {
                    return false;
                }
            }
            // 目录此时为空，可以删除
            inboxDaoImpl.delInboxByKey(key);
            return file.delete();
		} else {
			System.out.println("删除文件");
			return deleteFile(file);
		}
	}
	
	// 删除文件
	private boolean deleteFile(File file) {
		String uuidName = file.getName();
		FileDaoImpl fileDaoImpl = new FileDaoImpl();
		fileDaoImpl.delFileByUuidName(uuidName);
		return file.delete();
	}

}
