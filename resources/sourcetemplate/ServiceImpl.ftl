package ${basePackage}.${servicePackage}.${serviceImplPackage};

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import ${basePackage}.${entityPackage}.${entityCamelName};
import ${basePackage}.${servicePackage}.${entityCamelName}Service;
import ${basePackage}.${daoPackage}.${entityCamelName}Mapper;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * ${remark!}操作相关
 */
public class ${entityCamelName}ServiceImpl extends ServiceImpl<${entityCamelName}Mapper, ${entityCamelName}> implements ${entityCamelName}Service {

	@Autowired
	private ${entityCamelName}Mapper ${entityName}Mapper;

}
