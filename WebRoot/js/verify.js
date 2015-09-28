/**
 * 
 * @authors Your Name (you@example.org)
 * @date    2014-10-29 14:17:52
 * @version $Id$
 */
 function selected(){
        $(".quota li").each(function(){
            $(this).click(function(){
                $(".quota li").removeClass("select");
                $(this).addClass("select");
            })
        })
    }
    //手机验证
    function phone(){
        var phone=$("#phone").val();
        var Reg= /^1[358][0-9]{9}$/;
        if(Reg.test(phone)){
             $(".error").hide();    
        }else{
             $(".error").show();
        }
    }
    //提交充值
    function agreeClick(){
        //弹窗位置
        $("#alert").css("height",window.screen.height);
        var marginTop=window.screen.height-$("#alertContent").height();
        $("#alertContent").css("margin-top",marginTop/3);
        check();//判断
    }
    //点击提交充值是检查
    function check(){
        var phone=$("#phone").val();
        if(phone==""){
            $("#alertContent .content").html("<p>请输入您要充值的手机号码</p>");
            $("#alertContent .btn").html("<a class='know' href='javascript:alertHide();'>知道了!</a>")
            $("#alert").show();
        }else{
            var Reg= /^1[358][0-9]{9}$/;
            if(Reg.test(phone)){
                 $(".error").hide();
                 money();    
            }else{
                 $(".error").show();
            }
        }
    }
    //充值金额选择判断
    function money(){
        if($(".quota li").hasClass("select")){
            $("#alertContent .content").html("<p>确认充值吗？</p>");
            $("#alertContent .btn").html("<a href='javascript:sure();'>确 认</a><a href='javascript:alertHide();'>取 消</a>");
            $("#alert").show();
        }else{
            $("#alertContent .content").html("<p>请选择充值数额</p>");
            $("#alertContent .btn").html("<a class='know' href='javascript:alertHide();'>知道了!</a>")
            $("#alert").show();
        }
    }
    //确认充值
    function sure(){
        window.location.href="successPay.html";
    }

    //弹窗消失
    function alertHide(){
        $("#alert").hide();
    }

