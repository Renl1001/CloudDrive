package com.clouddrive.servlet;

import java.io.File;
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

import net.sf.json.JSONObject;

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
		
		String inboxName = req.getParameter("inboxName");
		if(inboxName == null || inboxName.trim().equals("")) {
			JSONObject json = new JSONObject();
			json.put("message", "文件夹名不能为空");
			PrintWriter out = resp.getWriter();
			out.println(json);
			out.close();
			return;
		}
		String illustrate = req.getParameter("illustrate");
		
		String path = this.getServletContext().getRealPath("/WEB-INF/Drive/" + userName + "/inbox/" + inboxName);
		File folder = new File(path);
		
		if(!folder.exists() || !folder.isDirectory()) {
			System.out.println(path+"目录不存在，需要创建");
			folder.mkdirs();
		}
		System.out.println("MkInbox:");

		InboxManageBizImpl inboxManageBizImpl = new InboxManageBizImpl();				
		String key = inboxManageBizImpl.insertInbox(userName, inboxName, illustrate);
		String link = req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() + req.getContextPath()
				+ "/Inbox" + "?key=" + key;
		
		JSONObject json = new JSONObject();
		json.put("link", link);
		System.out.println(link);
		PrintWriter out = resp.getWriter();
		out.println(json);
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
