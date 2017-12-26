package com.clouddrive.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.clouddrive.biz.impl.LoginBizImpl;
import com.clouddrive.entity.User;

public class LoginServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		String userName = req.getParameter("userName");
		String pwd = req.getParameter("pwd");
		
		System.out.println("doLogin");
		System.out.println("userName:"+userName);
		System.out.println("password"+pwd);
		
		LoginBizImpl loginBiz = new LoginBizImpl();
		User user = loginBiz.login(userName, pwd);
		
		if(user == null) {
			String message = "用户名不存在或密码错误！";
			req.setAttribute("message", message);
			req.getRequestDispatcher("/home.jsp").forward(req, resp);
		} else {
			HttpSession session = req.getSession();
			session.setAttribute("name", userName);
			resp.sendRedirect("ListFiles");
			//req.getRequestDispatcher("ListFileServlet").forward(req, resp);
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
