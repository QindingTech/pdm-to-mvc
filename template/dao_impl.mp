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
    public @@=$groupName.capitalizeFirst=@@ save@@=$groupName.capitalizeFirst=@@(@@=$groupName.capitalizeFirst=@@ @@=$groupName.uncapitalize=@@,String handler){
        @@=$groupName.uncapitalize=@@.setVersion(1L);
        @@=$groupName.uncapitalize=@@.setDeleted(0L);
        @@=$groupName.uncapitalize=@@.setUpdatedBy(handler);
        @@=$groupName.uncapitalize=@@.setUpdatedAt(new Date());
        this.saveEntity(@@=$groupName.uncapitalize=@@);
        this.saveArc(@@=$groupName.uncapitalize=@@);
        return @@=$groupName.uncapitalize=@@;
    }

    @Override
    public @@=$groupName.capitalizeFirst=@@ update@@=$groupName.capitalizeFirst=@@(@@=$groupName.capitalizeFirst=@@ @@=$groupName.uncapitalize=@@,String handler){
        @@=$groupName.uncapitalize=@@.setVersion(@@=$groupName.uncapitalize=@@.getVersion()+1L);
        @@=$groupName.uncapitalize=@@.setDeleted(0L);
        @@=$groupName.uncapitalize=@@.setUpdatedBy(handler);
        @@=$groupName.uncapitalize=@@.setUpdatedAt(new Date());
        this.updateEntity(@@=$groupName.uncapitalize=@@);
        this.saveArc(@@=$groupName.uncapitalize=@@);
        return @@=$groupName.uncapitalize=@@;
    }

    @Override
    public @@=$groupName.capitalizeFirst=@@ saveOrUpdate@@=$groupName.capitalizeFirst=@@(@@=$groupName.capitalizeFirst=@@ @@=$groupName.uncapitalize=@@,String handler){
            if(@@=$groupName.uncapitalize=@@.getId()==null||@@=$groupName.uncapitalize=@@.getId().trim().isEmpty()){
                //new
                return this.save@@=$groupName.capitalizeFirst=@@(@@=$groupName.uncapitalize=@@,handler);
            }else{
                //update
                return this.update@@=$groupName.capitalizeFirst=@@(@@=$groupName.uncapitalize=@@,handler);
            }
        }

    /**
     * change deleted flag to 1.
     */
    @Override
    public void delete@@=$groupName.capitalizeFirst=@@(@@=$groupName.capitalizeFirst=@@ @@=$groupName.uncapitalize=@@,String handler){
        @@=$groupName.uncapitalize=@@.setDeleted(1L);
        @@=$groupName.uncapitalize=@@.setVersion(@@=$groupName.uncapitalize=@@.getVersion()+1L);
        @@=$groupName.uncapitalize=@@.setUpdatedBy(handler);
        @@=$groupName.uncapitalize=@@.setUpdatedAt(new Date());
        this.updateEntity(@@=$groupName.uncapitalize=@@);
        this.saveArc(@@=$groupName.uncapitalize=@@);
    }

    /**
     * change deleted flag to 1.
     */
    @Override
    public boolean delete@@=$groupName.capitalizeFirst=@@(String id, String handler) {
            if(id==null||id.trim().isEmpty()){
                @@=$groupName.capitalizeFirst=@@ @@=$groupName.uncapitalize=@@ =getEntityById(@@=$groupName.capitalizeFirst=@@.class,id);
                if(@@=$groupName.uncapitalize=@@!=null){
                    delete@@=$groupName.capitalizeFirst=@@(@@=$groupName.uncapitalize=@@,handler);
                    return true;
                }
            }return false;
    }

    protected void saveArc(@@=$groupName.capitalizeFirst=@@ @@=$groupName.uncapitalize=@@){
        @@=$groupName.capitalizeFirst=@@Arc @@=$groupName.uncapitalize=@@Arc = @@=$groupName.capitalizeFirst=@@Arc.map(@@=$groupName.uncapitalize=@@);
        this.saveEntity(@@=$groupName.uncapitalize=@@Arc);
    }
}
