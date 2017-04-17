package <%= package_name %>.ui.<%= sub_package_name %>;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import <%= package_name %>.R;

/**
 * Created by quanlt on 4/3/17.
 */




public class <%= activity_name.capitalize %>Fragment extends Fragment {
    private static final String ARG_SECTION_NUMBER = "section_number";

    public <%= activity_name.capitalize %>Fragment() {

    }

    public static <%= activity_name.capitalize %>Fragment newInstance(int sectionNumber) {
        <%= activity_name.capitalize %>Fragment fragment = new <%= activity_name.capitalize %>Fragment();
        Bundle args = new Bundle();
        args.putInt(ARG_SECTION_NUMBER, sectionNumber);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.fragment_<%= to_snake_case(activity_name) %>, container, false);
        TextView textView = (TextView) rootView.findViewById(R.id.section_label);
        textView.setText(String.valueOf(getArguments().getInt(ARG_SECTION_NUMBER)));
        return rootView;
    }
}
