package com.yaesakura.bilibili.ui.home.live;


import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.yaesakura.bilibili.R;
import com.yaesakura.bilibili.adapter.LiveAdapter;
import com.yaesakura.bilibili.api.app.BilibiliAppAPI;
import com.yaesakura.bilibili.api.support.BilibiliCallback;
import com.yaesakura.bilibili.api.support.BilibiliResponse;
import com.yaesakura.bilibili.model.LiveHome;
import com.yaesakura.bilibili.widget.extra.ExRecyclerView;

import butterknife.BindView;
import butterknife.ButterKnife;

public class LiveFragment extends Fragment
{
    private View view;

    private LiveHome data;
    private LiveAdapter adapter;

    @BindView(R.id.recyclerView) ExRecyclerView recyclerView;

    public LiveFragment()
    {
        // Required empty public constructor
    }

    public static LiveFragment newInstance(String param1, String param2)
    {
        LiveFragment fragment = new LiveFragment();
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);

        BilibiliAppAPI.getLiveHome(new BilibiliCallback<LiveHome>()
        {
            @Override
            public void onSuccess(LiveHome object, BilibiliResponse biliResponse)
            {
                data = object;

                getActivity().runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        adapter.setLiveHomeData(data);
                        adapter.notifyDataSetChanged();
                    }
                });
            }

            @Override
            public void onFailure(BilibiliResponse biliResponse){}
        });
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState)
    {
        if (view == null)
            view = inflater.inflate(R.layout.fragment_live, container, false);
        ButterKnife.bind(this, view);

        //Initialize RecyclerView.
        if (recyclerView.getLayoutManager() == null)
            recyclerView.setLayoutManager(new LinearLayoutManager(getContext()));

        if (adapter == null)
        {
            adapter = new LiveAdapter(getContext());
            recyclerView.setAdapter(adapter);
        }


        return view;
    }

}
