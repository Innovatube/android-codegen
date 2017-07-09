package ${packageName};

import android.content.Intent;
import android.os.Bundle;
<#if applicationPackage??>
import ${applicationPackage}.R;
<#if superClass == 'BaseDialogActivity' || superClass =='BaseActivity'>
import ${applicationPackage}.ui.base.${superClass};
</#if>
</#if>
import javax.inject.Inject;

import butterknife.BindString;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class ${activityClass} extends ${superClass} implements ${featureName}MvpView {
    @BindString(R.string.title_${activityToLayout(activityClass)})
    String title;
    <#if loginWithGoogle>
    @Inject
    Google${featureName}Presenter mGoogle${featureName}Presenter;
    </#if>
    <#if loginWithFacebook>
    @Inject
    Facebook${featureName}Presenter mFacebook${featureName}Presenter;
    </#if>
    <#if manualLogin>
    @Inject
    ${featureName}Presenter m${featureName}Presenter;
    </#if>
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.${layoutName});
        ButterKnife.bind(this);
        <#if superClass == 'BaseDialogActivity' || superClass =='BaseActivity'>
        getActivityComponent().inject(this);
        </#if>
        <#if loginWithGoogle>
        mGoogle${featureName}Presenter.attachView(this);
        </#if>
        <#if loginWithFacebook>
        mFacebook${featureName}Presenter.attachView(this);
        </#if>
        <#if manualLogin>
        m${featureName}.attachView(this);
        </#if>
    }

    <#if superClass == 'BaseDialogActivity'>
    @Override
    protected void setupDialogTitle() {
        progressDialog.setTitle(title);
        alertDialog.setTitle(title);
    }
    </#if>

    <#if loginWithGoogle>
    @Override
    public void onPause() {
        super.onPause();
        mGoogle${featureName}Presenter.onPause();
    }

    @Override
    public void onDestroy() {
        mGoogle${featureName}Presenter.onDestroy();
        super.onDestroy();
    }
    </#if>

    <#if loginWithFacebook>
    @OnClick(R.id.btn_login_facebook)
    public void loginFacebook() {
        mFacebook${featureName}Presenter.loginWithFacebook();
    }
    </#if>

    <#if manualLogin>
    @OnClick(R.id.btn_login)
    public void login() {

    }
    </#if>
    <#if loginWithGoogle>
    @OnClick(R.id.btn_login_google_plus)
    public void loginGooglePlus() {
        mGoogle${featureName}Presenter.loginWithGoogle();
    }
    </#if>

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
    <#if loginWithFacebook>
        mFacebook${featureName}Presenter.onActivityResult(requestCode, resultCode, data);
    </#if>
    <#if loginWithGoogle>
        mGoogle${featureName}Presenter.onActivityResult(requestCode, resultCode, data);
    </#if>
    }

}
