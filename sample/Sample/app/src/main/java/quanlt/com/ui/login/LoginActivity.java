package quanlt.com.ui.login;

import android.content.Intent;
import android.os.Bundle;

import quanlt.com.R;
import quanlt.com.ui.base.BaseDialogActivity;

import javax.inject.Inject;

import butterknife.BindString;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class LoginActivity extends BaseDialogActivity implements LoginMvpView {
    @BindString(R.string.login_activity_title)
    String title;
    @Inject
    FacebookLoginPresenter mFacebookLoginPresenter;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        ButterKnife.bind(this);
        getActivityComponent().inject(this);
        mFacebookLoginPresenter.attachView(this);
    }

    @Override
    protected void setupDialogTitle() {
        progressDialog.setTitle(title);
        alertDialog.setTitle(title);
    }


    @OnClick(R.id.btn_login_facebook)
    public void loginFacebook() {
        mFacebookLoginPresenter.loginWithFacebook();
    }

    @OnClick(R.id.btn_login)
    public void login(){

    }



    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        mFacebookLoginPresenter.onActivityResult(requestCode, resultCode, data);
    }

}
