package ${packageName};
<#if applicationPackage??>
import ${applicationPackage}.ui.base.MvpView;
</#if>
public interface ${featureName}MvpView extends MvpView {
}
