package <%= package_name %>.ui.template.bottom;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import <%= package_name %>.R;

public class BaseBottomNavigationActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.template_activity_base_bottom_navigation);
    }
}
