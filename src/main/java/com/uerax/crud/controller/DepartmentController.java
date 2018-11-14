package com.uerax.crud.controller;

import com.uerax.crud.domain.Department;
import com.uerax.crud.service.DepartmentService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author uerax
 * @date 2018/11/14 19:07
 */
@Controller
public class DepartmentController {

    @Resource
    private DepartmentService departmentService;

    @RequestMapping("/getDept")
    public @ResponseBody List<Department> getDept() {

        List<Department> list = departmentService.getDepartment();
        return list;
    }

}
