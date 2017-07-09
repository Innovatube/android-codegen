package ${packageName};
<#if applicationPackage??>
import ${applicationPackage}.ui.base.BasePresenter;
</#if>
import javax.inject.Inject;

public class ${featureName}Presenter extends BasePresenter<${featureName}MvpView> {
    @Inject
    public ${featureName}Presenter(){

    }
}
