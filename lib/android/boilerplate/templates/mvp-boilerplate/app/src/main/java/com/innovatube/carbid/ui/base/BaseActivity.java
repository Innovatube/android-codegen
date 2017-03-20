package <%= package_name %>.ui.base;

import android.support.v7.app.AppCompatActivity;

import <%= package_name %>.MyApplication;
import <%= package_name %>.injection.component.ActivityComponent;
import <%= package_name %>.injection.component.DaggerActivityComponent;
import <%= package_name %>.injection.module.ActivityModule;


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
