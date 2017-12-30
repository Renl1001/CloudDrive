package com.clouddrive.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.clouddrive.biz.impl.InboxManageBizImpl;
import com.clouddrive.entity.Inbox;

/**
 * Servlet implementation class InboxServlet
 */
@WebServlet("/InboxServlet")
public class InboxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		System.out.println("InboxServlet:");
		
		String key = req.getParameter("key");
		System.out.println("key:"+key);
		InboxManageBizImpl inboxManageBizImpl = new InboxManageBizImpl();
		Inbox inbox = inboxManageBizImpl.getInboxByKey(key);
		if(inbox == null) {
			System.out.println("没找到收件夹");
		}
		req.setAttribute("inbox", inbox);
		req.getRequestDispatcher("inbox.jsp").forward(req, resp);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
