package quanlt.com.ui.home;

import android.os.Bundle;

import quanlt.com.R;
import quanlt.com.ui.base.BaseActivity;

public class HomeActivity extends BaseActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        getActivityComponent().inject(this);
    }
}
