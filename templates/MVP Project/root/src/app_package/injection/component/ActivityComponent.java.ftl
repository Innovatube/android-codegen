package ${packageName}.injection.component;

import ${packageName}.injection.PerActivity;
import ${packageName}.injection.module.ActivityModule;

import dagger.Component;

/**
 * Created by TOIDV on 4/4/2016.
 */

@PerActivity
@Component(dependencies = ApplicationComponent.class, modules = ActivityModule.class)

public interface ActivityComponent {



}
