package com.kaishengit.service;

import com.kaishengit.dao.UserDao;
import com.kaishengit.entity.User;
import com.kaishengit.exception.ServiceException;
import com.kaishengit.util.ConfigProp;
import org.apache.commons.codec.digest.DigestUtils;
import org.joda.time.DateTime;

public class UserService {

    private UserDao userDao= new UserDao();
    /**
     * 添加新用户注册
     * @param username
     * @param password
     * @param email
     */
    public void saveNewUser(String username, String password, String email) {
        //再次验证用户和邮箱 防止通过检查后 在同一时间有人使用了同样的帐号和邮箱
         if(findByUserName(username) != null){
             //通过抛出运行时异常来阻止下面程序运行
             throw new ServiceException("注册失败，帐号已被占用");
         }
        if(findByEmail(email) != null ){
            throw new ServiceException("注册失败，此邮箱已被使用");
        }
        User user = new User();
        user.setUsername(username);
        user.setPassword(DigestUtils.md5Hex(password+ConfigProp.get("user.password.salt")));
        user.setEmail(email);
        user.setCreatetime(DateTime.now().toString("yyyy-MM-dd HH:mm:ss"));
        user.setAvatar(ConfigProp.get("user.default.avata"));
        user.setState(User.USER_STATE_NOMAL);

        userDao.sava(user);
    }

    public User findByUserName(String username) {
       return  userDao.findByUserName(username);
    }

    public User findByEmail(String email) {
        return userDao.finByEmail(email);
    }
}
