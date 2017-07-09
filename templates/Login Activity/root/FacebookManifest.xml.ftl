<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    package="${packageName}">

    <application>
        <meta-data android:name="com.facebook.sdk.ApplicationId"
                   android:value="@string/facebook_app_id"/>
        <activity android:name="com.facebook.FacebookActivity"
                  android:configChanges=
                          "keyboard|keyboardHidden|screenLayout|screenSize|orientation"
                  android:label="@string/app_name" />
    </application>

</manifest>
