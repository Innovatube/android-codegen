<?xml version="1.0" encoding="utf-8"?>
<ScrollView xmlns:android="http://schemas.android.com/apk/res/android"
            xmlns:app="http://schemas.android.com/apk/res-auto"
            xmlns:tools="http://schemas.android.com/tools"
            android:layout_width="match_parent"
            android:layout_height="match_parent"
            tools:context=".ui.template.login.LoginActivity">


    <LinearLayout
            android:layout_width="match_parent"
            android:layout_height="match_parent"
            android:orientation="vertical"
            android:paddingBottom="16dp">

        <ImageView
                android:layout_width="match_parent"
                android:layout_height="48dp"
                android:layout_margin="64dp" />
        <#if manualLogin>
        <LinearLayout
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:gravity="center_vertical"
                android:orientation="horizontal">

            <ImageView
                    android:layout_width="wrap_content"
                    android:layout_height="wrap_content"
                    android:padding="16dp" />

            <android.support.v7.widget.AppCompatEditText
                    android:id="@+id/edt_login_email"
                    android:layout_width="match_parent"
                    android:layout_height="wrap_content"
                    android:background="@android:color/transparent"
                    android:hint="Email"
                    android:inputType="textEmailAddress"
                    android:maxLines="1"
                    android:minHeight="48dp"
                    android:paddingRight="16dp"
                    android:textAppearance="@style/TextAppearance.AppCompat.Medium" />
        </LinearLayout>

        <View
                android:layout_width="match_parent"
                android:layout_height="0.5dp"
                android:background="@android:color/darker_gray" />

        <LinearLayout
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:gravity="center_vertical"
                android:orientation="horizontal">

            <ImageView
                    android:layout_width="wrap_content"
                    android:layout_height="wrap_content"
                    android:padding="16dp" />

            <android.support.design.widget.TextInputLayout
                    android:id="@+id/password_float_label"
                    android:layout_width="match_parent"
                    android:layout_height="wrap_content"
                    app:hintEnabled="false"
                    app:passwordToggleEnabled="true"
                    app:passwordToggleTint="?colorControlNormal">

                <android.support.design.widget.TextInputEditText
                        android:id="@+id/edt_login_password"
                        android:layout_width="match_parent"
                        android:layout_height="wrap_content"
                        android:background="@android:color/transparent"
                        android:hint="Password"
                        android:inputType="textPassword"
                        android:maxLines="1"
                        android:minHeight="48dp"
                        android:paddingRight="16dp"
                        android:selectAllOnFocus="true"
                        android:textAppearance="@style/TextAppearance.AppCompat.Medium" />

            </android.support.design.widget.TextInputLayout>
        </LinearLayout>

        <View
                android:layout_width="match_parent"
                android:layout_height="0.5dp"
                android:background="@android:color/darker_gray" />

        <android.support.v7.widget.AppCompatTextView
                android:id="@+id/txt_forgot_password"
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:background="?selectableItemBackground"
                android:clickable="true"
                android:gravity="end"
                android:padding="16dp"
                android:text="Forgot Password?" />

        <android.support.v7.widget.AppCompatButton
                android:id="@+id/btn_login"
                android:layout_width="216dp"
                android:layout_height="wrap_content"
                android:layout_gravity="center"
                android:background="@color/colorPrimary"
                android:text="Login"
                android:textColor="@android:color/white" />

        </#if>
        <#if loginWithGoogle||loginWithFacebook>
        <LinearLayout
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:layout_marginLeft="20dp"
                android:layout_marginRight="20dp"
                android:layout_marginTop="40dp"
                android:weightSum="2">

            <#if loginWithGoogle>
            <android.support.v7.widget.AppCompatButton
                    android:id="@+id/btn_login_google_plus"
                    android:layout_width="match_parent"
                    android:layout_height="wrap_content"
                    android:layout_gravity="center"
                    android:layout_marginRight="10dp"
                    android:layout_weight="1"
                    android:text="Login G+"
                    android:textColor="@android:color/white" />

            </#if>
            <#if loginWithFacebook>
            <android.support.v7.widget.AppCompatButton
                    android:id="@+id/btn_login_facebook"
                    android:layout_width="match_parent"
                    android:layout_height="wrap_content"
                    android:layout_weight="1"
                    android:text="Login Facebook" />
            </#if>
        </LinearLayout>
        </#if>
        <android.support.v7.widget.AppCompatTextView
                android:layout_width="216dp"
                android:layout_height="wrap_content"
                android:layout_gravity="center"
                android:layout_marginBottom="16dp"
                android:layout_marginTop="16dp"
                android:gravity="center"
                android:text="Don't have an account?" />
        <android.support.v7.widget.AppCompatTextView
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:layout_gravity="bottom"
                android:gravity="center"
                android:padding="12dp"
                android:textAppearance="@style/TextAppearance.AppCompat.Small"
                android:textSize="12sp" />
    </LinearLayout>
</ScrollView>
