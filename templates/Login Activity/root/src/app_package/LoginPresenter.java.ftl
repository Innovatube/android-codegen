package ${packageName};

import android.app.Activity;

import javax.inject.Inject;
<#if applicationPackage??>
import ${applicationPackage}.ui.base.BasePresenter;
</#if>

public class ${featureName}Presenter extends BasePresenter<${featureName}MvpView> {
    private final Activity mActivity;


    @Inject
    public ${featureName}Presenter(Activity mActivity) {
        this.mActivity = mActivity;
    }
}
