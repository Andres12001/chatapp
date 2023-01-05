import 'package:admob_flutter/admob_flutter.dart';
import 'package:first_app/Constants/MainConstants.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

/*
Test Id's from:
https://developers.google.com/admob/ios/banner
https://developers.google.com/admob/android/banner

App Id - See README where these Id's go
Android: ca-app-pub-3940256099942544~3347511713
iOS: ca-app-pub-3940256099942544~1458002511

Banner
Android: ca-app-pub-3940256099942544/6300978111
iOS: ca-app-pub-3940256099942544/2934735716

Interstitial
Android: ca-app-pub-3940256099942544/1033173712
iOS: ca-app-pub-3940256099942544/4411468910

Reward Video
Android: ca-app-pub-3940256099942544/5224354917
iOS: ca-app-pub-3940256099942544/1712485313
*/

class AdmobClass {
  static final shared = AdmobClass();
  AdmobBannerSize? _bannerSize;
  late AdmobInterstitial _interstitialAd;

  AdmobClass() {
    if (!kIsWeb) {
      if (Platform.isIOS) Admob.requestTrackingAuthorization();
      _bannerSize = AdmobBannerSize.BANNER;

      _interstitialAd = AdmobInterstitial(
        adUnitId: _getInterstitialAdUnitId()!,
        listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
          if (event == AdmobAdEvent.closed) _interstitialAd.load();
        },
      );

      _interstitialAd.load();
    }
  }

  void showInitAd() async {
    if (MainConstants.adsEnabled && !kIsWeb) {
      if (Platform.isIOS) await Admob.requestTrackingAuthorization();
      final isLoaded = await _interstitialAd.isLoaded;
      if (isLoaded ?? false) {
        _interstitialAd.show();
      }
    }
  }

  Widget displayAdBanner() {
    if (MainConstants.adsEnabled && !kIsWeb) {
      return AdmobBanner(
        adUnitId: _getBannerAdUnitId()!,
        adSize: _bannerSize!,
        listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
          // handleEvent(event, args, 'Banner');
        },
        onBannerCreated: (AdmobBannerController controller) {
          // Dispose is called automatically for you when Flutter removes the banner from the widget tree.
          // Normally you don't need to worry about disposing this yourself, it's handled.
          // If you need direct access to dispose, this is your guy!
          // controller.dispose();
        },
      );
    } else {
      return Container();
    }
  }

  String? _getBannerAdUnitId() {
    if (Platform.isIOS) {
      return MainConstants.bannerIdIos;
    } else if (Platform.isAndroid) {
      return MainConstants.bannerIdAndroid;
    }
    return null;
  }

  String? _getInterstitialAdUnitId() {
    if (Platform.isIOS) {
      return MainConstants.initAdsIos;
    } else if (Platform.isAndroid) {
      return MainConstants.initAdsAndroid;
    }
    return null;
  }
}
