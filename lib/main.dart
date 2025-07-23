import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'config/constants.dart';
import 'config/theme.dart';
import 'config/typo_config.dart';
import 'providers/global_providers.dart';
import 'screens/wrapper.dart';
import 'widgets/generic/loader_widget.dart';
import 'widgets/generic/startup_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartup = ref.watch(appStartupProvider);
    return MaterialApp(
      theme: theme,
      title: 'Sehat Express Admin',
      debugShowCheckedModeBanner: false,
      home: appStartup.when(
        data: (_) => const Wrapper(),
        loading: () => const StartupWidget(
          widget: Center(child: LoaderWidget(color: Colors.white)),
        ),
        error: (error, stack) => StartupWidget(
          widget: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Initialization failed: $error',
                  style: typoConfig.textStyle.smallCaptionSubtitle2.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  height: 36,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () => ref.refresh(appStartupProvider),
                    child: Text(
                      'Retry',
                      style: typoConfig.textStyle.smallCaptionSubtitle1
                          .copyWith(height: 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      navigatorKey: KeyConstants.navigatorKey,
    );
  }
}

// firebase deploy --only hosting:admin
// export CHROME_EXECUTABLE="/Applications/Brave Browser.app/Contents/MacOS/Brave Browser"
// flutter run -d web-server
// dart pub global activate dart_remove_unused
// dart pub global run dart_remove_unused
// dart pub global run dart_remove_unused --delete-unused
// dart pub global run dart_remove_unused --delete-unused --verbose
