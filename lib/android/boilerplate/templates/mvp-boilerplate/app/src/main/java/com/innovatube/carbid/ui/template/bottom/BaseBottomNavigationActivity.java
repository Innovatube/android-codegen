package <%= package_name %>.ui.<%= sub_package_name %>;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import <%= package_name %>.R;

public class <%= activity_name.capitalize %>Activity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_<%= to_snake_case(activity_name) %>);
    }
}
