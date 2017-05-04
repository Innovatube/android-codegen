package ${packageName};
<#if applicationPackage??>
import ${applicationPackage}.ui.base.BasePresenter;
</#if>

/**
 * Created by quanlt on 4/30/17.
 */

public class ${presenterName} <#if useBaseClass>extends BasePresenter<${viewName}></#if>{

}
