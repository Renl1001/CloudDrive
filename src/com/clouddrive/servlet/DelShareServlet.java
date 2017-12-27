package com.clouddrive.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.clouddrive.dao.impl.ShareDaoImpl;

/**
 * Servlet implementation class delShareServlet
 */
@WebServlet("/delShareServlet")
public class DelShareServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		System.out.println("DelShareServlet");
		
		String key = req.getParameter("key");
		
		ShareDaoImpl shareDaoImpl = new ShareDaoImpl();
		shareDaoImpl.delShareByKey(key);
		
		resp.sendRedirect("ShareManage");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
