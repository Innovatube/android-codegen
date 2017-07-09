package ${packageName};

import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.design.widget.BottomNavigationView;
import android.support.v7.app.AppCompatActivity;
import android.view.MenuItem;
import android.widget.FrameLayout;
import android.widget.TextView;
<#if applicationPackage??>
import ${applicationPackage}.R;
import ${applicationPackage}.ui.base.${superClass};
</#if>

import javax.inject.Inject;

import butterknife.BindView;
import butterknife.ButterKnife;

public class ${activityClass} extends ${superClass} implements ${featureName}MvpView,
        BottomNavigationView.OnNavigationItemSelectedListener{

    @BindView(R.id.navigation)
    BottomNavigationView m${featureName}Navigation;
    @BindView(R.id.frame_content)
    FrameLayout mContentFrameLayout;

    @Inject
    ${featureName}Presenter m${featureName}Presenter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.${layoutName});

        getActivityComponent().inject(this);
        ButterKnife.bind(this);
        m${featureName}Presenter.attachView(this);
        m${featureName}Navigation.setOnNavigationItemSelectedListener(this);
    }
    @Override
    protected void setupDialogTitle() {

    }

    @Override
    public boolean onNavigationItemSelected(@NonNull MenuItem item) {
        switch (item.getItemId()) {
            case R.id.navigation_home:
                //TODO implement navigation selected
                return true;
            case R.id.navigation_dashboard:
                //TODO implement navigation selected
                return true;
            case R.id.navigation_notifications:
                //TODO implement navigation selected
                return true;
        }
        return false;
    }
}
