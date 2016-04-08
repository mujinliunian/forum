package com.kaishengit.dao;

import com.kaishengit.entity.User;
import com.kaishengit.util.DBHelp;
import org.apache.commons.dbutils.handlers.BeanHandler;

public class UserDao {
    public void sava(User user) {
        String sql = "insert  into t_user(username,password,email,avatar,createtime,state) value(?,?,?,?,?,?)";
        DBHelp.update(sql,user.getUsername(),user.getPassword(),user.getEmail(),user.getAvatar(),user.getCreatetime(),user.getState());
    }

    public User findByUserName(String username) {
        String sql = "select * from t_user where  username = ?";
        return DBHelp.query(sql,new BeanHandler<>(User.class),username);
    }

    public User finByEmail(String email) {
        String sql = "select * from t_user where email = ?";
        return DBHelp.query(sql,new BeanHandler<>(User.class),email);
    }
}
