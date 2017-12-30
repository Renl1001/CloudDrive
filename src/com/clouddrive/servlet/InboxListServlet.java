package com.clouddrive.servlet;

import java.io.IOException;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.clouddrive.dao.impl.InboxDaoImpl;
import com.clouddrive.entity.Inbox;

/**
 * Servlet implementation class InboxListServlet
 */
@WebServlet("/InboxListServlet")
public class InboxListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InboxListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		String userName = (String)session.getAttribute("name");
		
		System.out.println("InboxManage:");
		
		if(userName == null) {
			req.setAttribute("message", "请登录");
			req.getRequestDispatcher("Home").forward(req, resp);
			/*resp.sendRedirect("DoLogin");*/
			return ;
		}
		
		InboxDaoImpl inboxDaoImpl = new InboxDaoImpl();
		Vector<Inbox> inboxs = inboxDaoImpl.findInboxByUser(userName);
		
		req.setAttribute("inboxs", inboxs);
		
		req.getRequestDispatcher("/auth/myInbox.jsp").forward(req, resp);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
