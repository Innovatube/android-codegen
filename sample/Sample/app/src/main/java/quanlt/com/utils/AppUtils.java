package quanlt.com.utils;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;

import com.afollestad.materialdialogs.MaterialDialog;
import quanlt.com.consts.Consts;
import quanlt.com.data.model.ApiError;

import java.io.IOException;
import java.lang.annotation.Annotation;
import java.net.ConnectException;
import java.net.SocketTimeoutException;
import java.net.UnknownHostException;

import okhttp3.ResponseBody;
import retrofit2.Converter;
import retrofit2.Retrofit;
import retrofit2.adapter.rxjava.HttpException;

/**
 * Created by TOIDV on 4/5/2016.
 */
public class AppUtils {
    public static final String ANNUAL_PATTERN = "#,###,###,###";
    public static final String HOURLY_PATTERN = "#,###,###,##0.00";
    private static final String CLOUDINARY_BASE_URL = "http://res.cloudinary.com/chris-mackie/";

    public static boolean isConnectivityAvailable(Context context) {
        ConnectivityManager conn = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo info = conn.getActiveNetworkInfo();
        return info != null && info.isAvailable() && info.isConnectedOrConnecting();
    }

    public static MaterialDialog createProgress(Context context, String title) {
        return new MaterialDialog.Builder(context)
                .title(title)
                .content("Please wait")
                .progress(true, 0)
                .build();
    }

    public static MaterialDialog createAlertDialog(Context context, String title) {
        return new MaterialDialog.Builder(context)
                .title(title)
                .positiveText("OK")
                .build();
    }
}
