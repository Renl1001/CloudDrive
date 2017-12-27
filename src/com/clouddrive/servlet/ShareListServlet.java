package com.clouddrive.servlet;

import java.io.IOException;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.clouddrive.dao.impl.ShareDaoImpl;
import com.clouddrive.entity.Share;

/**
 * Servlet implementation class ShareListServlet
 */
@WebServlet("/ShareListServlet")
public class ShareListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		String userName = (String)session.getAttribute("name");
		
		System.out.println("ShareManage:");
		
		if(userName == null) {
			resp.sendRedirect("home.jsp");
			return ;
		}
		
		ShareDaoImpl shareImpl = new ShareDaoImpl();
		Vector<Share> shares = shareImpl.findShareByUser(userName);
		
		req.setAttribute("shares", shares);
		
		req.getRequestDispatcher("/auth/myShare.jsp").forward(req, resp);;
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
