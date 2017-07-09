package ${packageName}.data.remote;

import android.content.Context;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import ${packageName}.R;

import java.io.File;
import java.io.IOException;

import okhttp3.Cache;
import okhttp3.Interceptor;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import okhttp3.logging.HttpLoggingInterceptor;
import retrofit2.Retrofit;
<#if rxVersion == 'rxJava2'>
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory;
<#else>
import retrofit2.adapter.rxjava.RxJavaCallAdapterFactory;
</#if>
import retrofit2.converter.gson.GsonConverterFactory;

/**
 * Created by TOIDV on 4/4/2016.
 */
public interface RetrofitService {


    class Creator {

        private static Interceptor cacheInterceptor;

        public static Retrofit newRetrofitInstance(final Context context, final boolean isNetworkAvailable) {

            cacheInterceptor = new Interceptor() {
                @Override
                public Response intercept(Interceptor.Chain chain) throws IOException {
                    Request request = chain.request();
                    if (!isNetworkAvailable) {
                        int maxStale = 60 * 60 * 24 * 28; // tolerate 4-weeks stale
                        request.newBuilder()
                                .removeHeader("Pragma")
                                .removeHeader("Cache-Control")
                                .header("Cache-Control", "public, only-if-cached, max-stale=" + maxStale)
                                .build();
                    }
                    Response originalResponse = chain.proceed(request);
                    return originalResponse;
                }
            };
            HttpLoggingInterceptor interceptor = new HttpLoggingInterceptor();
            interceptor.setLevel(HttpLoggingInterceptor.Level.BODY);

            //Setup cache
            File httpCacheDirectory = new File(context.getCacheDir().getAbsolutePath(), "OKHttpCache");
            int cacheSize = 10 * 1024 * 1024; // 10 MiB
            Cache cache = new Cache(httpCacheDirectory, cacheSize);

            OkHttpClient client = new OkHttpClient.Builder()
                    .addNetworkInterceptor(cacheInterceptor)
                    .cache(cache)
                    .addInterceptor(interceptor)
                    .build();
            Gson gson = new GsonBuilder()
                    .setDateFormat("yyyy-MM-dd'T'HH:mm:SSS'Z'")
                    .create();

            String ENDPOINT = context.getResources().getString(R.string.api_end_point);

            Retrofit retrofit = new Retrofit.Builder()
                    .baseUrl(ENDPOINT)
                    .addConverterFactory(GsonConverterFactory.create(gson))
                    <#if rxVersion == 'rxJava2'>
                    .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
                    <#else>
                    .addCallAdapterFactory(RxJavaCallAdapterFactory.create())
                    </#if>
                    .client(client)
                    .build();

            return retrofit;
        }
    }
}
