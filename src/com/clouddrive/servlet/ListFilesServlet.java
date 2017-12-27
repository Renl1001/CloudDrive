package com.clouddrive.servlet;

import java.io.IOException;
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

public class ListFilesServlet extends HttpServlet {
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
			resp.sendRedirect("home.jsp");
			return;
		}
		
		String uploadFilePath = this.getServletContext().getRealPath("/WEB-INF/Drive/"+userName+"/"+path);
		String types[] = {"image", "document", "video", "music", "other"};
		
		for (String type:types) {
			if(path.equals(type)) {
				// 存储要下载的文件名
				FileDaoImpl fileDaoImpl = new FileDaoImpl();
				Vector<FileMessage> files;
				if(type.equals("document")) {
					files = fileDaoImpl.findFilesByType("doc");
					for (FileMessage file:fileDaoImpl.findFilesByType("xls")) {
						files.add(file);
					}
					for (FileMessage file:fileDaoImpl.findFilesByType("ppt")) {
						files.add(file);
					}
				} else {
					files = fileDaoImpl.findFilesByType(path);
				}
				req.setAttribute("files", files);
				req.setAttribute("path", path);
				req.getRequestDispatcher("/auth/drive.jsp").forward(req, resp);
				return ;
			}
		}
		System.out.println("ListFiles:");
//		System.out.println(uploadFilePath);
		System.out.println("path:");
		System.out.println(path);
		// 存储要下载的文件名
		FileDaoImpl fileDaoImpl = new FileDaoImpl();
		Vector<FileMessage> files = fileDaoImpl.findFilesByPath(uploadFilePath); 
		
		Map<String, String> paths = new LinkedHashMap<>();
		String pathNames[] = path.split("/");
		createPaths(paths, pathNames);
		
		String lastPath = getLastPath(pathNames);
		req.setAttribute("lastPath", lastPath);
		req.setAttribute("files", files);
		req.setAttribute("paths", paths);
		req.setAttribute("path", path);
		req.getRequestDispatcher("/auth/drive.jsp").forward(req, resp);
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
