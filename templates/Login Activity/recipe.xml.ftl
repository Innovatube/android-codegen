<?xml version="1.0"?>
<recipe>

    <#if loginWithGoogle>
        <classpath mavenUrl="com.google.gms:google-services:3.0.0"/>
        <apply plugin="com.google.gms.google-services"/>
        <dependency mavenUrl="com.google.android.gms:play-services-auth:+"/>
    </#if>
    <#if loginWithFacebook>
        <dependency mavenUrl="com.facebook.android:facebook-android-sdk:+"/>
    </#if>


    <instantiate from="root/src/app_package/LoginActivity.java.ftl"
                    to="${escapeXmlAttribute(srcOut)}/${activityClass}.java" />
    <instantiate from="root/src/app_package/LoginMvpView.java.ftl"
                 to ="${escapeXmlAttribute(srcOut)}/${featureName}MvpView.java"/>

    <instantiate from="root/res/layout/activity_login.xml.ftl"
                    to="${escapeXmlAttribute(resOut)}/layout/${layoutName}.xml" />

    <#if loginWithGoogle>
        <classpath mavenUrl="com.google.gms:google-services:3.0.0"/>
        <apply plugin="com.google.gms.google-services"/>
        <dependency mavenUrl="com.google.android.gms:play-services-auth:+"/>
    </#if>
    <#if loginWithFacebook>
        <instantiate from="root/src/app_package/FacebookLoginPresenter.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/Facebook${featureName}Presenter.java" />
        <merge from="root/debugRes/values/facebook_login.xml.ftl"
               to="${escapeXmlAttribute(debugResOut)}/values/facebook_login.xml" />
        <merge from="root/releaseRes/values/facebook_login.xml.ftl"
               to="${escapeXmlAttribute(releaseResOut)}/values/facebook_login.xml" />
    </#if>
    <#if loginWithGoogle>
        <instantiate from="root/src/app_package/GoogleSignInPresenter.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/Google${featureName}Presenter.java" />
    </#if>
    <#if manualLogin>
        <instantiate from="root/src/app_package/LoginPresenter.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/${featureName}Presenter.java" />
    </#if>
    <#include "../common/recipe_manifest.xml.ftl" />

    <open file="${escapeXmlAttribute(srcOut)}/${activityClass}.java" />
    <#if loginWithFacebook>
        <open file="${escapeXmlAttribute(debugResOut)}/values/facebook_login.xml" />
    </#if>
    <#if loginWithGoogle>
        <open file="${escapeXmlAttribute(srcOut)}/Google${featureName}Presenter.java" />
    </#if>
</recipe>
