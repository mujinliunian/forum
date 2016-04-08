package com.kaishengit.web.user;

import com.kaishengit.entity.User;
import com.kaishengit.service.UserService;
import com.kaishengit.web.BaseServlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/validate/email.do")
public class ValidateEmaileServlet extends BaseServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       //解决GET请求时的中文乱码
        String email = req.getParameter("email");
        email = new String(email.getBytes("ISO8859-1"),"UTF-8");

        UserService userService = new UserService();
        User user = userService.findByEmail(email);

        String result;
        if(user == null){
            result="true";
        }else {
            result = "false";
        }

        rendText(resp,result);
    }
}
