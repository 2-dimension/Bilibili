package com.yaesakura.bilibili.ui.home.recommend;


import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.yaesakura.bilibili.R;
import com.yaesakura.bilibili.adapter.RecommendAdapter;
import com.yaesakura.bilibili.api.app.BilibiliAppAPI;
import com.yaesakura.bilibili.api.support.BilibiliCallback;
import com.yaesakura.bilibili.api.support.BilibiliResponse;
import com.yaesakura.bilibili.model.RecommendHome;
import com.yaesakura.bilibili.widget.extra.ExRecyclerView;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class RecommendFragment extends Fragment
{
    private View view;

    private List<RecommendHome> items;

    private RecommendAdapter adapter;

    @BindView(R.id.recyclerView) ExRecyclerView recyclerView;

    public RecommendFragment()
    {
        // Required empty public constructor
    }

    public static RecommendFragment newInstance()
    {
        RecommendFragment fragment = new RecommendFragment();
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);

        //Fetch homepage data then process asynchronously.
        BilibiliAppAPI.getRecommendHome(new BilibiliCallback<List<RecommendHome>>()
        {
            @Override
            public void onSuccess(List<RecommendHome> object, BilibiliResponse biliResponse)
            {
                //Setup Recycler View, then refresh UI on main thread.
                items = object;

                getActivity().runOnUiThread(new Runnable()
                {
                    @Override
                    public void run()
                    {
                        if (recyclerView != null && recyclerView.getAdapter() != null)
                        {
                            adapter.setItems(items);
                            adapter.notifyDataSetChanged();
                        }
                    }
                });
            }

            @Override
            public void onFailure(BilibiliResponse biliResponse) {}

        });

    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState)
    {
        if (view == null)
            view = inflater.inflate(R.layout.fragment_recommend, container, false);
        ButterKnife.bind(this, view);

        //Initialize Recycler View.
        if (recyclerView.getLayoutManager() == null)
            recyclerView.setLayoutManager(new LinearLayoutManager(getContext()));

        if (adapter == null)
        {
            adapter = new RecommendAdapter(getContext());
            recyclerView.setAdapter(adapter);
        }

        return view;
    }
}
