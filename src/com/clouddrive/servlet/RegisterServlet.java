package com.clouddrive.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.clouddrive.biz.impl.RegisterBizImpl;
import com.clouddrive.entity.User;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String userName = req.getParameter("ruserName");
		String pwd = req.getParameter("rpwd");
		
		System.out.println("Registering");
		System.out.println("userName:"+userName);
		System.out.println("password:"+pwd);
		
		RegisterBizImpl registerBizImpl = new RegisterBizImpl();
		if(registerBizImpl.register(userName, User.md5Password(pwd))){
			HttpSession session = req.getSession();
			session.setAttribute("name", userName);
			resp.sendRedirect("ListFiles");
			return;
		}else{
			String message = "用户名已存在";
			req.setAttribute("rmessage", message);
			req.getRequestDispatcher("Home").forward(req, resp);
			return;
		}
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
