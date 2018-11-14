package com.uerax.crud.service.impl;

import com.uerax.crud.domain.Department;
import com.uerax.crud.mapper.DepartmentMapper;
import com.uerax.crud.service.DepartmentService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author uerax
 * @date 2018/11/14 19:09
 */
@Service
public class DepartmentServiceImpl implements DepartmentService {

    @Resource
    private DepartmentMapper departmentMapper;

    @Override
    public List<Department> getDepartment() {
        return departmentMapper.selectByExample(null);
    }
}
