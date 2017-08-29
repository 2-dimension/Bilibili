package com.lunareclipse.bilibili.misc.react;

import com.facebook.react.ReactInstanceManager;
import com.facebook.react.common.LifecycleState;
import com.facebook.react.shell.MainReactPackage;
import com.lunareclipse.bilibili.App;
import com.lunareclipse.bilibili.BuildConfig;

/**
 * Created by LunarEclipse on 2017/8/22.
 */

public class ReactNativeManager
{
    public static ReactInstanceManager instanceManager = ReactInstanceManager.builder()
            .setApplication(App.getInstance())
            .setBundleAssetName("index.android.bundle")
            .setJSMainModuleName("index.android")
            .addPackage(new MainReactPackage())
            .setUseDeveloperSupport(BuildConfig.DEBUG)
            .setInitialLifecycleState(LifecycleState.RESUMED)
            .build();
}
