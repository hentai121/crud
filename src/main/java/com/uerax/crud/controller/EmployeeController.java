package com.uerax.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.uerax.crud.domain.Employee;
import com.uerax.crud.service.EmployeeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * @author uerax
 * @date 2018/11/13 0:36
 */
@Controller
public class EmployeeController {

    @Resource
    private EmployeeService employeeService;

    @ResponseBody
    @RequestMapping("/getList")
    public PageInfo getList(Model model, @RequestParam(defaultValue = "1") Integer page) {
        PageHelper.startPage(page, 5);
        List<Employee> list = employeeService.getEmployeeWithDept();
        PageInfo pageInfo = new PageInfo(list, 5);
        return pageInfo;
    }

    @RequestMapping("/list")
    public String list() {
        return "list";
    }

    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public String saveEmp(Employee employee) {
        employeeService.saveEmployee(employee);
        return "success";
    }

    @RequestMapping(value = "emp/{id}", method = RequestMethod.GET)
    public @ResponseBody
    Employee getEmp(@PathVariable("id") Integer id) {
        Employee emp = employeeService.getEmployeeById(id);
        return emp;
    }

    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    public @ResponseBody
    String updateEmp(Employee employee) {
        System.out.println(employee);
        employeeService.updateEmployee(employee);
        return "success";
    }

    @RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
    public @ResponseBody String delEmp(@PathVariable("ids") String ids) {
        List<Integer> list = new ArrayList<>();
        if (ids.contains("-")) {
            String[] str = ids.split("-");
            System.out.println(str);
            for (String id : str) {
                list.add(Integer.parseInt(id));
            }
            System.out.println(list);
            employeeService.deleteBatch(list);
        } else {
            employeeService.deleteEmployee(Integer.parseInt(ids));
        }
        return "delete success";
    }
}
