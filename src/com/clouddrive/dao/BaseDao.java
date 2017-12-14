package com.clouddrive.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public abstract class BaseDao {
	protected Connection conn;
	protected PreparedStatement pstmt;
	protected ResultSet rs;
	
	/**
	 * 获取数据库连接对象。
	 */
	public Connection getConnection() {
		Connection conn = null;// 数据连接对象
		// 获取连接并捕获异常
		try {
			Context initContext = new InitialContext();
			DataSource ds = (DataSource)initContext.lookup("java:/comp/env/jdbc/registration");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();// 异常处理
		}
		return conn;// 返回连接对象
	}
	/**
	 * 关闭数据库连接。
	 * @param conn 数据库连接
	 * @param stmt Statement对象
	 * @param rs 结果集
	 */
	public void closeAll(Connection conn, Statement stmt, ResultSet rs) {
		// 若结果集对象不为空，则关闭
		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		// 若Statement对象不为空，则关闭
		if (stmt != null) {
			try {
				stmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		// 若数据库连接对象不为空，则关闭
		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public void closeAll() {
		closeAll(this.conn, this.pstmt, this.rs);
	}
	
	/**
	 * 增、删、改、作
	 * @param sql sql语句
	 * @param params 参数数组
	 * @return 执行结果
	 */
	public int exceuteUpdate(String sql, Object...params){
		int result = 0;
		conn = this.getConnection();
		try {
			if(conn != null && conn.isClosed() == false) {
				pstmt = conn.prepareStatement(sql);
				for(int i = 0;i < params.length;i++){
					pstmt.setObject(i + 1, params[i]);	
				}
				result = pstmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeAll();
		}
		
		return result;
	}
	
	public Object executeQuery(RSProcessor processor, String sql, Object...params) {
		Object result = null;
		conn = this.getConnection();
		try {
			if(conn != null && conn.isClosed() == false) {
				pstmt = conn.prepareStatement(sql);
				for(int i = 0;i < params.length;i++){
					pstmt.setObject(i + 1, params[i]);	
				}
				rs = pstmt.executeQuery();
				result = processor.process(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeAll();
		}
		return result;
	}
}
