package com.clouddrive.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.clouddrive.dao.impl.ShareDaoImpl;
import com.clouddrive.entity.CreateKey;
import com.clouddrive.entity.CurrentTime;
import com.clouddrive.entity.Share;

public class ShareFileServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		String userName = (String)session.getAttribute("name");
		String uuidName = req.getParameter("fileName");
		String path = req.getParameter("path");
		long size = Long.parseLong(req.getParameter("size"));
		
		System.out.println("ShareFile");
		
		String url = this.getServletContext().getRealPath("/WEB-INF/Drive/"+userName+"\\"+path+"\\"+uuidName);
		String currentTime = new CurrentTime().getDateString();
		String key = new CreateKey().createPassWord(8);
		Share share = new Share(userName, uuidName, url, currentTime, key, 0, size);
		
		ShareDaoImpl shareImpl = new ShareDaoImpl();
		shareImpl.insert(share);
		
		String link = req.getScheme()+"://"
		+req.getServerName()+":" + req.getServerPort()
		+req.getContextPath()+"/Share"
		+"?key="+key;
		
		System.out.println(link);
		PrintWriter out = resp.getWriter();
		out.write(link);
		out.close();
//		req.setAttribute("link", link);
//		req.getRequestDispatcher("/auth/drive.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

}
