package ${packageName};

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
<#if applicationPackage??>
import ${applicationPackage}.R;
</#if>

public class ${fragmentClassName} extends Fragment {

    private static final String ARG_SECTION_NUMBER = "section_number";

    public ${fragmentClassName}() {
    }

    public static ${fragmentClassName} newInstance(int sectionNumber) {
        ${fragmentClassName} fragment = new ${fragmentClassName}();
        Bundle args = new Bundle();
        args.putInt(ARG_SECTION_NUMBER, sectionNumber);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.${fragmentLayoutName}, container, false);
        TextView textView = (TextView) rootView.findViewById(R.id.section_label);
        textView.setText(getString(R.string.section_format, getArguments().getInt(ARG_SECTION_NUMBER)));
        return rootView;
    }
}