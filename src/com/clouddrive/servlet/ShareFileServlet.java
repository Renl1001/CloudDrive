package com.clouddrive.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.clouddrive.dao.impl.ShareImpl;
import com.clouddrive.entity.CreateKey;
import com.clouddrive.entity.CurrentTime;
import com.clouddrive.entity.Share;

public class ShareFileServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		String userName = (String)session.getAttribute("name");
		String fileName = req.getParameter("fileName");
		String path = req.getParameter("path");
		
		String url = this.getServletContext().getRealPath("/WEB-INF/Drive/"+userName+"\\"+path+"\\"+fileName);
		String currentTime = new CurrentTime().getDateString();
		String key = new CreateKey().createPassWord(8);
		
		Share share = new Share(userName, fileName, url, currentTime, key);
		
		ShareImpl shareImpl = new ShareImpl();
		shareImpl.insert(share);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

}
