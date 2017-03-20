package quanlt.com.injection.component;

import quanlt.com.injection.PerActivity;
import quanlt.com.injection.module.ActivityModule;

import quanlt.com.ui.home.HomeActivity;
import quanlt.com.ui.login.LoginActivity;

import dagger.Component;

/**
 * Created by TOIDV on 4/4/2016.
 */

@PerActivity
@Component(dependencies = ApplicationComponent.class, modules = ActivityModule.class)

public interface ActivityComponent {

    void inject(LoginActivity i);

    void inject(HomeActivity i);

}
