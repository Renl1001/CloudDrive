package com.clouddrive.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.clouddrive.biz.impl.FileManageBizImpl;

/**
 * Servlet implementation class DelFile
 */
@WebServlet("/DelFile")
public class DelFileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		String userName = (String)session.getAttribute("name");
		String uuidName = req.getParameter("fileName");
		String path = req.getParameter("path");
		System.out.println("delFileServlet:");
		String url = this.getServletContext().getRealPath("/WEB-INF/Drive/"+userName+"/"+path+"/"+uuidName);
		FileManageBizImpl fileManage = new FileManageBizImpl();
		if(fileManage.delFile(url, path)) {
			// 删除成功
			System.out.println("删除成功");
		}
		
		resp.sendRedirect("ListFiles");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
