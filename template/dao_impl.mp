@@@ metaprogram
@@@ extension java
/*
* Copyright (c) @@=$year=@@, Hangzhou Qindingtech Co.Ltd. All rights reserved.
* Qindingtech PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
*
*/
package com.qindingtech.amp.core.dao.impl;


import com.qindingtech.amp.entity.*;
import com.qindingtech.amp.core.dao.*;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
import java.util.Date;

/**
*
*/
@SuppressWarnings("JpaQlInspection")
@Repository("@@=$groupName.uncapitalize=@@Dao")
public class @@=$groupName=@@DaoImpl extends BaseDaoImpl implements @@=$groupName=@@Dao{

    @Override
    public void save@@=$groupName.capitalizeFirst=@@(@@=$groupName.capitalizeFirst=@@ @@=$groupName.uncapitalize=@@){
        this.saveEntity(@@=$groupName.uncapitalize=@@);
        this.saveArc(@@=$groupName.uncapitalize=@@);
    }

    @Override
    public void update@@=$groupName.capitalizeFirst=@@(@@=$groupName.capitalizeFirst=@@ @@=$groupName.uncapitalize=@@){
        this.updateEntity(@@=$groupName.uncapitalize=@@);
        this.saveArc(@@=$groupName.uncapitalize=@@);
    }
    /**
     * change deleted flag to 1.
     */
    @Override
    public void delete@@=$groupName.capitalizeFirst=@@(@@=$groupName.capitalizeFirst=@@ @@=$groupName.uncapitalize=@@){
        @@=$groupName.uncapitalize=@@.setDeleted(1L);
        this.updateEntity(@@=$groupName.uncapitalize=@@);
        this.saveArc(@@=$groupName.uncapitalize=@@);
    }

    protected void saveArc(@@=$groupName.capitalizeFirst=@@ @@=$groupName.uncapitalize=@@){
        @@=$groupName.capitalizeFirst=@@Arc @@=$groupName.uncapitalize=@@Arc = @@=$groupName.capitalizeFirst=@@Arc.map(@@=$groupName.uncapitalize=@@);
        this.saveEntity(@@=$groupName.uncapitalize=@@Arc);
    }
}
