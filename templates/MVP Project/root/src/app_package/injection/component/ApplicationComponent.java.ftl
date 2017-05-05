package ${packageName}.injection.component;

import android.app.Application;
import android.content.Context;

import ${packageName}.data.DataManager;
import ${packageName}.data.remote.RetrofitService;
import ${packageName}.injection.ApplicationContext;
import ${packageName}.injection.module.ApplicationModule;
import ${packageName}.ui.fcm.FirebaseMessagingService;

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
