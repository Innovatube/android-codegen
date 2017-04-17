package <%= package_name %>.ui.<%= sub_package_name %>;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import <%= package_name %>.R;

/**
 * Created by quanlt on 3/17/17.
 */




public class <%= activity_name.capitalize %>Fragment extends Fragment {

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.<%= to_snake_case(activity_name) %>_fragment, container, false);
        return rootView;
    }
}
