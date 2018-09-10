<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="${basePackage}.${daoPackage}.${entityCamelName}Mapper" >
    <resultMap id="BaseResultMap" type="${basePackage}.${entityPackage}.${entityCamelName}" >
        <id column="${primaryKey}" property="${primaryProperty}" jdbcType="${primaryKeyType}" />
        <#list columns as col>
        <#assign jdbcType=col.columnType?replace(" UNSIGNED","")>
        <#if jdbcType=="INT">
        <#assign jdbcType="INTEGER">
        <#elseif jdbcType=="DATE">
        <#assign jdbcType="TIMESTAMP"></#if>
        <#if !col.primaryKey>
        <result column="${col.columnName}" property="${col.propertyName}" jdbcType="${jdbcType}" />
        </#if>
        </#list>
    </resultMap>

    <sql id="Base_Column_List" >
        <#list columns as col>${col.columnName}<#if col_index lt columns?size-1>,</#if></#list>
    </sql>

</mapper>