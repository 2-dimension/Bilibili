package com.yaesakura.bilibili.adapter.base;

import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

/**
 * Created by YaeSakura on 16/8/29.
 */
public abstract class ReuseAdapter<T extends View> extends BaseAdapter
{
    public abstract T onCreateViewHolder(ViewGroup parent);
    public abstract void onReuse(T holder, int position);

    @Override
    public Object getItem(int position)
    {
        return null;
    }

    @Override
    public long getItemId(int position)
    {
        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent)
    {
        final T holder;

        if (convertView == null)
        {
            holder = onCreateViewHolder(parent);
            convertView.setTag(holder);
        }
        else holder = (T) convertView.getTag();

        onReuse(holder, position);

        return null;
    }
}
