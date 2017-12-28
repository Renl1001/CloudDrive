package com.clouddrive.servlet;

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
		String path = req.getParameter("path");
		HttpSession session = req.getSession();
		String userName = (String)session.getAttribute("name");
		String savePath = this.getServletContext().getRealPath("/WEB-INF/Drive/"+userName+"/"+path);
		
		FileManageBizImpl fileManage = new FileManageBizImpl();
		if(fileManage.mkdirFolder(savePath, fileName, userName)) {
			// 创建成功
		}
		
		session.setAttribute("path", path);
		resp.sendRedirect("ListFiles");
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
