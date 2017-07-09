package ${packageName};
<#if applicationPackage??>
import ${applicationPackage}.data.DataManager;
import ${applicationPackage}.ui.base.BasePresenter;
</#if>
import javax.inject.Inject;

public class ${featureName}Presenter extends BasePresenter<${featureName}MvpView> {
    private final DataManager mDataManager;

    @Inject
    public ${featureName}Presenter(DataManager dataManager) {
        this.mDataManager = dataManager;
    }
}
