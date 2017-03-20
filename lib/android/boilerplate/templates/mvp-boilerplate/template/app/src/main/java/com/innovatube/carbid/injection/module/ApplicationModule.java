package <%=  package_name %>.injection.module;

import android.app.Application;
import android.content.Context;

import <%=  package_name %>.data.local.RealmHelper;
import <%=  package_name %>.data.remote.RetrofitService;
import <%=  package_name %>.injection.ApplicationContext;
import <%=  package_name %>.utils.AppUtils;

import javax.inject.Singleton;

import dagger.Module;
import dagger.Provides;
import io.realm.Realm;
import retrofit2.Retrofit;

/**
 * Created by TOIDV on 4/4/2016.
 */

@Module
public class ApplicationModule {
    protected final Application mApplication;

    public ApplicationModule(Application application) {
        mApplication = application;
    }

    @Provides
    Application provideApplication() {
        return mApplication;
    }

    @Provides
    @ApplicationContext
    Context provideApplicationContext() {
        return mApplication;
    }

    @Provides
    @Singleton
    RetrofitService provideInnovatubeService(Retrofit retrofit) {
        return retrofit.create(RetrofitService.class);
    }

    @Provides
    RealmHelper provideRealmHelper() {
        return new RealmHelper();
    }

    @Provides
    @Singleton
    Retrofit provideRetrofitInstance() {
        return RetrofitService.Creator.newRetrofitInstance(mApplication.getApplicationContext(),
                AppUtils.isConnectivityAvailable(mApplication.getApplicationContext()));
    }

    @Provides
    @Singleton
    Realm provideRealm() {
        return Realm.getDefaultInstance();
    }
}
