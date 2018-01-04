package com.clouddrive.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.clouddrive.biz.impl.FileManageBizImpl;

import net.sf.json.JSONObject;

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
		String uuidNames[] = req.getParameterValues("fileName");
		String paths[] = req.getParameterValues("path");
		System.out.println("delFileServlet:");
		for(int i = 0; i < paths.length; i++) {
			String path = paths[i];
			String url = this.getServletContext().getRealPath("/WEB-INF/Drive/"+userName+"/"+path+"/"+uuidNames[i]);
			FileManageBizImpl fileManage = new FileManageBizImpl();
			if(fileManage.delFile(url, path)) {
				// 删除成功
				System.out.println("删除成功");
			}
		}
		JSONObject json = new JSONObject();
		json.put("success", "删除成功");
		resp.setCharacterEncoding("UTF-8");
		PrintWriter out = resp.getWriter();
		out.println(json);
		out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
