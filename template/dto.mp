@@@ metaprogram
@@@ extension java
/*
* Copyright (c) @@=$year=@@, Hangzhou Qindingtech Co.Ltd. All rights reserved.
* Qindingtech PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
*
*/
package com.qindingtech.amp.dto;

import com.qindingtech.amp.common.CoreMessageCode;
import com.qindingtech.amp.entity.*;
import com.qindingtech.amp.dto.BaseDto;
import com.qindingtech.amp.data.MessageInfo;
import com.qindingtech.amp.tools.CommonUtility;
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

    public static @@=$entityName=@@Dto entity2dto(@@=$entityName=@@ entity){
        if (entity==null) return null;
        @@=$entityName=@@Dto @@=$entityName.uncapitalize=@@Dto = new @@=$entityName=@@Dto();
@@> for attribute in $columnArray
        @@=$entityName.uncapitalize=@@Dto.set@@=attribute.name.capitalizeFirst=@@(entity.get@@=attribute.name.capitalizeFirst=@@());
@@> end
        return @@=$entityName.uncapitalize=@@Dto;
    }

    public static List<@@=$entityName=@@Dto> entity2dto(List<@@=$entityName=@@> entities){
        List<@@=$entityName=@@Dto> list = new ArrayList<>();
        if (CommonUtility.isEmpty(entities)) {
            return list;
        } else {
            for(@@=$entityName=@@ entity:entities){
            list.add(entity2dto(entity));
            }
        }
        return list;
    }

    public static @@=$entityName=@@ dto2entity(@@=$entityName=@@Dto dto){
            if(dto==null) return null;
            @@=$entityName=@@ @@=$entityName.uncapitalize=@@ = new @@=$entityName=@@();
@@> for attribute in $columnArray
            @@=$entityName.uncapitalize=@@.set@@=attribute.name.capitalizeFirst=@@(dto.get@@=attribute.name.capitalizeFirst=@@());
@@> end
            return @@=$entityName.uncapitalize=@@;
        }

    public static List<@@=$entityName=@@> dto2entity(List<@@=$entityName=@@Dto> dtos){
        List<@@=$entityName=@@> list = new ArrayList<>();
        if (CommonUtility.isEmpty(dtos)) {
                    return list;
        } else {
            for(@@=$entityName=@@Dto dto:dtos){
                list.add(dto2entity(dto));
            }
        }
        return list;
    }

    public static List<MessageInfo> checkValid(@@=$entityName=@@Dto dto) {
        List<MessageInfo> result = new ArrayList<>();
        if (dto == null) {
            result.add(new MessageInfo(CoreMessageCode.ERROR_INPUT_PARA_EMPTY));
            return result;
        }
        //TODO: Add customer check here
        return result;
    }
}