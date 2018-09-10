package ${basePackage}.${moduleName};

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import redis.clients.jedis.Jedis;
import ${basePackage}.controller.sys.BaseController;
import ${basePackage}.utils.*;
import ${basePackage}.${entityPackage}.${entityCamelName};
import ${basePackage}.${servicePackage}.${entityCamelName}Service;
import ${basePackage}.utils.DateUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * ${remark!}
 */
@Controller
@RequestMapping(value = "/${entityName}")
public class ${entityCamelName}Controller extends BaseController{

    private static  Logger logger= LoggerFactory.getLogger(${entityCamelName}Controller.class);
    private String logType = "99";

    @Autowired
    private ${entityCamelName}Service ${entityName}Service;

    /**
    * 跳转到列表页面
    */
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list(Model model) {
        Jedis jedis = RedisUtil.getJedis();
        Map<String, String> statusMap = jedis.hgetAll("dict:status");
        model.addAttribute("statusMap", statusMap);
        jedis.close();
        return "fav/${entityName}/list${entityCamelName}";
    }

    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String add(Model model, String id){
        if (id != null) {
            ${entityCamelName} item = ${entityName}Service.selectById(id);
            model.addAttribute("item", item);
        }
        Jedis jedis = RedisUtil.getJedis();
        Map<String, String> statusMap = jedis.hgetAll("dict:status");
        model.addAttribute("statusMap", statusMap);
        jedis.close();
        return "fav/${entityName}/add${entityCamelName}";
    }

    @RequestMapping(value = "/view", method = RequestMethod.GET)
    public String view(Model model, String id){
        if (id != null) {
            ${entityCamelName} item = ${entityName}Service.selectById(id);
            Jedis jedis = RedisUtil.getJedis();
            Map<String, String> statusMap = jedis.hgetAll("dict:status");
            model.addAttribute("statusMap", statusMap);
            jedis.close();
            model.addAttribute("item", item);
        }
        return "fav/${entityName}/view${entityCamelName}";
    }

    @RequestMapping(value = "/addAjax", method = RequestMethod.POST)
    @ResponseBody
    public ResultEntity addAjax(HttpServletRequest request, ${entityCamelName} item) {
        ResultEntity res = new ResultEntity(ErrorCodeType.P_FAILURE, "失败", null);
        try {
            ${entityCamelName} entity = ${entityName}Service.selectById(item.getId());
            List<${entityCamelName}> ${entityName}List = ${entityName}Service.selectList(
                new EntityWrapper<${entityCamelName}>().eq("${entityName}_name", item.get${entityCamelName}Name()));
            if (entity == null) {
                item.setCreateTime(DateUtil.getToday("yyyy-MM-dd HH:mm:ss"));
                item.setCreateUser(getLoginUser(request).getUserName());
            }else{
                if(${entityName}List.size() > 0){
                    if(${entityName}List.get(0).getId() != item.getId()){
                        res.setMessage("名称已存在！");
                        return res;
                    }
                }
            }
            item.setUpdateUser(getLoginUser(request).getUserName());
            item.setUpdateTime(DateUtil.getToday("yyyy-MM-dd HH:mm:ss"));
            boolean result = ${entityName}Service.insertOrUpdate(item);
            if (result) {
                res.setErrorcode(ErrorCodeType.SUCCESS);
                res.setMessage("成功!");
                if (entity == null) {
                    logger(request,logType,item.get${entityCamelName}Name(),"新增成功");
                }else{
                    logger(request,logType,item.get${entityCamelName}Name(),"修改成功");
                }
            }else{
                if (entity == null) {
                    logger(request,logType,item.get${entityCamelName}Name(),"新增失败");
                }else{
                    logger(request,logType,item.get${entityCamelName}Name(),"修改失败");
                }
            }
        }catch (Exception e){
            logger(request,logType,item.get${entityCamelName}Name(),"新增或修改异常");
            e.printStackTrace();
            logger.error("${entityCamelName}Controller[addAjax]===="+e.toString());
        }
        return res;
    }

    @RequestMapping(value = "/queryPageList",method = RequestMethod.POST)
    @ResponseBody
    public ResultEntity queryPageList(Integer pageIndex, Integer rows,
    <#if columns??>
    <#list columns as col>
    <#if !col.primaryKey >
    <#if col_index < 4>
    String ${col.propertyName},
    </#if>
    </#if>
    </#list>
    </#if>
    String create_start_time, String create_end_time, String update_start_time, String update_end_time) {
        ResultEntity res = new ResultEntity(ErrorCodeType.P_FAILURE, "查询失败!", null);
        try {
            EntityWrapper<${entityCamelName}> entityWrapper = new EntityWrapper<>();
            <#if columns??>
            <#list columns as col>
            <#if !col.primaryKey >
            <#if col_index < 4>
            if(${col.propertyName} != null){
                entityWrapper.eq(StringUtil.upperCharToUnderLine("${col.propertyName}"),${col.propertyName});
            }
            </#if>
            </#if>
            </#list>
            </#if>
            if (create_start_time != null) {
                create_start_time = create_start_time + " 00:00:00";
                entityWrapper.ge("create_time",create_start_time);
            }
            if (update_start_time != null) {
                update_start_time = update_start_time + " 00:00:00";
                entityWrapper.ge("update_time",update_start_time);
            }
            if (create_end_time != null) {
                create_end_time = create_end_time + " 23:59:59";
                entityWrapper.le("create_time",create_end_time);
            }
            if (update_end_time != null) {
                update_end_time = update_end_time + " 23:59:59";
                entityWrapper.le("update_time",update_end_time);
            }
            if (rows == null) {
                rows = 10;
            }
            if (pageIndex == null) {
                pageIndex = 1;
            }
            Page<${entityCamelName}> page = new Page<>(pageIndex, rows);
            Page<${entityCamelName}> pageList = ${entityName}Service.selectPage(page,
            entityWrapper.orderBy("update_time",false));
            List<${entityCamelName}> list = pageList.getRecords();
            if (list != null) {
                res.setErrorcode(ErrorCodeType.SUCCESS);
                res.setMessage("查询成功!");
                res.setData(list);
            }
        }catch (Exception e){
            e.printStackTrace();
            logger.error("${entityCamelName}Controller[queryPageList]===="+e.toString());
        }
        return res;
    }

    @RequestMapping(value = "/queryByCount",method = RequestMethod.POST)
    @ResponseBody
    public ResultEntity queryByCount(
    <#if columns??>
    <#list columns as col>
    <#if !col.primaryKey >
    <#if col_index < 4>
    String ${col.propertyName},
    </#if>
    </#if>
    </#list>
    </#if>
    String create_start_time, String create_end_time, String update_start_time, String update_end_time){
        ResultEntity res = new ResultEntity(ErrorCodeType.SUCCESS,"查询失败!",null);
        try {
            EntityWrapper<${entityCamelName}> entityWrapper = new EntityWrapper<>();
            <#if columns??>
            <#list columns as col>
            <#if !col.primaryKey >
            <#if col_index < 4>
            if(${col.propertyName} != null){
                entityWrapper.eq(StringUtil.upperCharToUnderLine("${col.propertyName}"),${col.propertyName});
            }
            </#if>
            </#if>
            </#list>
            </#if>
            if (create_start_time != null) {
                create_start_time = create_start_time + " 00:00:00";
                entityWrapper.ge("create_time",create_start_time);
            }
            if (update_start_time != null) {
                update_start_time = update_start_time + " 00:00:00";
                entityWrapper.ge("update_time",update_start_time);
            }
            if (create_end_time != null) {
                create_end_time = create_end_time + " 23:59:59";
                entityWrapper.le("create_time",create_end_time);
            }
            if (update_end_time != null) {
                update_end_time = update_end_time + " 23:59:59";
                entityWrapper.le("update_time",update_end_time);
            }
            long count = ${entityName}Service.selectCount(entityWrapper);
            if (count >= 0) {
                res.setErrorcode(ErrorCodeType.SUCCESS);
                res.setMessage("查询成功!");
                res.setData(count);
            }
        }catch (Exception e){
            e.printStackTrace();
            logger.error("${entityCamelName}Controller[queryByCount]===="+e.toString());
        }
        return res;
    }

    @RequestMapping(value = "/batchDelete",method = RequestMethod.POST,produces = "application/json;charest=UTF-8")
    @ResponseBody
    public ResultEntity batchDelete(HttpServletRequest request,@RequestParam("id[]") List<String> idList){
        ResultEntity res = new ResultEntity(ErrorCodeType.P_FAILURE, "失败", null);
        try {
            boolean bool = ${entityName}Service.deleteBatchIds(idList);
            if (bool) {
                res.setErrorcode(ErrorCodeType.SUCCESS);
                res.setMessage("成功!");
            }
        }catch (Exception e){
            e.printStackTrace();
            logger.error("${entityCamelName}Controller[batchDelete]===="+e.toString());
        }
        return res;
    }
}
