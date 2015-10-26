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
    public void save@@=$groupName.capitalizeFirst=@@(@@=$groupName.capitalizeFirst=@@ @@=$groupName.uncapitalize=@@,String siteId,String handler){
        @@=$groupName.uncapitalize=@@.setVersion(1L);
        @@=$groupName.uncapitalize=@@.setDeleted(0L);
        @@=$groupName.uncapitalize=@@.setSiteId(siteId);
        @@=$groupName.uncapitalize=@@.setUpdatedBy(handler);
        @@=$groupName.uncapitalize=@@.setUpdatedAt(new Date());
        this.saveEntity(@@=$groupName.uncapitalize=@@);
        this.saveArc(@@=$groupName.uncapitalize=@@);
    }

    @Override
    public void update@@=$groupName.capitalizeFirst=@@(@@=$groupName.capitalizeFirst=@@ @@=$groupName.uncapitalize=@@,String siteId,String handler){
        @@=$groupName.uncapitalize=@@.setVersion(@@=$groupName.uncapitalize=@@.getVersion()+1L);
        @@=$groupName.uncapitalize=@@.setDeleted(0L);
        @@=$groupName.uncapitalize=@@.setSiteId(siteId);
        @@=$groupName.uncapitalize=@@.setUpdatedBy(handler);
        @@=$groupName.uncapitalize=@@.setUpdatedAt(new Date());
        this.updateEntity(@@=$groupName.uncapitalize=@@);
        this.saveArc(@@=$groupName.uncapitalize=@@);
    }

    @Override
    public void saveOrUpdate@@=$groupName.capitalizeFirst=@@(@@=$groupName.capitalizeFirst=@@ @@=$groupName.uncapitalize=@@,String siteId,String handler){
            if(@@=$groupName.uncapitalize=@@.getId()==null||@@=$groupName.uncapitalize=@@.getId().trim().isEmpty()){
                //new
                this.save@@=$groupName.capitalizeFirst=@@(@@=$groupName.uncapitalize=@@,siteId,handler);
            }else{
                //update
                this.update@@=$groupName.capitalizeFirst=@@(@@=$groupName.uncapitalize=@@,siteId,handler);
            }
        }

    /**
     * change deleted flag to 1.
     */
    @Override
    public void delete@@=$groupName.capitalizeFirst=@@(@@=$groupName.capitalizeFirst=@@ @@=$groupName.uncapitalize=@@,String siteId,String handler){
        @@=$groupName.uncapitalize=@@.setDeleted(1L);
        @@=$groupName.uncapitalize=@@.setVersion(@@=$groupName.uncapitalize=@@.getVersion()+1L);
        @@=$groupName.uncapitalize=@@.setSiteId(siteId);
        @@=$groupName.uncapitalize=@@.setUpdatedBy(handler);
        @@=$groupName.uncapitalize=@@.setUpdatedAt(new Date());
        this.updateEntity(@@=$groupName.uncapitalize=@@);
        this.saveArc(@@=$groupName.uncapitalize=@@);
    }

    protected void saveArc(@@=$groupName.capitalizeFirst=@@ @@=$groupName.uncapitalize=@@){
        @@=$groupName.capitalizeFirst=@@Arc @@=$groupName.uncapitalize=@@Arc = @@=$groupName.capitalizeFirst=@@Arc.map(@@=$groupName.uncapitalize=@@);
        this.saveEntity(@@=$groupName.uncapitalize=@@Arc);
    }
}
