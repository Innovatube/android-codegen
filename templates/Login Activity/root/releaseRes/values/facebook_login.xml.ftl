<resources>
    <!--
    TODO: Before you release your application, you need a Facebook App ID.

    To get one, follow this link, follow the instruction

    https://developers.facebook.com/apps/

    You can also add your credentials to an existing app, using these values:

    Package name:
    ${packageName}

    Run the following command to get key hash:
    'keytool -exportcert -alias androiddebugkey -storepass android -keystore ~/.android/debug.keystore | openssl sha1 -binary | openssl base64

    Alternatively, follow the directions here:
    https://developers.facebook.com/docs/facebook-login/android/

    Once you have your app id, replace the "facebook_app_id"
    string in this file.
    -->
    <#-- Always preserve the existing key. -->
    <string name="facebook_app_id">${facebookAppId}</string>
</resources>
