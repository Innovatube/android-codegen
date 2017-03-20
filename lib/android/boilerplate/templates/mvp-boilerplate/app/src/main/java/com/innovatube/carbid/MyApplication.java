package <%= package_name %>;

import android.app.Application;
import android.content.Context;
import android.support.v7.app.AppCompatDelegate;

import <%= package_name %>.injection.component.ApplicationComponent;
import <%= package_name %>.injection.component.DaggerApplicationComponent;
import <%= package_name %>.injection.module.ApplicationModule;

import io.realm.Realm;
import io.realm.RealmConfiguration;

public class MyApplication extends Application {
    static {
        AppCompatDelegate.setCompatVectorFromResourcesEnabled(true);
    }

    private ApplicationComponent mApplicationComponent;

    public static MyApplication get(Context context) {
        return (MyApplication) context.getApplicationContext();
    }

    @Override
    public void onCreate() {
        super.onCreate();
        RealmConfiguration realmConfiguration = new RealmConfiguration.Builder(this)
                .deleteRealmIfMigrationNeeded()
                .build();
        Realm.setDefaultConfiguration(realmConfiguration);
    }

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
    }

    public synchronized ApplicationComponent getComponent() {
        if (mApplicationComponent == null) {
            mApplicationComponent = DaggerApplicationComponent.builder()
                    .applicationModule(new ApplicationModule(this))
                    .build();
        }
        return mApplicationComponent;
    }
}
