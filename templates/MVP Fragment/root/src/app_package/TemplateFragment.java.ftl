package ${packageName};

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
<#if includeRecycler>
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.LinearLayoutManager;
</#if>

<#if applicationPackage??>
import ${applicationPackage}.R;
import ${applicationPackage}.ui.base.BaseDialogFragment;
</#if>

import javax.inject.Inject;
import butterknife.BindView;

import butterknife.ButterKnife;

public class ${className} extends BaseDialogFragment implements ${featureName}MvpView {

    <#if includeRecycler>
    @BindView(R.id.recyclerview)
    RecyclerView mRecyclerView;
    ${adapterName} m${adapterName};
    </#if>

    @Inject
    ${featureName}Presenter m${featureName}Presenter;

    public static ${className} newInstance() {

        Bundle args = new Bundle();

        ${className} fragment = new ${className}();
        fragment.setArguments(args);
        return fragment;
    }


    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getActivityComponent().inject(this);
        m${featureName}Presenter.attachView(this);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.${layoutName}, container,false);
        ButterKnife.bind(this,view);
        <#if includeRecycler>
        m${adapterName} = new ${adapterName}();
        mRecyclerView.setLayoutManager(new LinearLayoutManager(getActivity()));
        mRecyclerView.setAdapter(m${adapterName});
        </#if>
        return view;
    }

    @Override
    protected void setupDialogTitle() {

    }
}
