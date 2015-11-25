@@@ metaprogram
@@@ extension java
/*
* Copyright (c) @@=$year=@@, Hangzhou Qindingtech Co.Ltd. All rights reserved.
* Qindingtech PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
*
*/
package com.qindingtech.entity

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
* @@=$entityComment=@@
*/
@Entity
public class @@=$entityName=@@Vo implements Serializable{
@@> for attribute in $columnArray
    /**
    * @@=attribute.comment=@@
    */
@@> if attribute.name == 'id'
    @Id
@@> end
    @Column(name="@@=attribute.code=@@")
    private @@=attribute.type =@@ @@=attribute.name=@@;

    public @@=attribute.type=@@ get@@=attribute.name.capitalizeFirst=@@(){
        return this.@@=attribute.name=@@;
    }
    public void set@@=attribute.name.capitalizeFirst=@@(@@=attribute.type=@@ @@=attribute.name=@@){
        this.@@=attribute.name=@@ = @@=attribute.name=@@;
    }
@@> end

    public static @@=$entityName=@@Vo map(@@=$entityName=@@ entity){
        @@=$entityName=@@Vo @@=$entityName.uncapitalize=@@Vo = new @@=$entityName=@@Vo();
@@> for attribute in $columnArray
        @@=$entityName.uncapitalize=@@Vo.set@@=attribute.name.capitalizeFirst=@@(entity.get@@=attribute.name.capitalizeFirst=@@());
@@> end
        return @@=$entityName.uncapitalize=@@Vo;
    }

    public static List<@@=$entityName=@@Vo> map(List<@@=$entityName=@@> entities){
        List<@@=$entityName=@@Vo> list = new ArrayList<>();
        for(@@=$entityName=@@ entity:entities){
            list.add(map(entity));
        }
        return list;
    }

    public static @@=$entityName=@@ map(@@=$entityName=@@Vo vo){
            @@=$entityName=@@ @@=$entityName.uncapitalize=@@ = new @@=$entityName=@@();
@@> for attribute in $columnArray
            @@=$entityName.uncapitalize=@@.set@@=attribute.name.capitalizeFirst=@@(vo.get@@=attribute.name.capitalizeFirst=@@());
@@> end
            return @@=$entityName.uncapitalize=@@;
    }
}