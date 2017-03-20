package <%= package_name %>.ui.template.normal;

import android.os.Bundle;

import <%= package_name %>.R;
import <%= package_name %>.ui.base.BaseActivity;

public class HomeActivity extends BaseActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.template_activity_main);
        getActivityComponent().inject(this);
    }
}
