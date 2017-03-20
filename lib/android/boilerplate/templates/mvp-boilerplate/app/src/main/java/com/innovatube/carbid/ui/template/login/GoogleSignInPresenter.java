package <%= package_name %>.ui.template.login;

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
import <%= package_name %>.ui.base.BasePresenter;

import javax.inject.Inject;

/**
 * Created by quanlt on 3/16/17.
 */

public class GoogleSignInPresenter extends BasePresenter<LoginMvpView> implements
        GoogleApiClient.OnConnectionFailedListener {
    private LoginMvpView mLoginView;
    private final Activity mActivity;
    private GoogleApiClient mGoogleApiClient;
    private static final int RC_SIGN_IN = 103;

    @Inject
    public GoogleSignInPresenter(Activity mActivity) {
        this.mActivity = mActivity;
        createGoogleApiClient((LoginActivity) mActivity);
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
