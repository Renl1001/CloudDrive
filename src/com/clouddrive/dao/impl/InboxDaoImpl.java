package com.clouddrive.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import com.clouddrive.dao.BaseDao;
import com.clouddrive.dao.InboxDao;
import com.clouddrive.dao.RSProcessor;
import com.clouddrive.entity.Inbox;

public class InboxDaoImpl extends BaseDao implements InboxDao {

	@Override
	public int countInboxByKey(String key) {
		String sql = "select count(*) as inbox_count from inbox where keyword=?";
		Object[] params = { key };

		RSProcessor countUserByNameProcessor = new RSProcessor() {

			public Object process(ResultSet rs) throws SQLException {
				int count = 0;
				if (rs != null) {
					if (rs.next()) {
						count = rs.getInt("inbox_count");
					}
				}

				return new Integer(count);
			}

		};

		return (Integer) this.executeQuery(countUserByNameProcessor, sql, params);
	}

	@Override
	public int countInboxByUuidName(String uuidName) {
		String sql = "select count(*) as inbox_count from inbox where uuidName=?";
		Object[] params = { uuidName };

		RSProcessor countUserByNameProcessor = new RSProcessor() {

			public Object process(ResultSet rs) throws SQLException {
				int count = 0;
				if (rs != null) {
					if (rs.next()) {
						count = rs.getInt("inbox_count");
					}
				}

				return new Integer(count);
			}

		};

		return (Integer) this.executeQuery(countUserByNameProcessor, sql, params);
	}

	@Override
	public Inbox findInboxByKey(String key) {
		String sql = "select * from inbox where keyword = ?";
		Object[] params = { key };

		RSProcessor getUserByNameProcessor = new RSProcessor() {

			public Object process(ResultSet rs) throws SQLException {
				Inbox inbox = null;

				if (rs != null) {
					if (rs.next()) {
						String user = rs.getString("user");
						String uuidName = rs.getString("uuidName");
						String illustrate = rs.getString("illustrate");
						String startTime = rs.getString("startTime");
						String endTime = rs.getString("endTime");
						String key = rs.getString("keyword");
						inbox = new Inbox(user, uuidName, illustrate, startTime, endTime, key);
					}
				}

				return inbox;

			}
		};

		return (Inbox) this.executeQuery(getUserByNameProcessor, sql, params);
	}

	@Override
	public Vector<Inbox> findInboxByUser(String name) {
		String sql = "select * from inbox where user = ? order by startTime desc";
		Object[] params = { name };

		RSProcessor getUsersByNameProcessor = new RSProcessor() {

			public Object process(ResultSet rs) throws SQLException {
				Vector<Inbox> inboxs = new Vector<Inbox>();

				while (rs.next()) {
					String user = rs.getString("user");
					String uuidName = rs.getString("uuidName");
					String illustrate = rs.getString("illustrate");
					String startTime = rs.getString("startTime");
					String endTime = rs.getString("endTime");
					String key = rs.getString("keyword");
					Inbox inbox = new Inbox(user, uuidName, illustrate, startTime, endTime, key);
					inboxs.add(inbox);
				}

				return inboxs;

			}
		};

		return (Vector<Inbox>) this.executeQuery(getUsersByNameProcessor, sql, params);
	}

	@Override
	public int insert(Inbox inbox) {
		String sql = "insert inbox (user, uuidName, illustrate, startTime, endTime, keyword) values(?,?,?,?,?,?)";
		Object[] params = { inbox.getUser(), inbox.getUuidName(), inbox.getIllustrate(), inbox.getStartTime(), inbox.getEndTime(), inbox.getKey() };
		return this.executeUpdate(sql, params);
	}

	@Override
	public int delInboxByKey(String key) {
		String sql = "delete from inbox\r\n" + 
				"where keyword = ?";
		Object[] params = { key };
		return this.executeUpdate(sql, params);
	}
}
