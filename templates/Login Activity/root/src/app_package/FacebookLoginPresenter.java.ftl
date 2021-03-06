package ${packageName};

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

import com.facebook.AccessToken;
import com.facebook.CallbackManager;
import com.facebook.FacebookAuthorizationException;
import com.facebook.FacebookCallback;
import com.facebook.FacebookException;
import com.facebook.FacebookSdk;
import com.facebook.GraphRequest;
import com.facebook.GraphResponse;
import com.facebook.login.LoginManager;
import com.facebook.login.LoginResult;
<#if applicationPackage??>
import ${applicationPackage}.ui.base.BasePresenter;

</#if>
import org.json.JSONObject;

import java.util.Arrays;

import javax.inject.Inject;


public class Facebook${featureName}Presenter extends BasePresenter<${featureName}MvpView> {
    private CallbackManager mCallbackManager;
    private final Activity mActivity;

    @Inject
    public Facebook${featureName}Presenter(Activity mActivity) {
        this.mActivity = mActivity;
        mCallbackManager = CallbackManager.Factory.create();
    }

    public void loginWithFacebook() {
        LoginManager.getInstance().logInWithReadPermissions(mActivity, Arrays.asList("public_profile", "email"));
        LoginManager.getInstance().registerCallback(mCallbackManager, new FacebookCallback<LoginResult>() {
            @Override
            public void onSuccess(LoginResult loginResult) {
                GraphRequest request = GraphRequest.newMeRequest(
                        loginResult.getAccessToken(),
                        new GraphRequest.GraphJSONObjectCallback() {
                            @Override
                            public void onCompleted(
                                    JSONObject object,
                                    GraphResponse response) {
                                try {
                                    String firstName = object.getString("first_name");
                                    String lastName = object.getString("last_name");
                                    String email = object.getString("email");

                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            }
                        });
                Bundle parameters = new Bundle();
                parameters.putString("fields", "first_name,last_name,email");
                request.setParameters(parameters);
                request.executeAsync();


                if (loginResult != null) {
                    AccessToken accessToken = loginResult.getAccessToken();
                }
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
    }
}
