<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>注册用户</title>
    <link href="http://cdn.bootcss.com/font-awesome/4.5.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="http://cdn.bootcss.com/bootstrap/2.3.1/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>
<%@ include file="../include/nav.jsp"%>
<!--header-bar end-->
<div class="container">
    <div class="box">
        <div class="box-header">
            <span class="title"><i class="fa fa-sign-in"></i> 注册账号</span>
        </div>

        <form action="" class="form-horizontal" id="regForm">
            <div class="control-group">
                <label class="control-label">账号</label>
                <div class="controls">
                    <input type="text" name="username">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">密码</label>
                <div class="controls">
                    <input type="password" name="password" id="password">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">重复密码</label>
                <div class="controls">
                    <input type="password" name="repassword">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">电子邮件</label>
                <div class="controls">
                    <input type="text" name="email">
                </div>
            </div>
            <!-- 验证码功能 -->
            <div class="control-group">
                <label class="control-label">验证码</label>
                <div class="controls">
                     <input type="text" name="code">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label"></label>
                <div>
                    <a href="javascript:;" id="changepic"><img src="/patchca.png" id="img" alt=""></a>
                </div>
            </div>

            <div class="form-actions">
                <!-- 把按钮type市值为button  取消默认的submit提交 <script>中才能使用你设置的验证规则
                  而使用submit 提交时form中的验证则可以忽视
                  -->
                <button type="button" id="btn" class="btn btn-primary">注册</button>
                <span id="regMsg" class="hide">注册成功，<span class="sec" id="regSec">3</span>秒后跳到登录页面</span>
                <a class="pull-right" href="/login.do">登录</a>
            </div>

        </form>



    </div>
    <!--box end-->
</div>
<!--container end-->
<script src="/static/js/jquery-1.11.3.min.js"></script>
<script src="/static/js/jquery.validate.min.js"></script>
<script>
   $(function(){
       $("#btn").click(function(){
           $("#regForm").submit();
       });

       $("#changepic").click(function(){
            $("#img").attr("src","/patchca.png?_="+new Date().getTime());
       });

       $("#regForm").validate({
           errorClass:'text-error',
           errorElement:'span',
           rules:{
               username:{
                   required:true,
                   minlength:3,
                   maxlength:10,
                   remote:"/validate/username.do"
               },
               password:{
                   required:true,
                   rangelength:[6,18]
               },
               repassword:{
                   required:true,
                   rangelength:[6,18],
                   equalTo:'#password'
               },
               email:{
                   required:true,
                   email:true,
                   remote:"/validate/email.do"
               },
               code:{
                   required:true,
                   remote:"/validate/patchca.do"
               }
           },
           messages:{
               username:{
                   required:"请输入账号",
                   minlength:"账号至少3个字符",
                   maxlength:"账号最多10个字符",
                   remote:"该账号已被占用"
               },
               password:{
                   required:"请输入密码",
                   rangelength:"密码长度6~18位"
               },
               repassword:{
                   required:"请输入确认密码",
                   rangelength:"确认密码长度6~18位",
                   equalTo:"两次密码不一致"
               },
               email:{
                   required:"请输入电子邮件",
                   email:"电子邮件格式错误",
                   remote:"该电子邮件已注册"
               },
               code:{
                   required:"请输入验证码",
                   remote:"验证码错误"
               }
           },
           <!-- 当验证都通过时执行submitHandler -->
           submitHandler:function(form){
               $.post("/reg.do", $(form).serialize())
                       .done(function(result){
                            if(result.state == "error"){
                                alert(result.message);
                            }else {
                                $("#regMsg").removeClass("hide");
                                var sec =3;
                                setInterval(function(){
                                    sec--;
                                    if(sec == 0){
                                        window.location.href="/login.do";
                                        return;
                                    }
                                    $("#regSec").text(sec);
                                 //   $("#regMsg.sec").text(sec);
                                },1000);
                            }
                       })
                       .fail(function(){
                          alert("服务器异常，请稍后再登录   ");
                       })
           }
       });

   });
</script>
</body>
</html>
