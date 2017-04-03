package <%= package_name %>.injection.component;

import android.app.Application;
import android.content.Context;

import <%= package_name %>.data.DataManager;
import <%= package_name %>.data.remote.RetrofitService;
import <%= package_name %>.injection.ApplicationContext;
import <%= package_name %>.injection.module.ApplicationModule;
import <%= package_name %>.ui.fcm.FirebaseMessagingService;

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
