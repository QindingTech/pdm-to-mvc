@@@ metaprogram
@@@ extension java
/*
* Copyright (c) @@=$year=@@, Hangzhou Qindingtech Co.Ltd. All rights reserved.
* Qindingtech PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
*
*/
package com.qindingtech.amp.dto;

import com.qindingtech.amp.entity.*;
import com.qindingtech.amp.dto.BaseDto;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.Date;

/**
* @@=$entityComment=@@
*/
public class @@=$entityName=@@Dto extends BaseDto implements Serializable{
@@> for attribute in $columnArray
    /**
    * @@=attribute.comment=@@
    */
    private @@=attribute.type =@@ @@=attribute.name=@@;

    public @@=attribute.type=@@ get@@=attribute.name.capitalizeFirst=@@(){
        return this.@@=attribute.name=@@;
    }
    public void set@@=attribute.name.capitalizeFirst=@@(@@=attribute.type=@@ @@=attribute.name=@@){
        this.@@=attribute.name=@@ = @@=attribute.name=@@;
    }

@@> end

    public static @@=$entityName=@@Dto map(@@=$entityName=@@ entity){
        @@=$entityName=@@Dto @@=$entityName.uncapitalize=@@Dto = new @@=$entityName=@@Dto();
@@> for attribute in $columnArray
        @@=$entityName.uncapitalize=@@Dto.set@@=attribute.name.capitalizeFirst=@@(entity.get@@=attribute.name.capitalizeFirst=@@());
@@> end
        return @@=$entityName.uncapitalize=@@Dto;
    }

    public static List<@@=$entityName=@@Dto> map(List<@@=$entityName=@@> entities){
        List<@@=$entityName=@@Dto> list = new ArrayList<>();
        for(@@=$entityName=@@ entity:entities){
            list.add(map(entity));
        }
        return list;
    }
}