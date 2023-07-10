package com.orot.ody.ad

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import com.orot.ody.R
import org.json.JSONObject

abstract class BaseView {

    abstract var bindingAdView: View?
    abstract val eventChannel: String

    fun getLayout(context: Context): ViewGroup = LinearLayout(context).apply {
        layoutParams = LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.MATCH_PARENT,
            LinearLayout.LayoutParams.WRAP_CONTENT
        )
        orientation = LinearLayout.VERTICAL
    }

    fun jsonToMap(jsonObject: JSONObject): Map<String, String> {
        val map: MutableMap<String, String> = HashMap()
        val keysIterator = jsonObject.keys()
        while (keysIterator.hasNext()) {
            val key = keysIterator.next()
            val value = jsonObject[key]
            map[key] = value.toString()
        }
        return map
    }



    fun applyBindingViewH50(context: Context, layout: ViewGroup) {
        if (bindingAdView != null) return

        bindingAdView = LayoutInflater.from(context).inflate(
            R.layout.item_banner_h50,
            layout, false
        )

        layout.removeAllViews()
        layout.addView(bindingAdView)
    }

}