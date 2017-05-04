package ${packageName};
<#if applicationPackage??>
import ${applicationPackage}.ui.base.BaseMvpView;
</#if>

public interface ${viewName} <#if useBaseClass>extends BaseMvpView</#if>{

}
