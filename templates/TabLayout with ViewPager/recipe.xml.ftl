<?xml version="1.0"?>
<recipe>
    <#include "../common/recipe_manifest.xml.ftl" />

    <copy from="root/res/drawable"
            to="${escapeXmlAttribute(resOut)}/drawable" />

    <instantiate from="root/src/app_package/DetailActivity.java.ftl"
                   to="${escapeXmlAttribute(srcOut)}/${activityClass}.java" />
    <instantiate from="root/src/app_package/DetailMvpView.java.ftl"
                 to="${escapeXmlAttribute(srcOut)}/${featureName}MvpView.java" />
    <instantiate from="root/src/app_package/DetailPresenter.java.ftl"
                 to="${escapeXmlAttribute(srcOut)}/${featureName}Presenter.java" />
    <instantiate from="root/src/app_package/DetailPagerAdapter.java.ftl"
                 to="${escapeXmlAttribute(srcOut)}/${pagerClassName}.java" />
    <instantiate from="root/src/app_package/DetailPagerFragment.java.ftl"
                 to="${escapeXmlAttribute(srcOut)}/${fragmentClassName}.java" />
    <instantiate from="root/res/layout/activity_main.xml.ftl"
                   to="${escapeXmlAttribute(resOut)}/layout/${layoutName}.xml" />
    <instantiate from="root/res/layout/fragment_detail.xml.ftl"
                 to="${escapeXmlAttribute(resOut)}/layout/${fragmentLayoutName}.xml" />
    <merge from="root/res/values/strings.xml"
             to="${escapeXmlAttribute(resOut)}/values/strings.xml" />

    <open file="${escapeXmlAttribute(resOut)}/layout/${layoutName}.xml" />
</recipe>
