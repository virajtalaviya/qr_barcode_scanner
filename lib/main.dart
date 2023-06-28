import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_scanner/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return AppLifeCycle(
      child: const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

class AppLifeCycle extends StatefulWidget {
  const AppLifeCycle({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<AppLifeCycle> createState() => _AppLifeCycleState();
}

class _AppLifeCycleState extends State<AppLifeCycle> with WidgetsBindingObserver {
  AppOpenAdManager appOpenAdManager = AppOpenAdManager();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.detached:
        print("----   show 5");
        break;
      case AppLifecycleState.inactive:
        print("----   show 6");
        break;
      case AppLifecycleState.paused:
        print("----   show 7");
        break;
      case AppLifecycleState.resumed:
        print("----   show 3");
        if (appOpenAdManager.appOpenAd != null) {
          print("----   show 4");
          appOpenAdManager.appOpenAd?.show();
        }
        break;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class AppOpenAdManager {
  AppOpenAdManager() {
    print("----   load 1");
    loadAppOpenAd();
  }

  int failAttempt = 0;
  AppOpenAd? appOpenAd;
  bool isShowingAd = false;

  bool get isAdAvailable {
    return appOpenAd != null;
  }

  /// Load an AppOpenAd.
  void loadAppOpenAd() {
    AppOpenAd.load(
      adUnitId: "ca-app-pub-3940256099942544/3419835294",
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          print("----   load 2");
          appOpenAd = ad;
          appOpenAd?.fullScreenContentCallback = FullScreenContentCallback(
            onAdFailedToShowFullScreenContent: (ad, error) {},
            onAdDismissedFullScreenContent: (ad) {
              appOpenAd?.dispose();
              appOpenAd = null;
              loadAppOpenAd();
            },
            onAdClicked: (ad) {},
            onAdImpression: (ad) {},
            onAdShowedFullScreenContent: (ad) {},
            onAdWillDismissFullScreenContent: (ad) {},
          );
        },
        onAdFailedToLoad: (error) {
          failAttempt++;
          if (failAttempt <= 3) {
            loadAppOpenAd();
            Future.delayed(
              const Duration(seconds: 10),
              () {
                failAttempt = 0;
              },
            );
          }
        },
      ),
      orientation: AppOpenAd.orientationPortrait,
    );
  }
}
