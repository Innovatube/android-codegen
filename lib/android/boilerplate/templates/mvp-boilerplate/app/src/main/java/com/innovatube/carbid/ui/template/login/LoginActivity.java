package <%= package_name %>.ui.login;

import android.content.Intent;
import android.os.Bundle;

import <%= package_name %>.R;
import <%= package_name %>.ui.base.BaseDialogActivity;

import javax.inject.Inject;

import butterknife.BindString;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class LoginActivity extends BaseDialogActivity implements LoginMvpView {
    @BindString(R.string.login_activity_title)
    String title;

    <% if enable_google_login %>
    @Inject
    GoogleSignInPresenter mGoogleSignInPresenter;
    // <% end %>
    <% if enable_facebook_login %>
    @Inject
    FacebookLoginPresenter mFacebookLoginPresenter;
    // <% end %>

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        ButterKnife.bind(this);
        //TODO inject dependency
        //getActivityComponent().inject(this);
        <% if enable_google_login %>
        mGoogleSignInPresenter.attachView(this);
        // <% end %>
        <% if enable_facebook_login %>
        mFacebookLoginPresenter.attachView(this);
        // <% end %>
    }

    @Override
    protected void setupDialogTitle() {
        progressDialog.setTitle(title);
        alertDialog.setTitle(title);
    }

    <% if enable_google_login %>
    @Override
    public void onPause() {
        super.onPause();
        mGoogleSignInPresenter.onPause();
    }

    @Override
    public void onDestroy() {
        mGoogleSignInPresenter.onDestroy();
        super.onDestroy();
    }
    // <% end %>

    <% if enable_facebook_login %>
    @OnClick(R.id.btn_login_facebook)
    public void loginFacebook() {
        mFacebookLoginPresenter.loginWithFacebook();
    }
    <% end %>

    @OnClick(R.id.btn_login)
    public void login() {
    }

    <% if enable_google_login %>
    @OnClick(R.id.btn_login_google_plus)
    public void loginGooglePlus() {
        mGoogleSignInPresenter.loginWithGoogle();
    }
    <% end %>

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        <% if enable_facebook_login %>
        mFacebookLoginPresenter.onActivityResult(requestCode, resultCode, data);
        <% end %>
        <% if enable_google_login %>
        mGoogleSignInPresenter.onActivityResult(requestCode, resultCode, data);
        <% end %>
    }

}
