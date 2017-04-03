package <%= package_name %>.data;

import <%= package_name %>.data.local.PreferenceHelper;
import <%= package_name %>.data.local.RealmHelper;
import <%= package_name %>.data.remote.RetrofitService;

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
