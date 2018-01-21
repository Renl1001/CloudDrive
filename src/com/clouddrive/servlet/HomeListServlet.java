package com.clouddrive.servlet;

import java.io.IOException;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.clouddrive.dao.impl.ShareDaoImpl;
import com.clouddrive.entity.Share;

/**
 * Servlet implementation class HomeListServlet
 */
@WebServlet("/HomeListServlet")
public class HomeListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		String userName = (String) session.getAttribute("name");
		if(userName == null) {
			Cookie[] cookies = req.getCookies();
			if(cookies != null) {
				for(Cookie cookie : cookies) {
					if(cookie.getName().equals("saveName")) {
						userName = cookie.getValue();	
						session.setAttribute("name", userName);
						resp.sendRedirect("Home");
						return ;
					}
				}
			}
		}
		
		String message = (String)req.getAttribute("message");
		
		ShareDaoImpl shareDaoImpl = new ShareDaoImpl();
		Vector<Share> shares = shareDaoImpl.getHotShare();
		req.setAttribute("message", message);
		req.setAttribute("shares", shares);
		req.getRequestDispatcher("home.jsp").forward(req, resp);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
