<?xml version="1.0"?>
<recipe>

    <instantiate from="root/src/app_package/TemplateFragment.java.ftl"
                 to="${escapeXmlAttribute(srcOut)}/${className}.java" />
    <instantiate from="root/src/app_package/TemplatePresenter.java.ftl"
                 to="${escapeXmlAttribute(srcOut)}/${featureName}Presenter.java" />
    <instantiate from="root/src/app_package/TemplateMvpView.java.ftl"
                 to="${escapeXmlAttribute(srcOut)}/${featureName}MvpView.java" />
    <instantiate from="root/res/layout/fragment_template.xml.ftl"
                 to="${escapeXmlAttribute(resOut)}/layout/${layoutName}.xml" />
    <#if includeRecycler>
        <instantiate from="root/src/app_package/TemplateAdapter.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/${adapterName}.java" />
        <instantiate from="root/res/layout/fragment_template.xml.ftl"
                     to="${escapeXmlAttribute(resOut)}/layout/${itemLayout}.xml" />
    </#if>
    <open file="${escapeXmlAttribute(srcOut)}/${className}.java" />

</recipe>
