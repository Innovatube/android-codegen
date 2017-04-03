package <%= package_name %>.ui.login;

import android.app.Activity;
import android.content.Intent;
import android.support.annotation.NonNull;

import com.facebook.AccessToken;
import com.facebook.CallbackManager;
import com.facebook.FacebookAuthorizationException;
import com.facebook.FacebookCallback;
import com.facebook.FacebookException;
import com.facebook.login.LoginManager;
import com.facebook.login.LoginResult;
import com.google.android.gms.auth.api.Auth;
import com.google.android.gms.auth.api.signin.GoogleSignInAccount;
import com.google.android.gms.auth.api.signin.GoogleSignInOptions;
import com.google.android.gms.auth.api.signin.GoogleSignInResult;
import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.firebase.auth.AuthCredential;
import com.google.firebase.auth.FacebookAuthProvider;
import com.google.firebase.auth.GoogleAuthProvider;
import <%= package_name %>.ui.base.BasePresenter;

import java.util.Arrays;

import javax.inject.Inject;

/**
 * Created by quanlt on 4/1/17.
 */

public class LoginPresenter extends BasePresenter<LoginMvpView> implements GoogleApiClient.OnConnectionFailedListener {
    private static final int RC_GOOGLE_SIGN_IN = 100;
    private final Activity mActivity;
    private GoogleApiClient mGoogleApiClient;
    private CallbackManager mCallbackManager;


    @Inject
    public LoginPresenter(Activity mActivity) {
        this.mActivity = mActivity;
        mCallbackManager = CallbackManager.Factory.create();
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

    @Override
    public void attachView(LoginMvpView mvpView) {
        super.attachView(mvpView);
    }


    public void loginWithGoogle() {
        Intent intent = Auth.GoogleSignInApi.getSignInIntent(mGoogleApiClient);
        mActivity.startActivityForResult(intent, RC_GOOGLE_SIGN_IN);
    }

    public void loginWithFacebook() {
        LoginManager.getInstance()
                .logInWithReadPermissions(mActivity, Arrays.asList("public_profile", "email"));
        LoginManager.getInstance()
                .registerCallback(mCallbackManager, new FacebookCallback<LoginResult>() {
                    @Override
                    public void onSuccess(LoginResult loginResult) {
                        AuthCredential credential =
                                FacebookAuthProvider.getCredential(loginResult.getAccessToken().getToken());
                        signIn(credential);
                    }

                    @Override
                    public void onCancel() {

                    }

                    @Override
                    public void onError(FacebookException error) {
                        error.printStackTrace();
                        if (error instanceof FacebookAuthorizationException) {
                            if (AccessToken.getCurrentAccessToken() != null) {
                                LoginManager.getInstance().logOut();
                            }
                        }
                    }
                });
    }

    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        mCallbackManager.onActivityResult(requestCode, resultCode, data);
        if (requestCode == RC_GOOGLE_SIGN_IN) {
            GoogleSignInResult result = Auth.GoogleSignInApi.getSignInResultFromIntent(data);
            if (result.isSuccess()) {
                GoogleSignInAccount account = result.getSignInAccount();
                AuthCredential credential = GoogleAuthProvider.getCredential(account.getIdToken(), null);
                signIn(credential);
            } else {
                getMvpView().showAlertDialog("Unable to login");
            }
        }

    }

    public void signIn(AuthCredential credential){

    }

    @Override
    public void onConnectionFailed(@NonNull ConnectionResult connectionResult) {

    }
}
