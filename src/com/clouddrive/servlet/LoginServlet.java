package com.clouddrive.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.clouddrive.biz.impl.LoginBizImpl;
import com.clouddrive.entity.User;

@SuppressWarnings("serial")
public class LoginServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		
		String[] isSaveArr = req.getParameterValues("isSave");
		if(isSaveArr == null) {
			System.out.println("null");
		} else {
			System.out.println("not null");
		}
		String message = (String)req.getAttribute("message");
		if(message != null && message.equals("noPrimse")) {
			req.setAttribute("message", "请登录");
			req.getRequestDispatcher("Home").forward(req, resp);
		}
		
		String userName = req.getParameter("userName");
		String pwd = req.getParameter("pwd");
		
		System.out.println("DoLogin");
		System.out.println("userName:"+userName);
		System.out.println("password:"+pwd);
		
		LoginBizImpl loginBiz = new LoginBizImpl();
		User user = loginBiz.login(userName, User.md5Password(pwd));
		
		if(user == null) {
			req.setAttribute("message", "用户名或密码错误！");
			req.getRequestDispatcher("Home").forward(req, resp);
		} else {// 登录成功
			// 添加cookie
			if(isSaveArr != null) {
				System.out.println("yes");
				Cookie userNameCookie = new Cookie("saveName",userName);
				userNameCookie.setMaxAge(30*60);
				resp.addCookie(userNameCookie);
			}
			HttpSession session = req.getSession();
			session.setAttribute("name", userName);
			resp.sendRedirect("ListFiles");
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
