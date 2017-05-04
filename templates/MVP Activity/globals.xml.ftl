<?xml version="1.0"?>
<globals>

    <#include "../common/common_globals.xml.ftl" />

    <global id="featureName" value="${classToResource(activityClass)?cap_first}"/>
    <global id="baseFragment" value="<#if packageName??>${packageName}.ui.base.BaseFragment<#else>REMOVE THIS LINE</#if>"/>
</globals>
