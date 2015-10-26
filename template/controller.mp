@@@ metaprogram
@@@ extension java
/*
* Copyright (c) @@=$year=@@, Hangzhou Qindingtech Co.Ltd. All rights reserved.
* Qindingtech PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
*/
package com.qindingtech.controller;

import com.qindingtech.data.DataTableResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
*
*/
@Controller
@Scope("request")
@RequestMapping("@@=$groupName.hyphen=@@")
public class @@=$groupName=@@Controller extends BaseController{
    @Resource
    private @@=$groupName=@@Service @@=$groupName.uncapitalize=@@Service;


    @RequestMapping(value = "list", method = {RequestMethod.GET})
    public String list(Model model){
        //ToDo
        return "@@=$groupName.hyphen=@@/list";
    }

    @ResponseBody
    @RequestMapping(value = "list-page", method = {RequestMethod.POST})
    public DataTableResponse<Object> infoPage(int draw, int start, int length){
        String searchText = request.getParameter("search[value]");
        //ToDo
        DataTableResponse<Object> result = null;
        result.setDraw(draw);
        return result;
    }

    @RequestMapping(value = "add", method = {RequestMethod.GET})
    public String add(Model model){
        //ToDo
        return "@@=$groupName.hyphen=@@/edit";
    }

    @RequestMapping(value = "edit/{id}", method = {RequestMethod.GET})
    public String edit(Model model){
        //ToDo
        return "@@=$groupName.hyphen=@@/edit";
    }

    @RequestMapping(value = "save", method = {RequestMethod.POST})
    public String save(){
        //ToDo
        return "redirect:/@@=$groupName.hyphen=@@/list";
    }
}