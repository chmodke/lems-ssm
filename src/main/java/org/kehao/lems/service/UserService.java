package org.kehao.lems.service;

import org.kehao.lems.entity.User;

/**
 * Created by kehao on 2017/4/20.
 */
public interface UserService {
    User getUserByUid(String uid);
    User getUserByName(String name);
}
