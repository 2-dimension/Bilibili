package com.yaesakura.bilibili.ui.root;

import android.os.Bundle;

import com.yaesakura.bilibili.R;
import com.yaesakura.bilibili.ui.attention.AttentionFragment;
import com.yaesakura.bilibili.ui.categories.CategoriesFragment;
import com.yaesakura.bilibili.ui.discover.DiscoverFragment;
import com.yaesakura.bilibili.ui.home.HomeFragment;
import com.yaesakura.bilibili.ui.profile.ProfileFragment;
import com.yaesakura.bilibili.widget.tabbar.Tab;
import com.yaesakura.bilibili.widget.tabbar.TabBarActivity;


public class MainActivity extends TabBarActivity
{

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

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

}
