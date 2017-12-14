package com.clouddrive.servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.clouddrive.dao.impl.FileDaoImpl;
import com.clouddrive.entity.FileMessage;

public class ListFiles extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		String path = (String)req.getParameter("path");
		if(path == null) {
			path = (String)session.getAttribute("path");
		} else {
			session.setAttribute("path", path);
		}
		
		if(path == null) {
			System.out.println("找不到路径，默认为root");
			path = "root";
		}
		String userName = (String)session.getAttribute("name");
		if(userName == null) {
			resp.sendRedirect("login.jsp");
		}
		String uploadFilePath = this.getServletContext().getRealPath("/WEB-INF/Drive/"+userName+"/"+path);
		System.out.println(uploadFilePath);
		// 存储要下载的文件名
		FileDaoImpl fileDaoImpl = new FileDaoImpl();
		Vector<FileMessage> files = fileDaoImpl.findFilesByPath(uploadFilePath); 
		
		// TODO 直接从文件中读取（后面要改成数据库读取）
		/*File folder = new File(uploadFilePath);
		File files[] = folder.listFiles();
		for(File file : files) {
			System.out.println(file.getName());
			String realName = file.getName().substring(file.getName().indexOf("_")+1);
			fileNameMap.put(file.getName(), realName);
		}*/
		Map<String, String> paths = new LinkedHashMap<>();
		String pathNames[] = path.split("/");
		createPaths(paths, pathNames);
		
		String lastPath = getLastPath(pathNames);
		req.setAttribute("lastPath", lastPath);
		req.setAttribute("files", files);
		req.setAttribute("paths", paths);
		req.setAttribute("path", path);
		req.getRequestDispatcher("/index.jsp").forward(req, resp);
	}
	
	String getLastPath(String pathNames[]) {
		int len = pathNames.length;
		String lastPath = "";
		for(int i = 0; i < len-1; i++) {
			if(i == 0) {
				lastPath = pathNames[i];
			} else {
				lastPath = lastPath + "/" + pathNames[i];
			}
		}
		return lastPath;
	}
	
	void createPaths(Map<String, String> paths, String pathNames[]) {
		String curPath = "";
		for(String name : pathNames) {
			if(curPath == "") {
				curPath = name;
				paths.put(name,	curPath);
			} else {
				curPath = curPath + "/" + name;
				paths.put(name, curPath);
			}
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
	
	
}
