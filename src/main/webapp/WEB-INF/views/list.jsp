<%--
  Created by IntelliJ IDEA.
  User: uerax
  Date: 2018/11/13
  Time: 0:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
    <title>Title</title>
    <script src="${APP_PATH}/js/jquery-3.3.1.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" crossorigin="anonymous">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js" crossorigin="anonymous"></script>

</head>
<body>
<!-- 员工添加模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="form-horizontal">
                    <div class="form-group">
                        <label for="emp_name" class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="emp_name" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="emp_age" class="col-sm-2 control-label">员工年龄</label>
                        <div class="col-sm-10">
                            <input type="text" name="empAge" class="form-control" id="emp_age" placeholder="empAge">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">员工部门</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="deptId" id="dept_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_add_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<%--员工修改模态框--%>
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="update-form-horizontal">
                    <div class="form-group">
                        <label for="emp_name" class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="emp_update_name"
                                   placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="emp_age" class="col-sm-2 control-label">员工年龄</label>
                        <div class="col-sm-10">
                            <input type="text" name="empAge" class="form-control" id="emp_update_age"
                                   placeholder="empAge">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">员工部门</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="deptId" id="dept_update_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_save_btn">修改</button>
            </div>
        </div>
    </div>
</div>
<%--主要内容--%>
<div class="container">
    <div class="row">
        <div class="col-md-offset-4">
            <h1>人力资源管理系统</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-offset-8">
            <button class="btn btn-primary btn-sm" id="add_emp_btn">添加</button>
            <button class="btn btn-warning btn-sm" id="delete_checked_btn">删除</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emp_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>#</th>
                    <th>员工姓名</th>
                    <th>员工年龄</th>
                    <th>员工部门</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-offset-6" id="page_nav">

        </div>
    </div>
</div>
<%--ajax--%>
<script type="text/javascript">

    $(function () {
        to_page(1);
    });

    function to_page(page) {

        var totalPage;

        $.ajax({
            url: "${APP_PATH}/getList",
            data: "page=" + page,
            type: "get",
            success: function (result) {
                build_emps_table(result);
                build_page_nav(result);
            }
        });
    }

    function build_emps_table(result) {
        $("#emp_table tbody").empty();
        var emps = result.list;
        $.each(emps, function (index, item) {
            var checkTd = $("<td><input type='checkbox' class='check_id'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var empAgeTd = $("<td></td>").append(item.empAge);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm emp-update-btn").append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append(" 修改");
            editBtn.attr("update_emp_id", item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm emp-delete-btn").append($("<span></span>").addClass("glyphicon glyphicon-calendar")).append(" 删除");
            delBtn.attr("delete_emp_id", item.empId);
            var edit = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>").append(checkTd).append(empIdTd).append(empNameTd).append(empAgeTd).append(deptNameTd).append(edit).appendTo("#emp_table tbody");
        });
    }

    function build_page_nav(result) {
        totalPage = result.pages;
        $("#page_nav").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        firstPageLi.click(function () {
            to_page(1);
        });
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        prePageLi.click(function () {
            to_page(result.pageNum - 1);
        });

        if (result.hasPreviousPage == false) {
            prePageLi.addClass("disabled");
            firstPageLi.addClass("disabled");
        }
        var sufPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        sufPageLi.click(function () {
            to_page(result.pageNum + 1);
        });
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#")).attr("id", "emp_last_page");
        lastPageLi.click(function () {
            to_page(result.pages);
        });

        if (result.hasNextPage == false) {
            sufPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }
        ul.append(firstPageLi).append(prePageLi);
        $.each(result.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.pageNum == item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        })
        ul.append(sufPageLi).append(lastPageLi);
        var nav = $("<nav></nav>").append(ul);
        nav.appendTo("#page_nav");
    }

</script>
<%--模态栏ajax--%>
<script>
    // 添加员工按钮
    $("#add_emp_btn").click(function () {
        $("#form-horizontal input").val("");
        $("#dept_select").empty();
        getDept("#dept_select");

        $("#empAddModal").modal({
            backdrop: "static"
        });

    });

    function validate_add_form(ele_1, ele_2) {
        var empName = $(ele_1).val();
        var regName = /^[a-zA-Z0-9_-]{4,16}$/;
        show_vaild_msg(ele_1, regName.test(empName), "非法名字")
        var empAge = $(ele_2).val();
        var regAge = /^(?:[1-9]?\d|100)$/;
        show_vaild_msg(ele_2, regAge.test(empAge), "非法年龄")
        return true;
    }

    function show_vaild_msg(ele, status, msg) {
        // 清除当前元素
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if (status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text("");
            return false;
        } else if (!status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    // 添加员工模态栏保存按钮
    $("#emp_add_save_btn").click(function () {

        if (!validate_add_form("#emp_name", "#emp_age")) {
            return false;
        }

        $.ajax({
            url: "${APP_PATH}/emp",
            type: "POST",
            data: $("#form-horizontal").serialize(),
            success: function (result) {
                alert(result);
                $("#empAddModal").modal('hide');
                to_page(totalPage);
            }
        });
    });

    // 获取部门列表
    function getDept(ele) {

        $(ele).empty();

        $.ajax({
            url: "${APP_PATH}/getDept",
            type: "GET",
            success: function (result) {
                $.each(result, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele);
                });
            }

        });
    }

</script>
<%--修改用户--%>
<script>
    $(document).on("click", ".emp-update-btn", function () {

        $("#dept_update_select").empty();
        getDept("#dept_update_select");
        getEmp($(this).attr("update_emp_id"));
        $("#emp_update_save_btn").attr("update_emp_id", $(this).attr("update_emp_id"));
        $("#empUpdateModal").modal({
            backdrop: "static"
        });
    });

    function getEmp(id) {
        $.ajax({
            url: "${APP_PATH}/emp/" + id,
            type: "GET",
            success: function (result) {
                console.log(result);
                $("#emp_update_name").val(result.empName);
                $("#emp_update_age").val(result.empAge);
                $("#dept_update_select").val([result.deptId]);
            }
        });
    }

    $("#emp_update_save_btn").click(function () {

        if (!validate_add_form("#emp_update_name", "#emp_update_age")) {
            return false;
        }

        $.ajax({
            url: "${APP_PATH}/emp/" + $(this).attr("update_emp_id"),
            type: "PUT",
            data: $("#update-form-horizontal").serialize(),
            success: function (result) {
                alert(result);
                $("#empUpdateModal").modal('hide');
                to_page(1);
            }
        });

    });
</script>
<%--删除用户--%>
<script>

    $(document).on("click", ".emp-delete-btn", function () {
        if (confirm("是否删除？")) {
            $.ajax({
                url: "${APP_PATH}/emp/" + $(this).attr("delete_emp_id"),
                type: "DELETE",
                success: function (result) {
                    alert("succesee");
                    to_page(1);
                }
            });
        }
    });

</script>
<%--选择用户--%>
<script>


    $("#check_all").click(function () {


        $(".check_id").prop("checked", $(this).prop("checked"));

    });

    $("#delete_checked_btn").click(function () {

        var del_id_str = "";
        $.each($(".check_id:checked"), function () {
            del_id_str += $(this).parents("tr").find("td:eq(1)").text() + "-";
        })
        del_id_str = del_id_str.substring(0, del_id_str.length - 1);
        console.log(del_id_str);
        if (confirm("是否全部删除")) {
            $.ajax({
                url: "${APP_PATH}/emp/" + del_id_str,
                type: "DELETE",
                success: function (result) {
                    alert(result);
                    to_page(1);
                }
            });
        }
    });
</script>
</body>
</html>
