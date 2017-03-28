package <%= package_name %>.ui.<%= sub_package_name %>;
import <%= package_name %>.data.DataManager;
import <%= package_name %>.data.models.<%= model.capitalize %>;
import <%= package_name %>.ui.base.BasePresenter;

import java.util.Arrays;

import javax.inject.Inject;

import retrofit2.Retrofit;

/**
 * Created by quanlt on 3/23/17.
 */


public class List<%= model.capitalize %>Presenter extends BasePresenter<List<%= model.capitalize %>Mvp> {
    private final DataManager mDataManager;
    private final Retrofit mRetrofit;

    @Inject
    public List<%= model.capitalize %>Presenter(DataManager mDataManager, Retrofit mRetrofit) {
        this.mDataManager = mDataManager;
        this.mRetrofit = mRetrofit;
    }

    public void getModels(){
        //TODO get Model from DataManager
        getMvpView().updateListModel(Arrays.asList(new <%= model.capitalize %>()));
    }


}
