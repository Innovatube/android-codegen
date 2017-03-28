package <%= package_name %>.ui.<%= sub_package_name %>;

import android.os.Bundle;

import <%= package_name %>.R;
import <%= package_name %>.ui.base.BaseActivity;

public class <%= activity_name.capitalize %>Activity extends BaseActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_<%= to_snake_case(activity_name) %>);
        getActivityComponent().inject(this);
    }
}
