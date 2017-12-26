package com.clouddrive.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.clouddrive.dao.BaseDao;
import com.clouddrive.dao.RSProcessor;
import com.clouddrive.dao.ShareDao;
import com.clouddrive.entity.Share;

public class ShareImpl extends BaseDao implements ShareDao {

	@Override
	public int countShareByKey(String key) {
		String sql = "select count(*) as share_count from share where key=?";
		Object[] params = { key };

		RSProcessor countUserByNameProcessor = new RSProcessor() {

			public Object process(ResultSet rs) throws SQLException {
				int count = 0;
				if (rs != null) {
					if (rs.next()) {
						count = rs.getInt("share_count");
					}
				}

				return new Integer(count);
			}

		};

		return (Integer) this.executeQuery(countUserByNameProcessor, sql, params);
	}

	@Override
	public Share findShareByKey(String key) {
		String sql = "select * from share where key = ?";
		Object[] params = { key };

		RSProcessor getUserByNameProcessor = new RSProcessor() {

			public Object process(ResultSet rs) throws SQLException {
				Share share = null;

				if (rs != null) {
					if (rs.next()) {
						String user = rs.getString("user");
						String fileName = rs.getString("fileName");
						String url = rs.getString("url");
						String shareTime = rs.getString("shareTime");
						String key = rs.getString("key");
						share = new Share(user, fileName, url, shareTime, key);
					}
				}

				return share;

			}
		};

		return (Share) this.executeQuery(getUserByNameProcessor, sql, params);
	}

	@Override
	public int insert(Share share) {
		String sql = "insert share (user, fileName, url, shareTime, key) values(?,?,?,?,?)";
		Object[] params = { share.getUser(), share.getFileName(), share.getUrl(), share.getShareTime(), share.getKey() };
		return this.executeUpdate(sql, params);
	}

}
