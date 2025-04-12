import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gateease_employee_app_new/router.dart';
import 'package:gateease_employee_app_new/injection_container.dart' as di;

// A provider to hold the current theme mode, defaulting to light.
final themeModeProvider = StateProvider<ThemeMode>((_) => ThemeMode.light);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  /// Initialize Hive for local storage
  if (!kIsWeb) {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDir.path);
  } else {
    await Hive.initFlutter();
  }

  /// Dependency Injection Setup
  di.init();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "GateEase Employee App",
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      routerConfig: ref.watch(routerProvider), // go_router navigation
    );
  }
}
