package com.orot.ody.ad.pangle

import android.app.Activity
import android.content.Context
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import com.bytedance.sdk.openadsdk.api.banner.PAGBannerAd
import com.bytedance.sdk.openadsdk.api.banner.PAGBannerRequest
import com.bytedance.sdk.openadsdk.api.banner.PAGBannerSize
import com.bytedance.sdk.openadsdk.api.interstitial.PAGInterstitialAd
import com.bytedance.sdk.openadsdk.api.interstitial.PAGInterstitialRequest
import com.orot.ody.ad.AdvertiseListener
import com.orot.ody.ad.BaseView
import com.orot.ody.ad.channelPangleBanner
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.platform.PlatformView

class PangleBannerView(
    private val context: Context,
    private val binaryMessenger: BinaryMessenger,
) : PlatformView, BaseView() {

    override fun getView(): ViewGroup = getLayout(context)
    override fun dispose() {}

    override val eventChannel: String get() = channelPangleBanner
    override var bindingAdView: View? = null

    lateinit var channel: EventChannel
    private var eventSink: EventChannel.EventSink? = null

    init {
        createChannel()
        PangleHelper.run {
            initialize(context)
            loadBannerAd(
                "980568720", getBannerRequest(PAGBannerSize.BANNER_W_320_H_50),
                advertiseListener = object : AdvertiseListener<PAGBannerAd?> {
                    override fun onAdLoaded(ad: PAGBannerAd?) {
                        Toast.makeText(context, "onAdLoaded", Toast.LENGTH_SHORT).show()
                        applyBindingViewH50(context, layout = view)
                        ad?.run { view.addView(bannerView) }
                    }

                    override fun onAdFailed(msg: String) {
                        Toast.makeText(context, "onAdFailed : $msg", Toast.LENGTH_SHORT).show()
                    }

                    override fun onAdClick() {
                        Toast.makeText(context, "onAdClick", Toast.LENGTH_SHORT).show()
                    }

                    override fun onAdShow() {
                        Toast.makeText(context, "onAdShow", Toast.LENGTH_SHORT).show()
                    }

                    override fun onAdDismiss() {
                        Toast.makeText(context, "onAdDismiss", Toast.LENGTH_SHORT).show()
                    }
                }
            )
        }
    }

    /** Flutter 측에서 Native 코드와 통신할 채널 */
    private fun createChannel() {
        channel = EventChannel(
            binaryMessenger,
            eventChannel
        ).apply {
            setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    eventSink = events
                }

                override fun onCancel(arguments: Any?) {
                    eventSink = null
                }
            })
        }
    }
}