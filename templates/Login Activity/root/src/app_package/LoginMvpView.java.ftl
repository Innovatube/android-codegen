package ${packageName};
<#if applicationPackage??>
import ${applicationPackage}.ui.base.BaseMvpView;
</#if>
/**
 * Created by quanlt on 3/16/17.
 */

public interface ${featureName}MvpView extends BaseMvpView {

}
