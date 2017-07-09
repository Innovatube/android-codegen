<?xml version="1.0" encoding="UTF-8"?>
<recipe>

    <classpath mavenUrl="com.neenbedankt.gradle.plugins:android-apt:1.8"/>
    <classpath mavenUrl="io.realm:realm-gradle-plugin:3.4.0"/>
    <classpath mavenUrl='com.google.gms:google-services:3.1.0'/>

    <apply plugin="realm-android"/>
    <apply plugin="com.neenbedankt.android-apt"/>
    <apply plugin="com.google.gms.google-services"/>

    <merge from="root/project_build.gradle.ftl"
           to="build.gradle"/>
    <merge from="root/module_build.gradle.ftl"
           to="${escapeXmlAttribute(projectOut)}/build.gradle"/>
    <copy from="root/dependencies.gradle.ftl"
          to="dependencies.gradle"/>

    <merge from="root/AndroidManifest.xml.ftl"
           to="${escapeXmlAttribute(manifestOut)}/AndroidManifest.xml"/>

    <instantiate from="root/src/app_package/consts/Consts.java.ftl"
          to="${escapeXmlAttribute(srcOut)}/consts/Consts.java"/>

    <instantiate from="root/src/app_package/data/local/PreferenceHelper.java.ftl"
          to="${escapeXmlAttribute(srcOut)}/data/local/PreferenceHelper.java"/>
    <instantiate from="root/src/app_package/data/local/RealmHelper.java.ftl"
          to="${escapeXmlAttribute(srcOut)}/data/local/RealmHelper.java"/>

    <instantiate from="root/src/app_package/data/models/ApiError.java.ftl"
          to="${escapeXmlAttribute(srcOut)}/data/models/ApiError.java"/>

    <instantiate from="root/src/app_package/data/remote/RetrofitService.java.ftl"
          to="${escapeXmlAttribute(srcOut)}/data/remote/RetrofitService.java"/>

    <instantiate from="root/src/app_package/data/DataManager.java.ftl"
          to="${escapeXmlAttribute(srcOut)}/data/DataManager.java"/>

    <instantiate from="root/src/app_package/injection/component/ActivityComponent.java.ftl"
          to="${escapeXmlAttribute(srcOut)}/injection/component/ActivityComponent.java"/>
    <instantiate from="root/src/app_package/injection/component/ApplicationComponent.java.ftl"
          to="${escapeXmlAttribute(srcOut)}/injection/component/ApplicationComponent.java"/>

    <instantiate from="root/src/app_package/injection/module/ActivityModule.java.ftl"
          to="${escapeXmlAttribute(srcOut)}/injection/module/ActivityModule.java"/>
    <instantiate from="root/src/app_package/injection/module/ApplicationModule.java.ftl"
          to="${escapeXmlAttribute(srcOut)}/injection/module/ApplicationModule.java"/>

    <instantiate from="root/src/app_package/injection/ActivityContext.java.ftl"
          to="${escapeXmlAttribute(srcOut)}/injection/ActivityContext.java"/>
    <instantiate from="root/src/app_package/injection/ApplicationContext.java.ftl"
          to="${escapeXmlAttribute(srcOut)}/injection/ApplicationContext.java"/>
    <instantiate from="root/src/app_package/injection/PerActivity.java.ftl"
          to="${escapeXmlAttribute(srcOut)}/injection/PerActivity.java"/>

    <instantiate from="root/src/app_package/ui/base/BaseActivity.java.ftl"
          to="${escapeXmlAttribute(srcOut)}/ui/base/BaseActivity.java"/>
    <instantiate from="root/src/app_package/ui/base/BaseFragment.java.ftl"
          to="${escapeXmlAttribute(srcOut)}/ui/base/BaseFragment.java"/>
    <instantiate from="root/src/app_package/ui/base/BaseDialogActivity.java.ftl"
          to="${escapeXmlAttribute(srcOut)}/ui/base/BaseDialogActivity.java"/>
    <instantiate from="root/src/app_package/ui/base/BaseMvpView.java.ftl"
          to="${escapeXmlAttribute(srcOut)}/ui/base/BaseMvpView.java"/>
    <instantiate from="root/src/app_package/ui/base/Presenter.java.ftl"
          to="${escapeXmlAttribute(srcOut)}/ui/base/Presenter.java"/>
    <instantiate from="root/src/app_package/ui/base/BaseDialogFragment.java.ftl"
          to="${escapeXmlAttribute(srcOut)}/ui/base/BaseDialogFragment.java"/>
    <instantiate from="root/src/app_package/ui/base/BasePresenter.java.ftl"
          to="${escapeXmlAttribute(srcOut)}/ui/base/BasePresenter.java"/>

    <instantiate from="root/src/app_package/ui/base/MvpView.java.ftl"
                 to="${escapeXmlAttribute(srcOut)}/ui/base/MvpView.java"/>

    <instantiate from="root/src/app_package/ui/fcm/FirebaseMessagingService.java.ftl"
          to="${escapeXmlAttribute(srcOut)}/ui/fcm/FirebaseMessagingService.java"/>

    <instantiate from="root/src/app_package/utils/AppUtils.java.ftl"
          to="${escapeXmlAttribute(srcOut)}/utils/AppUtils.java"/>

    <instantiate from="root/src/app_package/MyApplication.java.ftl"
          to="${escapeXmlAttribute(srcOut)}/MyApplication.java"/>


    <copy from="root/res/drawable/side_nav_bar.xml"
           to="${escapeXmlAttribute(resOut)}/drawable/side_nav_bar.xml"/>

    <merge from="root/res/values/colors.xml.ftl"
           to="${escapeXmlAttribute(resOut)}/values/colors.xml"/>
    <merge from="root/res/values/styles.xml.ftl"
          to="${escapeXmlAttribute(resOut)}/values/styles.xml"/>
    <merge from="root/res/values/strings.xml.ftl"
           to="${escapeXmlAttribute(resOut)}/values/strings.xml"/>
    <merge from="root/res/values/dimens.xml.ftl"
           to="${escapeXmlAttribute(resOut)}/values/dimens.xml"/>

    <merge from="root/res/values-v21/styles.xml.ftl"
           to="${escapeXmlAttribute(resOut)}/values-v21/styles.xml"/>

    <merge from="root/res/values-w820dp/dimens.xml.ftl"
           to="${escapeXmlAttribute(resOut)}/values-w820dp/dimens.xml"/>
</recipe>
