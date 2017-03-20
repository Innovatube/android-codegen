package jo.data;

import jo.data.local.PreferenceHelper;
import jo.data.local.RealmHelper;
import jo.data.remote.RetrofitService;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.inject.Singleton;

import rx.Observable;

/**
 * Created by TOIDV on 4/5/2016.
 */

@Singleton
public class DataManager {
    private final RetrofitService retrofitService;
    private final PreferenceHelper preferenceHelper;
    private final RealmHelper realmHelper;

    @Inject
    public DataManager(RetrofitService retrofitService, PreferenceHelper preferenceHelper, RealmHelper realmHelper) {
        this.retrofitService = retrofitService;
        this.preferenceHelper = preferenceHelper;
        this.realmHelper = realmHelper;
    }
}
