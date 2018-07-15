//以下为修改jQuery Validation插件兼容Bootstrap的方法，没有直接写在插件中是为了便于插件升级
        $.validator.setDefaults({
            highlight: function (element) {
                $(element).closest('.form-group').removeClass('has-success').addClass('has-error');
            },
            success: function (element) {
                element.closest('.form-group').removeClass('has-error').addClass('has-success');
            },
            errorElement: "span",
            errorPlacement: function (error, element) {
                if (element.is(":radio") || element.is(":checkbox")) {
                    error.appendTo(element.parent().parent().parent());
                } else {
                    error.appendTo(element.parent());
                }
            },
            errorClass: "help-block m-b-none",
            validClass: "help-block m-b-none"


        });

        function validateAddForm(){
            // validate signup form on keyup and submit
        	$.validator.addMethod("isSerialNumber",function(value,element){
            	str=value.split('');
            	if(!((str[0]>='A'&&str[0]<='Z') || (str[0]>='a'&&str[0]<='z')))
            		return false;
            	for(var i=1;i<str.length;i++){
            		if(!(str[i]>=0 && str[i]<=9))
            			return false;
            	}
            	return true;
            },"站点编号第一位为字母，其它为数字");
            
            $.validator.addMethod("isPhone",function(value,element){
            	if($("#addManagerTel").attr("readonly")==true) return true;
            	var length=value.length;
            	var mobile = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(17[0-9]{1}))+\d{8})$/;
            	return this.optional(element) || (length == 11 && mobile.test(value));
            },"请填写正确的手机号码");
            
            $.validator.addMethod("isTel",function(value,element){
            	var length=value.length;
            	var mobile = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(17[0-9]{1}))+\d{8})$/;
            	var tel = /(^(\d{3,4}-)?\d{6,8}$)|(^(\d{3,4}-)?\d{6,8}(-\d{1,5})?$)|(\d{11})/;
            	return this.optional(element) || ((length == 11 && mobile.test(value)))||(tel.test(value));
            },"请填写正确的手机号或固定电话");
            
            var icon = "<i class='fa fa-times-circle'></i> ";
        //sitemanage.jsp 的验证  好好看一下
          /*
           * ********************************
           */
            return $("#addForm").validate({
                rules: {
                	serialNumber:{
                        required: true,
                        minlength: 6,
                        isSerialNumber: true  //自定义规则
                    },
                    siteName: "required",
                    address: "required",
                    manager: "required",
                    managerTel: {
                        required: true,
                        isPhone: true
                    },
                    tel: {
                        required: true,
                        isTel: true
                    },
                    depth: {
                        required: true,
                        number: true
                    }
                },
                messages: {
                	serialNumber: {
                        required: icon + "请输入站点编号",
                        minlength: icon + "站点编号必须6个字符以上",
                        isSerialNumber: icon + "站点编号第一位为字母，其它为数字"
                    },
                    siteName: icon + "请输入站点名",
                    address:  icon + "请输入详细地址",
                    manager:  icon + "请输入负责人",
                    managerTel: {
                        required: icon + "请输入负责人电话",
                        isPhone: icon + "请填写正确的手机号码"
                    },
                    tel: {
                        required: icon + "请输入站点电话",
                        isPhone: icon + "请填写正确的手机号或固定电话"
                    },
                    depth: {
                        required: icon + "请输入池深",
                        number: icon + "请填写数字"
                    }
                }
            });
         }
        

        function validateEditForm(){
            // validate signup form on keyup and submit
        	$.validator.addMethod("isSerialNumber",function(value,element){
            	str=value.split('');
            	if(!((str[0]>='A'&&str[0]<='Z') || (str[0]>='a'&&str[0]<='z')))
            		return false;
            	for(var i=1;i<str.length;i++){
            		if(!(str[i]>=0 && str[i]<=9))
            			return false;
            	}
            	return true;
            },"站点编号第一位为字母，其它为数字");
        	
            $.validator.addMethod("isPhone",function(value,element){
            	if($("#addManagerTel").attr("readonly")==true) return true;
            	var length=value.length;
            	var mobile = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(17[0-9]{1}))+\d{8})$/;
            	return this.optional(element) || (length == 11 && mobile.test(value));
            },"请填写正确的手机号码");
            
            $.validator.addMethod("isTel",function(value,element){
            	var length=value.length;
            	var mobile = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(17[0-9]{1}))+\d{8})$/;
            	var tel = /(^(\d{3,4}-)?\d{6,8}$)|(^(\d{3,4}-)?\d{6,8}(-\d{1,5})?$)|(\d{11})/;
            	return this.optional(element) || ((length == 11 && mobile.test(value)))||(tel.test(value));
            },"请填写正确的手机号或固定电话");
            
            var icon = "<i class='fa fa-times-circle'></i> ";
            
            return $("#editForm").validate({
                rules: {
                	siteName: "required",
                    address: "required",
                    manager: "required",
                    managerTel: {
                        required: true,
                        isPhone: true
                    },
                    tel: {
                        required: true,
                        isTel: true
                    },
                    depth: {
                        required: true,
                        number: true
                    }
                },
                messages: {
                	siteName: icon + "请输入站点名",
                    address:  icon + "请输入详细地址",
                    manager:  icon + "请输入负责人",
                    managerTel: {
                        required: icon + "请输入负责人电话",
                        isPhone: icon + "请填写正确的手机号码"
                    },
                    tel: {
                        required: icon + "请输入站点电话",
                        isPhone: icon + "请填写正确的手机号或固定电话"
                    },
                    depth: {
                        required: icon + "请输入池深",
                        number: icon + "请填写数字"
                    }
                }
            });
         }
