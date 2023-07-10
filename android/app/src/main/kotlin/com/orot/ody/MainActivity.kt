package com.orot.ody

import com.orot.ody.ad.pangle.PangleBannerViewFactory
import com.orot.ody.ad.pluginPangleBanner
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        initPangleBanner()
    }

    private fun initPangleBanner() {
        flutterEngine?.run {
            platformViewsController.registry.registerViewFactory(
                pluginPangleBanner, PangleBannerViewFactory(dartExecutor.binaryMessenger)
            )
        }
    }


}
