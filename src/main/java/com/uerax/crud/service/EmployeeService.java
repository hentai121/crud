package com.uerax.crud.service;

import com.uerax.crud.domain.Employee;

import java.util.List;

/**
 * @author uerax
 * @date 2018/11/13 14:38
 */
public interface EmployeeService {

    public List<Employee> getEmployeeWithDept();
    public void saveEmployee(Employee emp);
}
