<?xml version="1.0"?>
<recipe>

    <instantiate from="root/src/app_package/TemplateActivity.java.ftl"
                 to="${escapeXmlAttribute(srcOut)}/${activityClass}.java" />
    <instantiate from="root/src/app_package/TemplatePresenter.java.ftl"
                 to="${escapeXmlAttribute(srcOut)}/${featureName}Presenter.java" />
    <instantiate from="root/src/app_package/TemplateMvpView.java.ftl"
                 to="${escapeXmlAttribute(srcOut)}/${featureName}MvpView.java" />
    <instantiate from="root/res/layout/activity_template.xml.ftl"
                 to="${escapeXmlAttribute(resOut)}/layout/${layoutName}.xml" />

    <#include "../common/recipe_manifest.xml.ftl" />

    <open file="${escapeXmlAttribute(srcOut)}/${activityClass}.java" />

</recipe>
