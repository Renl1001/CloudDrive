package com.clouddrive.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.clouddrive.biz.impl.InboxBizImpl;

/**
 * Servlet implementation class DelInboxServlet
 */
@WebServlet("/DelInboxServlet")
public class DelInboxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String key = req.getParameter("key");
		String path = req.getParameter("path");
		System.out.println("delFileServlet:");
		
		InboxBizImpl inboxBizImpl = new InboxBizImpl();
		if(inboxBizImpl.delInbox(path, key)) {
			// 删除成功
			System.out.println("删除成功");
		}
		
		resp.sendRedirect("InboxManage");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
