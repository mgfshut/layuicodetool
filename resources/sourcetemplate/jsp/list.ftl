<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../common/tag.jsp"%>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>${remark!}</title>
        <%@include file="../common/header.jsp"%>
        <script type="text/javascript">
            var path = "<%=path%>";
        </script>
    </head>
    <body>
        <form class="layui-form" action="" id="tableFrom">
            <div class="layui-form-item">
                <#if columns??>
                <#list columns as col>
                <#if !col.primaryKey >
                <#if col_index < 4>
                <div class="layui-inline">
                    <label class="layui-form-label">${col.remark!}</label>
                    <div class="layui-input-inline">
                        <input type="" name="${col.propertyName}" lay-verify="" autocomplete="off" class="layui-input">
                    </div>
                </div>
                </#if>
                </#if>
                </#list>
                </#if>
                <div class="btn-layui">
                    <a href="javascript:termQueryPage();" class="layui-btn layui-btn-small">查询</a>
                    <a href="javascript:resetFrom();" class="layui-btn layui-btn-small">清空</a>
                </div>
            </div>
        </form>

        <div class="container" style="width: 100%; padding: 0; margin: 0;">
            <table class="layui-table tree table-bordered table-hover" lay-even="" lay-skin="">
                <thead>
                    <tr>
                        <th colspan="9">
                            <div class="layui-btn-group" id="LAY_demo">
                                <a class="layui-btn layui-btn-small" data-method="notice">
                                    <i class="layui-icon">&#xe608;</i>添加
                                </a>
                                <a class="layui-btn layui-btn-small" data-method="notice2">
                                    <i class="layui-icon">&#xe642;</i>修改
                                </a>
                                <a class="layui-btn layui-btn-small" data-method="notice3">
                                    <i class="layui-icon">&#xe640;</i>删除
                                </a>
                            </div>
                        </th>
                    </tr>
                </thead>
                <tbody id="list">

                </tbody>
            </table>
            <div id="demo7"></div>
        </div>
        <%@include file="../common/footer.jsp"%>
        <script type="text/javascript" src="<%=path%>/static/js/ftd/${entityName}/${entityName}Layui.js" ></script>
        <script type="text/javascript" src="<%=path%>/static/plugins/jquery/jquery.page.js" ></script>
        <script type="text/javascript" src="<%=path%>/static/js/common/layui.date.js" ></script>
        <script type="text/javascript" src="<%=path%>/static/js/ftd/${entityName}/${entityName}Page.js" ></script>
    </body>
</html>