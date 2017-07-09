package ${packageName};
<#if applicationPackage??>
import ${applicationPackage}.ui.base.BasePresenter;
</#if>
import javax.inject.Inject;

public class ${presenterName} <#if useBaseClass>extends BasePresenter<${viewName}></#if>{
    @Inject
    public ${presenterName}(){

    }
}
