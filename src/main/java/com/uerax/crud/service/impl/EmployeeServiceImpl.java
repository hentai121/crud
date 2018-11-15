package com.uerax.crud.service.impl;

import com.uerax.crud.domain.Employee;
import com.uerax.crud.domain.EmployeeExample;
import com.uerax.crud.mapper.EmployeeMapper;
import com.uerax.crud.service.EmployeeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author uerax
 * @date 2018/11/13 14:40
 */
@Service
public class EmployeeServiceImpl implements EmployeeService {

    @Resource
    private EmployeeMapper employeeMapper;

    @Override
    public List<Employee> getEmployeeWithDept() {
        EmployeeExample ee = new EmployeeExample();
        ee.setOrderByClause("emp_id");
        return employeeMapper.selectByExampleWithDept(ee);
    }

    @Override
    public void saveEmployee(Employee emp) {
        employeeMapper.insertSelective(emp);
    }

    @Override
    public Employee getEmployeeById(Integer id) {
        return employeeMapper.selectByPrimaryKey(id);
    }

    @Override
    public void updateEmployee(Employee emp) {
        employeeMapper.updateByPrimaryKeySelective(emp);
    }
}
