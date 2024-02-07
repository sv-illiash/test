import 'package:flutter/services.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:test_app/core/constants/contants.dart';
import 'package:test_app/core/navigation_service/navigation_service.dart';
import 'package:test_app/injector.dart';
import 'package:test_app/presentation/routes/app_routes.dart';
import 'package:test_app/presentation/routes/screen_arguments/movie_detail_screen_args.dart';
import 'package:uni_links/uni_links.dart';

class SimpleDeepLinkHandler {
  Future<void> initUniLinks() async {
    try {
      String? initialLink = await getInitialLink();
      if (initialLink != null) {
        _handleDeeplink(initialLink);
      }
    } on PlatformException {
      FlutterLogs.logError(
          DEEP_LINK_TAG, 'Deep link', 'Exception if unable to get the initial link');
    }

    /// Listen to incoming links
    linkStream.listen((String? link) {
      if (link != null) {
        _handleDeeplink(link);
      }
    });
  }

  void _handleDeeplink(String link) {
    Uri uri = Uri.parse(link);
    List<String> pathSegments = uri.pathSegments;

    if (pathSegments.contains(AppRoutes.movieDetail)) {
      int movieId = int.parse(pathSegments.last);

      injector<NavigationService>()
          .pushNamed(AppRoutes.movieDetail, arguments: MovieDetailScreenArgs(id: movieId));
    } else {
      FlutterLogs.logInfo(DEEP_LINK_TAG, 'Invalid link', 'Invalid or unsupported deep link format');
    }
  }
}

/// i am testing with this link
/// IOS: xcrun simctl openurl booted myapp://com.example.test_app/movieDetail/892511
/// Androdi: adb shell am start -W -a android.intent.action.VIEW -d "myapp://com.example.test_app/movieDetail/892511"
