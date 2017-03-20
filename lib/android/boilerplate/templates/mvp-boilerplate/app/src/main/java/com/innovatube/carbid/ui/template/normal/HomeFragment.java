package <%= package_name %>.ui.template.normal;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import <%= package_name %>.R;

/**
 * Created by quanlt on 3/17/17.
 */

public class HomeFragment extends Fragment {

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.template_home_fragment, container, false);
        return rootView;
    }
}
