package com.clouddrive.servlet;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.clouddrive.biz.impl.FileManageBizImpl;

@SuppressWarnings("serial")
public class MkDirServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		String fileName = req.getParameter("folderName");
		System.out.println("MkDir:");
		HttpSession session = req.getSession();
		String path = (String)session.getAttribute("path");
		String userName = (String)session.getAttribute("name");
		String savePath = this.getServletContext().getRealPath("/WEB-INF/Drive/"+userName+"/"+path+"/"+fileName);
		System.out.println(savePath);
		File folder = new File(savePath);
		
		if(!folder.exists() || !folder.isDirectory()) {
			System.out.println(savePath+"目录不存在，需要创建");
			folder.mkdirs();
		}
		
		FileManageBizImpl fileManage = new FileManageBizImpl();
		if(fileManage.mkdirFolder(path, fileName, userName)) {
			// 创建成功
		}
		
		resp.sendRedirect("ListFiles");
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
