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
            <div class="index_serachT">
                <#if columns??>
                <#list columns as col>
                <#if !col.primaryKey >
                <#if col_index < 4>
                <span class="index_serachSpan">${col.remark!}</span>
                <div class="layui-input-inline index_serachSelect">
                    <input type="" name="${col.propertyName}" lay-verify="" autocomplete="off" class="layui-input">
                </div>
                </#if>
                </#if>
                </#list>
                </#if>
                <br/>
                <span class="index_serachSpan" >创建时间</span>
                <div class="layui-input-inline" style="margin-top: -8px;">
                    <input type="text" name="create_start_time" id="cstdate" lay-verify="date" placeholder="yyyy-mm-dd" autocomplete="off" class="layui-input" onclick="layui.laydate({elem: this})" style="width: 143px;display: inline-block;"> --
                    <input type="text" name="create_end_time" id="cetdate" lay-verify="date" placeholder="yyyy-mm-dd" autocomplete="off" class="layui-input" onclick="layui.laydate({elem: this})" style="width: 143px;display: inline-block;">
                </div>

                <span class="index_serachSpan" style="margin-left: 10px;">修改时间</span>
                <div class="layui-input-inline" style="margin-top: -8px;">
                    <input type="text" name="update_start_time" id="ustdate" lay-verify="date" placeholder="yyyy-mm-dd" autocomplete="off" class="layui-input" onclick="layui.laydate({elem: this})" style="width: 143px;display: inline-block;"> --
                    <input type="text" name="update_end_time" id="uetdate" lay-verify="date" placeholder="yyyy-mm-dd" autocomplete="off" class="layui-input" onclick="layui.laydate({elem: this})" style="width: 143px;display: inline-block;">
                </div>

                <div class="layui-btn-group layui-input-inline index_serachBut">
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
        <script type="text/javascript" src="<%=path%>/static/js/fav/${entityName}/${entityName}Layui.js" ></script>
        <script type="text/javascript" src="<%=path%>/static/plugins/jquery/jquery.page.js" ></script>
        <script type="text/javascript" src="<%=path%>/static/js/common/layui.date.js" ></script>
        <script type="text/javascript" src="<%=path%>/static/js/fav/${entityName}/${entityName}Page.js" ></script>
    </body>
</html>