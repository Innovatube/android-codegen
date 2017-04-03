package <%= package_name %>.ui.<%= sub_package_name %>;

import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import <%= package_name %>.R;
import <%= package_name %>.data.models.<%= model.capitalize %>;
import <%= package_name %>.ui.base.BaseDialogFragment;

import java.util.List;

import javax.inject.Inject;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by quanlt on 3/23/17.
 */






public class List<%= model.capitalize %>Fragment extends BaseDialogFragment implements List<%= model.capitalize %>Mvp {
    @BindView(R.id.recycler_list_<%= to_snake_case(model) %>)
    RecyclerView m<%= model.capitalize %>RecyclerView;
    private List<%= model.capitalize %>Adapter mModelAdapter;
    @Inject
    List<%= model.capitalize %>Presenter mModelPresenter;

    @Override

    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.fragment_list_<%= to_snake_case(model) %>, container, false);
        ButterKnife.bind(this, rootView);
//        getActivityComponent().inject(this);
        mModelPresenter.attachView(this);
        mModelAdapter = new List<%= model.capitalize %>Adapter();
        m<%= model.capitalize %>RecyclerView.setLayoutManager(new LinearLayoutManager(getActivity()));
        m<%= model.capitalize %>RecyclerView.setAdapter(mModelAdapter);
        mModelPresenter.getModels();
        return rootView;
    }

    @Override
    protected void setupDialogTitle() {

    }


    @Override
    public void updateListModel(List<<%= model.capitalize %>> models) {
        mModelAdapter.set<%= model.capitalize %>List(models);
    }
}
