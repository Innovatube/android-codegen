apply plugin: 'com.android.application'
apply plugin: 'com.neenbedankt.android-apt'
apply plugin: 'realm-android'

dependencies {


    compile "com.android.support:design:${r"${supportLibrariesVersion}"}"
    compile "com.android.support:support-v4:${r"${supportLibrariesVersion}"}"
    compile "com.jakewharton:butterknife:${r"${butterKnifeVersion}"}"
    apt "com.jakewharton:butterknife-compiler:${r"${butterKnifeVersion}"}"
    compile "com.google.dagger:dagger:${r"${dagger2Version}"}"
    apt "com.google.dagger:dagger-compiler:${r"${dagger2Version}"}"
    compile "com.squareup.retrofit2:retrofit:${r"${retrofit2Version}"}"
    compile "com.squareup.retrofit2:converter-gson:${r"${retrofit2Version}"}"
    <#if rxVersion == 'rxJava2'>
    compile "com.squareup.retrofit2:adapter-rxjava2:${r"${retrofit2Version}"}"
    <#else>
    compile "com.squareup.retrofit2:adapter-rxjava:${r"${retrofit2Version}"}"
    </#if>
    compile "com.squareup.okhttp3:logging-interceptor:${r"${okHttpVersion}"}"
    <#if rxVersion == 'rxJava2'>
    compile "io.reactivex.rxjava2:rxandroid:${r"${rxAndroid2Version}"}"
    compile "io.reactivex.rxjava2:rxjava:${r"${rxJava2Version}"}"
    </#if>
    compile "com.google.firebase:firebase-core:${r"${playServiceVersion}"}"
    compile "com.google.firebase:firebase-messaging:${r"${playServiceVersion}"}"
    compile "com.afollestad.material-dialogs:core:${r"${materialDialogVersion}"}"

    provided "javax.annotation:jsr250-api:1.0"
    compile "com.intuit.sdp:sdp-android:1.0.4"
}
//please move com.neenbedankt.android-apt and realm-android to top of this file