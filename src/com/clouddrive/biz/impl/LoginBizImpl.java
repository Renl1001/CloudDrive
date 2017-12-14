package com.clouddrive.biz.impl;

import com.clouddrive.biz.LoginBiz;
import com.clouddrive.dao.impl.UserDaoImpl;
import com.clouddrive.entity.User;

public class LoginBizImpl implements LoginBiz {
	private UserDaoImpl userDao = new UserDaoImpl();

	@Override
	public User login(String userName, String pwd) {
		User user = userDao.findUserByName(userName);
		System.out.println(user.getPwd());
		System.out.println(pwd);
		if (user != null && user.getPwd().equals(pwd)) {
			return user;
		}
		return null;
	}

}
