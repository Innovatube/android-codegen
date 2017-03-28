package <%= package_name %>.ui.<%= sub_package_name %>;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.SwitchCompat;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;

import <%= package_name %>.R;
import <%= package_name %>.data.models.<%= model.capitalize %>;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import io.reactivex.subjects.PublishSubject;

/**
 * Created by quanlt on 3/23/17.
 */



public class List<%= model.capitalize %>Adapter extends RecyclerView.Adapter<List<%= model.capitalize %>Adapter.ViewHolder> {
    private List<<%= model.capitalize %>> <%= to_lower_camel_case(model) %>s;

    public List<%= model.capitalize %>Adapter() {
        this.<%= to_lower_camel_case(model) %>s = new ArrayList<>();
    }

    PublishSubject<Integer> onButtonBidClick = PublishSubject.create();

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        LayoutInflater inflater = LayoutInflater.from(parent.getContext());
        View view = inflater.inflate(R.layout.list_<%= to_snake_case(model) %>_item, parent,false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ViewHolder holder, int position) {
        <%= model.capitalize %> <%= to_lower_camel_case(model) %> = <%= to_lower_camel_case(model) %>s.get(position);
    }
    @Override
    public int getItemCount() {
        return <%= to_lower_camel_case(model) %>s.size();
    }

    public void set<%= model.capitalize %>List(List<<%= model.capitalize %>> modelList) {
        this.<%= to_lower_camel_case(model) %>s = modelList;
        notifyItemRangeChanged(0, modelList.size());
    }

    public class ViewHolder extends RecyclerView.ViewHolder {
        <% attributes.each do |key,attribute| %>
          <% if attribute == 'TextView' %>
        @BindView(R.id.text_<%= to_snake_case(key) %>)
        TextView m<%= key.capitalize %>TextView;
          <% end %>
          <% if attribute == 'EditText' %>
        @BindView(R.id.edit_<%= to_snake_case(key) %>)
        EditText m<%= key.capitalize %>EditText;
          <% end %>
          <% if attribute == 'ImageView' %>
        @BindView(R.id.image_<%= to_snake_case(key) %>)
        ImageView m<%= key.capitalize %>ImageView;
          <% end %>
          <% if attribute == 'SwitchCompat' %>
        @BindView(R.id.switch_<%= to_snake_case(key) %>)
        SwitchCompat m<%= key.capitalize %>SwitchCompat;
          <% end %>
        <% end %>
        public ViewHolder(View itemView) {
            super(itemView);
            ButterKnife.bind(this, itemView);
        }
    }
}
