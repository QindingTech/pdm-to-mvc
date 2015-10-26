@@@ metaprogram
@@@ extension java
/*
* Copyright (c) @@=$year=@@, Hangzhou Qindingtech Co.Ltd. All rights reserved.
* Qindingtech PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
*
*/
package com.qindingtech.amp.core.dao;

import com.qindingtech.amp.entity.*;

import java.util.List;
import java.util.Map;
import java.util.Date;

/**
*
*/
public interface @@=$groupName=@@Dao {

    void save@@=$groupName.capitalizeFirst=@@(@@=$groupName.capitalizeFirst=@@ @@=$groupName.uncapitalize=@@,String siteId,String handler);
    void update@@=$groupName.capitalizeFirst=@@(@@=$groupName.capitalizeFirst=@@ @@=$groupName.uncapitalize=@@,String siteId,String handler);
    void saveOrUpdate@@=$groupName.capitalizeFirst=@@(@@=$groupName.capitalizeFirst=@@ @@=$groupName.uncapitalize=@@,String siteId,String handler);
    void delete@@=$groupName.capitalizeFirst=@@(@@=$groupName.capitalizeFirst=@@ @@=$groupName.uncapitalize=@@,String siteId,String handler);
}
