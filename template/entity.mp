@@@ metaprogram
@@@ extension java
/*
* Copyright (c) @@=$year=@@, Hangzhou Qindingtech Co.Ltd. All rights reserved.
* Qindingtech PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
*
*/
package com.qindingtech.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
* @@=$entityComment=@@
*/
@Entity
@Table(name="@@=$tableName=@@")
public class @@=$entityName=@@ extends BaseEntity implements Serializable{
@@> for attribute in $columnArray
@@> if(attribute.name=='deleted'||attribute.name=='version'||attribute.name=='updatedBy'||attribute.name=='updatedAt')
@@> next
@@> end
    /**
    * @@=attribute.comment=@@
    */
@@> if (!$entityName.end_with?('Arc') && (attribute.name == 'id')) || ($entityName.end_with?('Arc') and (attribute.name == 'arcId'))
    @Id
    @GeneratedValue(generator = "@@=$entityName.downcase=@@_uuid")
    @GenericGenerator(name = "@@=$entityName.downcase=@@_uuid", strategy = "uuid2")
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

@@> if $entityName.end_with?('Arc')
public static @@=$entityName=@@ map(@@=$entityName.sub('Arc','')=@@ entity){
        @@=$entityName=@@ @@=$entityName.uncapitalize=@@ = new @@=$entityName=@@();
@@> for attribute in $columnArray
@@> if attribute.name != "arcId"
        @@=$entityName.uncapitalize=@@.set@@=attribute.name.capitalizeFirst=@@(entity.get@@=attribute.name.capitalizeFirst=@@());
@@> end
@@> end
        return @@=$entityName.uncapitalize=@@;
    }
@@> end
}
