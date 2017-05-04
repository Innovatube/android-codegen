package ${packageName};

import android.os.Bundle;

<#if applicationPackage??>
import ${applicationPackage}.R;
import ${applicationPackage}.ui.base.BaseDialogActivity;
</#if>

import javax.inject.Inject;

public class ${activityClass} extends BaseDialogActivity implements ${featureName}MvpView {

    @Inject
    ${classToResource(activityClass)?cap_first}Presenter m${featureName}Presenter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.${layoutName});
        getActivityComponent().inject(this);
        m${featureName}Presenter.attachView(this);
    }

    @Override
    protected void setupDialogTitle() {

    }
}
