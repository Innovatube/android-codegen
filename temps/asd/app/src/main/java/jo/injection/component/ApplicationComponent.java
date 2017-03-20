package jo.injection.component;

import android.app.Application;
import android.content.Context;

import jo.data.DataManager;
import jo.data.remote.RetrofitService;
import jo.injection.ApplicationContext;
import jo.injection.module.ApplicationModule;
import jo.ui.fcm.FirebaseMessagingService;

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
