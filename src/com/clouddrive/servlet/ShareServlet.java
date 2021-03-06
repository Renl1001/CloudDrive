package com.clouddrive.servlet;

import java.io.IOException;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.clouddrive.biz.impl.ShareManageBizImpl;
import com.clouddrive.dao.impl.ShareDaoImpl;
import com.clouddrive.entity.Share;

/**
 * Servlet implementation class ShareServlet
 */
@WebServlet("/ShareServlet")
public class ShareServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		System.out.println("ShareServlet:");
		
		String key = req.getParameter("key");
		
		ShareManageBizImpl shareManage = new ShareManageBizImpl();
		Share share = shareManage.getShareByKey(key);
		
		ShareDaoImpl shareDaoImpl = new ShareDaoImpl();
		Vector<Share> shares = shareDaoImpl.getHotShare();
		req.setAttribute("shares", shares);
		req.setAttribute("share", share);
		req.getRequestDispatcher("share.jsp").forward(req, resp);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
