<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/tag.jsp"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>查看详情</title>
        <meta name="renderer" content="webkit">
        <%@include file="../../common/header.jsp"%>
    </head>
    <body>
        <section class="my-container">
            <div class="layui-tab-content">
                <div class="layui-tab-item layui-show">
                    <table class="layui-table" lay-even="" lay-skin="">
                        <colgroup>
                            <col width="100">
                            <col width="120">
                            <col width="100">
                            <col width="120">
                        </colgroup>
                        <tbody>
                            <tr>
                            <#if columns??>
                            <#list columns as col>
                            <#if !col.primaryKey >
                                <td class="td_colo">${col.remark!}</td>
                                <td>${'$'}{item.${col.propertyName}}</td>
                                <#if col_index % 2 == 0>
                            </tr>
                            <tr>
                                </#if>
                            </#if>
                            </#list>
                            </#if>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>
        <%@include file="../../common/footer.jsp"%>
    </body>
</html>