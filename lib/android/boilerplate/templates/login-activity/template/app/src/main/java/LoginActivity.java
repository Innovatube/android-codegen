package <%= package_name %>;

import android.content.Intent;
import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
<% if enable_email %>
import android.widget.Button;
<% end %>
<% if enable_facebook %>
import com.facebook.CallbackManager;
import com.facebook.FacebookCallback;
import com.facebook.FacebookException;
import com.facebook.login.LoginResult;
import com.facebook.login.widget.LoginButton;
<% end %>
<% if enable_google %>
import com.google.android.gms.auth.api.Auth;
import com.google.android.gms.auth.api.signin.GoogleSignInAccount;
import com.google.android.gms.auth.api.signin.GoogleSignInOptions;
import com.google.android.gms.auth.api.signin.GoogleSignInResult;
import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.SignInButton;
import com.google.android.gms.common.api.GoogleApiClient;
<% end %>
import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class LoginActivity extends AppCompatActivity implements GoogleApiClient.OnConnectionFailedListener {

    <% if enable_google %>
    private static final int RC_GOOGLE_SIGN_IN = 1;
    @BindView(R.id.button_login_google)
    SignInButton btnLoginGoogle;
    <% end %>
    <% if enable_facebook %>
    @BindView(R.id.button_login_facebook)
    LoginButton btnLoginFacebook;
    <% end %>
    <% if enable_email %>
    @BindView(R.id.button_login_email)
    Button btnLoginEmail;
    @BindView(R.id.edit_email)
    TextInputEditText edEmail;
    @BindView(R.id.edit_password)
    TextInputEditText edPassword;
    <% end %>

    <% if enable_facebook %>
    private GoogleApiClient mGoogleApiClient;
    <% end %>
    <% if enable_facebook %>
    private CallbackManager mCallbackManager;
    <% end %>

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        ButterKnife.bind(this);
        <% if enable_google %>
        GoogleSignInOptions gso = new GoogleSignInOptions.Builder(GoogleSignInOptions.DEFAULT_SIGN_IN)
                .requestEmail()
                .build();

        mGoogleApiClient = new GoogleApiClient.Builder(this)
                .enableAutoManage(this /* FragmentActivity */, this /* OnConnectionFailedListener */)
                .addApi(Auth.GOOGLE_SIGN_IN_API, gso)
                .build();
        <% end %>
        <% if enable_facebook %>
        mCallbackManager = CallbackManager.Factory.create();
        btnLoginFacebook.setReadPermissions("email");
        btnLoginFacebook.registerCallback(mCallbackManager, new FacebookCallback<LoginResult>() {
            @Override
            public void onSuccess(LoginResult loginResult) {
                //TODO implement onSuccess callback

            }

            @Override
            public void onCancel() {
                //TODO implement onCancel callback
            }

            @Override
            public void onError(FacebookException error) {
                //TODO implement onError callback
            }
        });
        <% end %>

    }

    <% if enable_email %>
    @OnClick(R.id.button_login_email)
    void loginEmail(){

    }
    <% end %>

    <% if enable_google %>
    @OnClick(R.id.button_login_google)
    void loginGoogle(){
        Intent googleSignInIntent = Auth.GoogleSignInApi.getSignInIntent(mGoogleApiClient);
        startActivityForResult(googleSignInIntent, RC_GOOGLE_SIGN_IN);
    }

    private void handleGoogleSignInResult(GoogleSignInResult result) {
        if (result.isSuccess()){
            GoogleSignInAccount account = result.getSignInAccount();
            //TODO handle google sign in success
        } else {
            //TODO handle google sign in failed
        }
    }

    @Override
    public void onConnectionFailed(@NonNull ConnectionResult connectionResult) {
        //TODO implement onConnectionFailed with Google
    }
    <% end %>

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        <% if enable_facebook %>
        mCallbackManager.onActivityResult(requestCode,resultCode,data);
        <% end %>
        <% if enable_google %>
        if (requestCode == RC_GOOGLE_SIGN_IN){
            GoogleSignInResult result = Auth.GoogleSignInApi.getSignInResultFromIntent(data);
            handleGoogleSignInResult(result);
        }
        <% end %>
     }
}
