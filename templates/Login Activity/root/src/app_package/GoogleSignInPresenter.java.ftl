package ${packageName};

import android.app.Activity;
import android.content.Intent;
import android.support.annotation.NonNull;
import android.support.v4.app.FragmentActivity;
import android.util.Log;

import com.google.android.gms.auth.api.Auth;
import com.google.android.gms.auth.api.signin.GoogleSignInAccount;
import com.google.android.gms.auth.api.signin.GoogleSignInOptions;
import com.google.android.gms.auth.api.signin.GoogleSignInResult;
import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.api.GoogleApiClient;
import ${applicationPackage}.ui.base.BasePresenter;

import javax.inject.Inject;

/**
 * Created by quanlt on 3/16/17.
 */

public class Google${featureName}Presenter extends BasePresenter<${featureName}MvpView> implements
        GoogleApiClient.OnConnectionFailedListener {
    private LoginMvpView mLoginView;
    private final Activity mActivity;
    private GoogleApiClient mGoogleApiClient;
    private static final int RC_SIGN_IN = 103;
    /*
    TODO: Download google-services.json
    Before you run your application, you will need a config file for your app, navigate to the following URL
    <#if applicationPackage??>
    https://developers.google.com/mobile/add?platform=android&cntapi=signin&cntapp=YOUR_APP_NAME&cntpkg=${applicationPackage}
    <#else>
    https://developers.google.com/mobile/add?platform=android&cntapi=signin&cntapp=YOUR_APP_NAME&cntpkg=${packageName}
    </#if>
    SHA-1 certificate fingerprint: ${debugKeystoreSha1}
    */
    @Inject
    public Google${featureName}Presenter(Activity mActivity) {
        this.mActivity = mActivity;
        createGoogleApiClient((${activityClass}) mActivity);
    }

    public void createGoogleApiClient(LoginActivity activity) {
        GoogleSignInOptions gso = new GoogleSignInOptions.Builder(GoogleSignInOptions.DEFAULT_GAMES_SIGN_IN)
                .requestEmail()
                .build();
        mGoogleApiClient = new GoogleApiClient.Builder(activity)
                .enableAutoManage(activity, this)
                .addApi(Auth.GOOGLE_SIGN_IN_API, gso)
                .build();
    }

    public void loginWithGoogle() {
        Intent loginIntent = Auth.GoogleSignInApi.getSignInIntent(mGoogleApiClient);
        mActivity.startActivityForResult(loginIntent, RC_SIGN_IN);
    }

    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == RC_SIGN_IN) {
            GoogleSignInResult result = Auth.GoogleSignInApi.getSignInResultFromIntent(data);
            if (result.isSuccess()) {
                GoogleSignInAccount account = result.getSignInAccount();

            } else {
                Log.e("Google SignIn : ", "fail");
            }
        }
    }

    @Override
    public void onConnectionFailed(@NonNull ConnectionResult connectionResult) {
        Log.e("onConnection fail: ", " " + connectionResult);
    }

    public void onPause() {
        mGoogleApiClient.stopAutoManage((FragmentActivity) mActivity);
        mGoogleApiClient.disconnect();
    }

    public void onDestroy() {
        mGoogleApiClient.stopAutoManage((FragmentActivity) mActivity);
        mGoogleApiClient.disconnect();
    }
}
