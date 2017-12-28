package com.clouddrive.biz.impl;

import java.io.File;

import com.clouddrive.biz.DelFileBiz;
import com.clouddrive.dao.impl.FileDaoImpl;

public class DelFileBizImpl implements DelFileBiz {

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
			return true;
		}
		return false;
		
	}

}
