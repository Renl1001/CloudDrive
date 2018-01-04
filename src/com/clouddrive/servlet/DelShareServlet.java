package com.clouddrive.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.clouddrive.biz.impl.ShareManageBizImpl;

import net.sf.json.JSONObject;

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
		
		String[] keys = req.getParameterValues("keys");
		ShareManageBizImpl shareManage = new ShareManageBizImpl();
		if(keys != null) {
			for(String key:keys) {
				shareManage.delShareByKey(key);
			}
		} else {
			String key = req.getParameter("key");
			shareManage.delShareByKey(key);
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
