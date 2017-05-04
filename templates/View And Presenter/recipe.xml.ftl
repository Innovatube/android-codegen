<?xml version="1.0"?>
<recipe>

    <instantiate from="root/src/app_package/TemplatePresenter.java.ftl"
                 to="${escapeXmlAttribute(srcOut)}/${presenterName}.java" />
    <instantiate from="root/src/app_package/TemplateMvpView.java.ftl"
                 to="${escapeXmlAttribute(srcOut)}/${viewName}.java" />

    <open file="${escapeXmlAttribute(srcOut)}/${presenterName}.java" />
    <open file="${escapeXmlAttribute(srcOut)}/${viewName}.java" />
</recipe>
