package <%= package_name %>.ui.template.login;

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

    @Inject
    GoogleSignInPresenter mGoogleSignInPresenter;

    @Inject
    FacebookLoginPresenter mFacebookLoginPresenter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.template_activity_login);
        ButterKnife.bind(this);
        getActivityComponent().inject(this);
        mGoogleSignInPresenter.attachView(this);
        mFacebookLoginPresenter.attachView(this);
    }

    @Override
    protected void setupDialogTitle() {
        progressDialog.setTitle(title);
        alertDialog.setTitle(title);
    }

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

    @OnClick(R.id.btn_login_facebook)
    public void loginFacebook() {
        mFacebookLoginPresenter.loginWithFacebook();
    }

    @OnClick(R.id.btn_login)
    public void login() {
    }

    @OnClick(R.id.btn_login_google_plus)
    public void loginGooglePlus() {
        mGoogleSignInPresenter.loginWithGoogle();
    }


    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        mFacebookLoginPresenter.onActivityResult(requestCode, resultCode, data);
        mGoogleSignInPresenter.onActivityResult(requestCode, resultCode, data);
    }

}
