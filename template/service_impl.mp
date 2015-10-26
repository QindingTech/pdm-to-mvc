@@@ metaprogram
@@@ extension java
/*
* Copyright (c) @@=$year=@@, Hangzhou Qindingtech Co.Ltd. All rights reserved.
* Qindingtech PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
*
*/
package com.qindingtech.amp.core.service.impl;

import com.qindingtech.amp.core.dao.*;
import com.qindingtech.amp.core.service.*;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;
import java.util.Date;

/**
* service
*/
@Service("@@=$groupName.uncapitalize=@@Service")
public class @@=$groupName=@@ServiceImpl extends BaseServiceImpl implements @@=$groupName=@@Service{
    @Resource
    private @@=$groupName=@@Dao @@=$groupName.uncapitalize=@@Dao;
}
