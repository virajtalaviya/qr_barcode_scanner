package com.app.qrbarscanner

// android/app/src/main/kotlin/your/package/name/MyNativeAdFactory.kt

import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin.NativeAdFactory
import android.content.Context
import android.view.LayoutInflater
import android.widget.TextView
import android.widget.ImageView
import android.widget.Button
import com.google.android.gms.ads.nativead.MediaView

import com.app.qrbarscanner.R

class MyNativeAdFactory(private val context: Context) : NativeAdFactory {

    override fun createNativeAd(
        nativeAd: NativeAd,
        customOptions: MutableMap<String, Any>?
    ): NativeAdView {
        val adView = LayoutInflater.from(context)
            .inflate(R.layout.my_native_ad_layout, null) as NativeAdView

        // Get the views from the layout
        val headlineView = adView.findViewById<TextView>(R.id.ad_headline)
        val bodyView = adView.findViewById<TextView>(R.id.ad_body)
        val callToActionView = adView.findViewById<Button>(R.id.ad_call_to_action)
        val iconView = adView.findViewById<ImageView>(R.id.ad_app_icon)
        val mediaView = adView.findViewById<MediaView>(R.id.ad_media)
        val advertiserView = adView.findViewById<TextView>(R.id.ad_advertiser)

        // Associate the NativeAd object with the NativeAdView.
        adView.setNativeAd(nativeAd)

        // Populate the views with ad assets
        headlineView.text = nativeAd.headline
        adView.headlineView = headlineView

        if (nativeAd.body == null) {
            bodyView.visibility = android.view.View.INVISIBLE
        } else {
            bodyView.visibility = android.view.View.VISIBLE
            bodyView.text = nativeAd.body
            adView.bodyView = bodyView
        }

        if (nativeAd.callToAction == null) {
            callToActionView.visibility = android.view.View.INVISIBLE
        } else {
            callToActionView.visibility = android.view.View.VISIBLE
            callToActionView.text = nativeAd.callToAction
            adView.callToActionView = callToActionView
        }

        if (nativeAd.icon == null) {
            iconView.visibility = android.view.View.GONE
        } else {
            iconView.setImageDrawable(nativeAd.icon?.drawable)
            iconView.visibility = android.view.View.VISIBLE
            adView.iconView = iconView
        }

        if (nativeAd.mediaContent != null) {
            mediaView.setMediaContent(nativeAd.mediaContent!!)
            mediaView.visibility = android.view.View.VISIBLE
            adView.mediaView = mediaView
        } else {
            mediaView.visibility = android.view.View.GONE
        }


        if (nativeAd.advertiser == null) {
            advertiserView.visibility = android.view.View.INVISIBLE
        } else {
            advertiserView.text = nativeAd.advertiser
            advertiserView.visibility = android.view.View.VISIBLE
            adView.advertiserView = advertiserView
        }

        return adView
    }
}