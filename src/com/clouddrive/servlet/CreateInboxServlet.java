package com.clouddrive.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.clouddrive.biz.impl.InboxManageBizImpl;

/**
 * Servlet implementation class MkInbox
 */
@WebServlet("/MkInbox")
public class CreateInboxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		String userName = (String) session.getAttribute("name");
		String uuidName = req.getParameter("inboxName");
		uuidName = makeUUIDName(uuidName);
		String illustrate = req.getParameter("illustrate");
		
		String path = this.getServletContext().getRealPath("/WEB-INF/Drive/" + userName + "/" + uuidName);

		System.out.println("MkInbox:");

		InboxManageBizImpl inboxManageBizImpl = new InboxManageBizImpl();				
		String key = inboxManageBizImpl.insertShare(userName, uuidName, path, illustrate);
		String link = req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() + req.getContextPath()
				+ "/Inbox" + "?key=" + key;
		
//		JSONObject json = new JSONObject();
		
		System.out.println(link);
		PrintWriter out = resp.getWriter();
		out.write(link);
		out.close();
	}
	
	// 产生UUID
	public String makeUUIDName(String fileName) {
		return UUID.randomUUID().toString() + "_" + fileName;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
