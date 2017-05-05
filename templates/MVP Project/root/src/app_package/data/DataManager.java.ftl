package ${packageName}.data;

import ${packageName}.data.local.PreferenceHelper;
import ${packageName}.data.local.RealmHelper;
import ${packageName}.data.remote.RetrofitService;

import javax.inject.Inject;
import javax.inject.Singleton;

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
