package ${packageName};

import android.support.design.widget.TabLayout;
import android.support.v7.widget.Toolbar;

import android.support.v4.view.ViewPager;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;

<#if applicationPackage??>
import ${applicationPackage}.R;
import ${applicationPackage}.ui.base.${superClass};
</#if>

import javax.inject.Inject;

import butterknife.BindView;
import butterknife.ButterKnife;

public class ${activityClass} extends ${superClass} implements ${featureName}MvpView {

    @BindView(R.id.toolbar)
    Toolbar mToolbar;
    @BindView(R.id.tabs)
    TabLayout mTabs;
    @BindView(R.id.container)
    ViewPager mViewPager;

    @Inject
    ${featureName}Presenter m${featureName}Presenter;

    private ${pagerClassName} m${pagerClassName};

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.${layoutName});
        ButterKnife.bind(this);
        setSupportActionBar(mToolbar);
        getActivityComponent().inject(this);

        m${featureName}Presenter.attachView(this);

        m${pagerClassName} = new ${pagerClassName}(getSupportFragmentManager());
        mViewPager.setAdapter(m${pagerClassName});
        mTabs.setupWithViewPager(mViewPager);
    }

    @Override
    protected void setupDialogTitle() {

    }

    @Override
    protected void onDestroy() {
        m${featureName}Presenter.detachView();
        super.onDestroy();
    }
}
