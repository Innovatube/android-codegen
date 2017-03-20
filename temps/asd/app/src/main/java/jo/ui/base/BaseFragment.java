package jo.ui.base;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;

import jo.MyApplication;
import jo.injection.component.ActivityComponent;
import jo.injection.component.DaggerActivityComponent;
import jo.injection.module.ActivityModule;

/**
 * Created by TOIDV on 5/19/2016.
 */
public class BaseFragment extends Fragment {

    ActivityComponent mActivityComponent;

    @Override
    public void onActivityCreated(@Nullable Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
    }

    public ActivityComponent getActivityComponent() {
        if (mActivityComponent == null) {
            mActivityComponent = DaggerActivityComponent.builder()
                    .applicationComponent(MyApplication.get(getActivity()).getComponent())
                    .activityModule(new ActivityModule(getActivity()))
                    .build();
        }
        return mActivityComponent;
    }

}
