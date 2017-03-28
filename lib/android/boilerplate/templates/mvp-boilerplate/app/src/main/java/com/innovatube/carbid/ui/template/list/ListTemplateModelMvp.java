package <%= package_name %>.ui.<%= sub_package_name %>;
import <%= package_name %>.data.models.<%= model.capitalize %>;
import <%= package_name %>.ui.base.BaseMvpView;

import java.util.List;

/**
 * Created by quanlt on 3/23/17.
 */



public interface List<%= model.capitalize %>Mvp extends BaseMvpView {
    void updateListModel(List<<%= model.capitalize %>> <%= to_lower_camel_case(model) %>s);
}
