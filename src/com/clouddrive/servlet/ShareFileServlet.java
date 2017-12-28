package com.clouddrive.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.clouddrive.biz.impl.ShareManageBizImpl;

@SuppressWarnings("serial")
public class ShareFileServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		String userName = (String) session.getAttribute("name");
		String uuidName = req.getParameter("fileName");
		String path = req.getParameter("path");
		long size = Long.parseLong(req.getParameter("size"));
		String url = this.getServletContext().getRealPath("/WEB-INF/Drive/" + userName + "\\" + path + "\\" + uuidName);

		System.out.println("ShareFile");

		ShareManageBizImpl shareManage = new ShareManageBizImpl();
		String key = shareManage.insertShare(userName, uuidName, url, size);
		String link = req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() + req.getContextPath()
				+ "/Share" + "?key=" + key;
		System.out.println(link);
		PrintWriter out = resp.getWriter();
		out.write(link);
		out.close();

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

}
