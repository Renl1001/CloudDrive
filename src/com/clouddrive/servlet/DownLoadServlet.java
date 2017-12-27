package com.clouddrive.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.clouddrive.dao.impl.ShareDaoImpl;

public class DownLoadServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		String userName = (String)session.getAttribute("name");
		String fileName = req.getParameter("fileName");
		String path = req.getParameter("path");
		String url = req.getParameter("url");
		
		if(url == null) {
			System.out.println("path:"+path);
			System.out.println("下载的文件名："+fileName);
			String fileSaveRootPath = this.getServletContext().getRealPath("/WEB-INF/Drive/"+userName+"\\"+path);
			url = fileSaveRootPath+"\\"+fileName;
		} else {
			System.out.println("下载分享文件");
			String key = req.getParameter("key");
			ShareDaoImpl shareDaoImpl = new ShareDaoImpl();
			shareDaoImpl.updateDownloadByKey(key);
		}
		File file = new File(url);
		if(!file.exists()) {
			req.setAttribute("message", "资源已被删除");
			req.getRequestDispatcher("/message.jsp").forward(req, resp);
			return ;
		}
		String realName = fileName.substring(fileName.indexOf("_")+1);
		resp.setHeader("content-disposition", "attachment;filename=" + URLEncoder.encode(realName, "UTF-8"));
		
		FileInputStream in = new FileInputStream(url);
		OutputStream out = resp.getOutputStream();
		
		byte buffer[] = new byte[1024];
		int len = 0;
		
		while((len=in.read(buffer))>0) {
			out.write(buffer,0,len);
		}
		in.close();
		out.close();
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
