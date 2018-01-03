package com.lunareclipse.bilibili.ui.root;

import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;

import android.provider.Settings;
import android.view.KeyEvent;
import com.facebook.react.ReactInstanceManager;
import com.lunareclipse.bilibili.R;
import com.lunareclipse.bilibili.misc.react.ReactNativeManager;
import com.lunareclipse.bilibili.ui.attention.AttentionFragment;
import com.lunareclipse.bilibili.ui.categories.CategoriesFragment;
import com.lunareclipse.bilibili.ui.discover.DiscoverFragment;
import com.lunareclipse.bilibili.ui.home.HomeFragment;
import com.lunareclipse.bilibili.ui.profile.ProfileFragment;
import com.lunareclipse.bilibili.widget.tabbar.Tab;
import com.lunareclipse.bilibili.widget.tabbar.TabBarActivity;


public class MainActivity extends TabBarActivity
{

    private ReactInstanceManager mReactInstanceManager;

    public final static int OVERLAY_PERMISSION_REQ_CODE = 5463 & 0xffffff00;

    @Override
    protected Tab[] tabs()
    {
        String home = getString(R.string.tabbar_home);
        String categories = getString(R.string.tabbar_categories);
        String attention = getString(R.string.tabbar_attention);
        String discover = getString(R.string.tabbar_discover);
        String profile = getString(R.string.tabbar_profile);

        return new Tab[] {
                new Tab(home, HomeFragment.class, R.drawable.tab_icon_explore, R.color.tabbar_text),
                new Tab(categories, CategoriesFragment.class, R.drawable.tab_icon_explore, R.color.tabbar_text),
                new Tab(attention, AttentionFragment.class, R.drawable.tab_icon_explore, R.color.tabbar_text),
                new Tab(discover, DiscoverFragment.class, R.drawable.tab_icon_explore, R.color.tabbar_text),
                new Tab(profile, ProfileFragment.class, R.drawable.tab_icon_profile, R.color.tabbar_text)
        };
    }

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        checkOverlayPermission();

        mReactInstanceManager = ReactNativeManager.instanceManager;
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == OVERLAY_PERMISSION_REQ_CODE) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                if (!Settings.canDrawOverlays(this)) {
                    // SYSTEM_ALERT_WINDOW permission not granted...
                }
            }
        }
    }

    @Override
    public boolean onKeyUp(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_MENU && mReactInstanceManager != null) {
            mReactInstanceManager.showDevOptionsDialog();
            return true;
        }
        return super.onKeyUp(keyCode, event);
    }


    private void checkOverlayPermission()
    {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (!Settings.canDrawOverlays(this)) {
                Intent intent = new Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION,
                        Uri.parse("package:" + getPackageName()));
                startActivityForResult(intent, OVERLAY_PERMISSION_REQ_CODE);
            }
        }
    }

}
