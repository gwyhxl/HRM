package com.gwy.dao;


import com.gwy.model.Admin;

/**
 * Created by destiny on 2018/7/18/0018.
 */
public interface AdminMapper {

    Admin getAdminByNamePass(Admin admin);
}
