package quanlt.com.injection.component;

import android.app.Application;
import android.content.Context;

import quanlt.com.data.DataManager;
import quanlt.com.data.remote.RetrofitService;
import quanlt.com.injection.ApplicationContext;
import quanlt.com.injection.module.ApplicationModule;
import quanlt.com.ui.fcm.FirebaseMessagingService;

import javax.inject.Singleton;

import dagger.Component;
import io.realm.Realm;
import retrofit2.Retrofit;

/**
 * Created by TOIDV on 4/4/2016.
 */

@Singleton
@Component(modules = ApplicationModule.class)
public interface ApplicationComponent {

    @ApplicationContext
    Context context();

    Application application();

    Retrofit retrofit();

    RetrofitService inploiService();

    DataManager dataManager();

    Realm realm();

    void inject(FirebaseMessagingService firebaseMessagingService);
}
