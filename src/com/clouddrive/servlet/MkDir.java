package com.clouddrive.servlet;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.clouddrive.dao.impl.FileDaoImpl;
import com.clouddrive.entity.FileMessage;

public class MkDir extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String fileName = req.getParameter("folderName");
		String path = req.getParameter("path");
		HttpSession session = req.getSession();
		String userName = (String)session.getAttribute("name");
		String savePath = this.getServletContext().getRealPath("/WEB-INF/Drive/"+userName+"/"+path);
		System.out.println("文件夹路径：");
		System.out.println(savePath);
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
		fileDaoImpl.insert(fileMessage);
		System.out.println("数据库操作成功");
		session.setAttribute("path", path);
		resp.sendRedirect("ListFiles");
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
