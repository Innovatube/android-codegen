package ${packageName};
<#if applicationPackage??>
import ${applicationPackage}.ui.base.BaseMvpView;
</#if>

public interface ${featureName}MvpView extends BaseMvpView{
}
