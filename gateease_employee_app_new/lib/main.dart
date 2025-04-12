import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gateease_employee_app_new/router.dart';
import 'package:gateease_employee_app_new/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

    await dotenv.load(fileName: ".env");

  /// Initialize Hive for local storage
  if (!kIsWeb) { // ✅ Avoids error on Chrome
    final appDocumentDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDir.path);
  } else {
    await Hive.initFlutter(); // ✅ Works for Web
  }

  /// Dependency Injection Setup
  di.init(); // Calls the function in `injection_container.dart`

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "GateEase Employee App",
      theme: ThemeData.light(),
      routerConfig: ref.watch(routerProvider), // `go_router` navigation
    );
  }
}
