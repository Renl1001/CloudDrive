package com.clouddrive.servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
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
import com.clouddrive.entity.CurrentTime;
import com.clouddrive.entity.FileMessage;
import com.clouddrive.entity.Type;

import net.sf.json.JSONObject;

@SuppressWarnings("serial")
public class UpLoadServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("application/json");
		resp.setCharacterEncoding("UTF-8");
		
		HttpSession session = req.getSession();
		String userName = (String)session.getAttribute("name");
		String preName = "";
		
		String path = (String)session.getAttribute("path");
		//用户保存的文件路径
		String savePath = "";
		
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
			FileItem fileItem = null;
			boolean isInbox = false;
			for(FileItem item : fileList) {
				// 普通数据项
				if(item.isFormField()) {
					String name = item.getFieldName();
					String value = item.getString("UTF-8");
					System.out.println(name+"="+value);
					if(name.equals("path")) {
						path = value;
					} else if(name.equals("idTF")) {
						if(!value.equals("")) {
							preName = preName + value + "_";
						}
					} else if(name.equals("nameTF")) {
						if(!value.equals("")) {
							preName = preName + value + "_";
						}
					} else if(name.equals("userName")) {
						isInbox = true;
						userName = value;
					}
				} else {
					fileItem = item;
				}
			}
			// 获取文件名
			String fileName = fileItem.getName();
			System.out.println(fileName);
			if(fileName == null || fileName.trim().equals("")) {
				PrintWriter out = resp.getWriter();
				JSONObject json = new JSONObject();
				json.put("error", "文件名为空！");
				out.println(json);
		        out.close();
				return;
			}
			// 处理获取到的上传文件的文件名的路径部分，只保留文件名部分
			fileName = fileName.substring(fileName.lastIndexOf("/")+1);
			fileName = preName+fileName;
			// 添加UUID
			String uuidName = makeFileName(fileName);
			if(isInbox) {
				path = "inbox/"+path;
			}
			savePath = this.getServletContext().getRealPath("/WEB-INF/Drive/"+userName+"/"+path);
			
			File folder = new File(savePath);
			
			if(!folder.exists() || !folder.isDirectory()) {
				System.out.println(savePath+"目录不存在，需要创建");
				folder.mkdirs();
			}
			InputStream in = fileItem.getInputStream();
			FileOutputStream out = new FileOutputStream(savePath+"/"+uuidName);
			byte buffer[] = new byte[1024];
			int len = 0;
			while((len=in.read(buffer)) > 0) {
				out.write(buffer,0,len);
			}
			in.close();
			out.close();
			long fileSize = fileItem.getSize();
			fileItem.delete();
			System.out.println("文件上传成功!");
			System.out.println("文件大小："+fileSize);
			String type = Type.getType(fileName);
			
			String updateTime = new CurrentTime().getDateString();
			FileMessage fileMessage = new FileMessage(fileName, uuidName, updateTime, type, path, userName, fileSize);
			
			FileDaoImpl fileDaoImpl = new FileDaoImpl();
			fileDaoImpl.insert(fileMessage);
			System.out.println("数据库操作成功");
		} catch(Exception e) {
			PrintWriter out = resp.getWriter();
			JSONObject json = new JSONObject();
			json.put("error", "上传失败！");
			out.println(json);
	        out.close();
			System.out.println("文件上传失败!");
			e.printStackTrace();
			return;
		}
		System.out.println("yes2");
		
		
		PrintWriter out = resp.getWriter();
		JSONObject json = new JSONObject();
		json.put("success", "上传成功！");
		out.println(json);
        out.close();
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
