<?xml version="1.0"?>
<globals>
    <global id="projectOut" value="." />
    <global id="hasNoActionBar" type="boolean" value="true" />
    <#include "../common/common_globals.xml.ftl" />
    <global id="isLauncher" type="boolean" value="${isNewProject?string}" />
    <global id="featureName" value="${underscoreToCamelCase(classToResource(activityClass)?cap_first)}"/>
</globals>
