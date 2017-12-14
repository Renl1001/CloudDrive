package com.clouddrive.servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.clouddrive.dao.impl.FileDaoImpl;
import com.clouddrive.entity.FileMessage;

public class UpLoad extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		String userName = (String)session.getAttribute("name");
		String path = "";
		//用户保存的文件路径
		String savePath = "";
		
		String message = "";
		try{
			DiskFileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			// 设置文件名编码格式
			upload.setHeaderEncoding("UTF-8");
			// 判断提交的数据是否是表单数据
			if(!ServletFileUpload.isMultipartContent(req)) {
				//普通数据
				System.out.println("普通数据");
				return ;
			}
			List<FileItem> fileList = upload.parseRequest(req);
			for(FileItem item : fileList) {
				// 普通数据项
				if(item.isFormField()) {
					String name = item.getFieldName();
					String value = item.getString("UTF-8");
					System.out.println(name+"="+value);
					if(name.equals("path")) {
						path = value;
						savePath = this.getServletContext().getRealPath("/WEB-INF/Drive/"+userName+"/"+path);
						System.out.println("文件上传路径：");
						System.out.println(savePath);
						File folder = new File(savePath);
						
						if(!folder.exists() || !folder.isDirectory()) {
							System.out.println(savePath+"目录不存在，需要创建");
							folder.mkdirs();
						}
					}
				} else {
					// 获取文件名
					String fileName = item.getName();
					System.out.println(fileName);
					if(fileName == null || fileName.trim().equals("")) {
						continue;
					}
					// 处理获取到的上传文件的文件名的路径部分，只保留文件名部分
					fileName = fileName.substring(fileName.lastIndexOf("\\")+1);
					
					// 添加UUID
					String uuidName = makeFileName(fileName);
					
					InputStream in = item.getInputStream();
					FileOutputStream out = new FileOutputStream(savePath+"\\"+uuidName);
					byte buffer[] = new byte[1024];
					int len = 0;
					while((len=in.read(buffer)) > 0) {
						out.write(buffer,0,len);
					}
					in.close();
					out.close();
					long fileSize = item.getSize();
					item.delete();
					message = "文件上传成功!";
					System.out.println("文件上传成功!");
					System.out.println("文件大小："+fileSize);
					String type = "document";
					Date date = new Date();
					SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
					String updateTime = format.format(date);
					FileMessage fileMessage = new FileMessage(fileName, uuidName, updateTime, type, savePath, userName, fileSize);
					
					FileDaoImpl fileDaoImpl = new FileDaoImpl();
					fileDaoImpl.insert(fileMessage);
					System.out.println("数据库操作成功");
				}
			}
		} catch(Exception e) {
			message = "文件上传失败!";
			System.out.println("文件上传失败!");
			e.printStackTrace();
		}
		System.out.println("yes2");
		req.setAttribute("message", message);
		resp.sendRedirect("ListFiles");
		//req.getRequestDispatcher("/index.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
	
	// 产生唯一文件名
	public String makeFileName(String fileName) {
		return UUID.randomUUID().toString() + "_" + fileName;
	}
}
