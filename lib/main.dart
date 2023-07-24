import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_scanner/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (_) {}

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
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
    // return const AppLifeCycle(
    //   child: GetMaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     home: SplashScreen(),
    //   ),
    // );
  }
}

///--- app life cycle
// class AppLifeCycle extends StatefulWidget {
//   const AppLifeCycle({Key? key, required this.child}) : super(key: key);
//   final Widget child;
//
//   @override
//   State<AppLifeCycle> createState() => _AppLifeCycleState();
// }
//
// class _AppLifeCycleState extends State<AppLifeCycle> {
//   late AppLifecycleReactor _appLifecycleReactor;
//
//   void initialiseAD() {
//     AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
//     _appLifecycleReactor = AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
//     _appLifecycleReactor.listenToAppStateChanges();
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     initialiseAD();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }
// }
//
// class AppOpenAdManager {
//   String adUnitId = 'ca-app-pub-3940256099942544/3419835294';
//
//   AppOpenAd? _appOpenAd;
//   bool _isShowingAd = false;
//
//   /// Load an AppOpenAd.
//   void loadAd() {
//     AppOpenAd.load(
//       adUnitId: adUnitId,
//       orientation: AppOpenAd.orientationPortrait,
//       request: const AdRequest(),
//       adLoadCallback: AppOpenAdLoadCallback(
//         onAdLoaded: (ad) {
//           _appOpenAd = ad;
//         },
//         onAdFailedToLoad: (error) async {
//           // Handle the error.
//           await Future.delayed(const Duration(seconds: 3));
//           loadAd();
//         },
//       ),
//     );
//   }
//
//   void showAdIfAvailable() {
//     if (!isAdAvailable) {
//       loadAd();
//       return;
//     }
//     if (_isShowingAd) {
//       return;
//     }
//     // Set the fullScreenContentCallback and show the ad.
//     _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
//       onAdShowedFullScreenContent: (ad) {
//         _isShowingAd = true;
//       },
//       onAdFailedToShowFullScreenContent: (ad, error) {
//         _isShowingAd = false;
//         ad.dispose();
//         _appOpenAd = null;
//       },
//       onAdDismissedFullScreenContent: (ad) {
//         _isShowingAd = false;
//         ad.dispose();
//         _appOpenAd = null;
//         loadAd();
//       },
//     );
//
//     _appOpenAd?.show();
//   }
//
//   /// Whether an ad is available to be shown.
//   bool get isAdAvailable {
//     return _appOpenAd != null;
//   }
// }
//
// class AppLifecycleReactor {
//   final AppOpenAdManager appOpenAdManager;
//
//   AppLifecycleReactor({required this.appOpenAdManager});
//
//   void listenToAppStateChanges() {
//     AppStateEventNotifier.startListening();
//     AppStateEventNotifier.appStateStream.forEach((state) => _onAppStateChanged(state));
//   }
//
//   void _onAppStateChanged(AppState appState) {
//     // Try to show an app open ad if the app is being resumed and
//     // we're not already showing an app open ad.
//     if (appState == AppState.foreground) {
//       appOpenAdManager.showAdIfAvailable();
//     }
//   }
// }
