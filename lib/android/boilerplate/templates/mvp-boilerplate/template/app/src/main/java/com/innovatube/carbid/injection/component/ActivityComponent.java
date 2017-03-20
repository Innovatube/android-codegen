package <%=  package_name %>.injection.component;

import <%=  package_name %>.injection.PerActivity;
import <%=  package_name %>.injection.module.ActivityModule;

import <%=  package_name %>.ui.home.HomeActivity;
import <%=  package_name %>.ui.login.LoginActivity;

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
