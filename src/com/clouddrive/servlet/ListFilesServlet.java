package com.clouddrive.servlet;

import java.io.IOException;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.clouddrive.biz.impl.FileListBizImpl;
import com.clouddrive.entity.FileMessage;

@SuppressWarnings("serial")
public class ListFilesServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		
		String userName = (String)session.getAttribute("name");
		// 用户名失效，跳转到登录界面
		if(userName == null) {
			resp.sendRedirect("home.jsp");
			return;
		}
		
		String path = (String)req.getParameter("path");
		if(path == null) {
			path = (String)session.getAttribute("path");
			if(path == null) {
				System.out.println("找不到路径，默认为root");
				path = "root";
				session.setAttribute("path", path);
			}
		} else {
			session.setAttribute("path", path);
		}
		
		System.out.println("-----ListFiles:");
		System.out.println("path:");
		System.out.println(path);
		
		// 业务逻辑
		FileListBizImpl fileListBizImpl = new FileListBizImpl();
		
		// 通过文件类型获取fileList
		Vector<FileMessage> files = fileListBizImpl.getFilesByTypeAndUser(userName, path);
		if(files != null) {
			req.setAttribute("files", files);
			req.setAttribute("path", path);
			req.getRequestDispatcher("/auth/drive.jsp").forward(req, resp);
			return ;
		}
		
		String uploadFilePath = this.getServletContext().getRealPath("/WEB-INF/Drive/"+userName+"/"+path);
		// 通过路径获取fileList
		files = fileListBizImpl.getFilesByPath(uploadFilePath); 
		
		Map<String, String> paths = fileListBizImpl.getPaths(path);
		String lastPath = fileListBizImpl.getLastPath(path);
		req.setAttribute("lastPath", lastPath);
		req.setAttribute("files", files);
		req.setAttribute("paths", paths);
		req.setAttribute("path", path);
		req.getRequestDispatcher("/auth/drive.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
	
	
}
