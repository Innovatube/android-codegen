package jo.injection.component;

import jo.injection.PerActivity;
import jo.injection.module.ActivityModule;

import jo.ui.home.HomeActivity;
import jo.ui.login.LoginActivity;

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
