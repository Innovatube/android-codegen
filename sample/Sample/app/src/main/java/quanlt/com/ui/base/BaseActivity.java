package quanlt.com.ui.base;

import android.support.v7.app.AppCompatActivity;

import quanlt.com.MyApplication;
import quanlt.com.injection.component.ActivityComponent;
import quanlt.com.injection.component.DaggerActivityComponent;
import quanlt.com.injection.module.ActivityModule;


/**
 * Created by TOIDV on 4/4/2016.
 */
public class BaseActivity extends AppCompatActivity {
    ActivityComponent mActivityComponent;

    public ActivityComponent getActivityComponent() {
        if (mActivityComponent == null) {
            mActivityComponent = DaggerActivityComponent.builder()
                    .applicationComponent(MyApplication.get(this).getComponent())
                    .activityModule(new ActivityModule(this))
                    .build();
        }
        return mActivityComponent;
    }
}
