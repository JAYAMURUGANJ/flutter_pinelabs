import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart'; // Import permission_handler
import 'package:provider/provider.dart';

import 'providers/terminal_provider.dart';
import 'screens/terminal_functions.dart';
import 'utils/logger.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Request necessary permissions before running the app
  await _requestPermissions();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TerminalProvider())],
      child: MyApp(navigatorKey: navigatorKey),
    ),
  );
}

Future<void> _requestPermissions() async {
  Map<Permission, PermissionStatus> statuses =
      await [
        Permission.bluetooth,
        Permission.bluetoothConnect,
        Permission.bluetoothScan,
        Permission.locationWhenInUse,
        Permission.location,
      ].request();

  statuses.forEach((permission, status) {
    if (status.isGranted) {
      Logger.info('$permission permission granted.');
    } else if (status.isDenied) {
      Logger.warning('$permission permission denied.');
    } else if (status.isPermanentlyDenied) {
      Logger.error('$permission permission permanently denied.');
      // Open app settings to allow user to grant permission manually
      openAppSettings();
    }
  });
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp({super.key, required this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      navigatorKey: navigatorKey,
      routes: {'/': (context) => TerminalFunctions()},
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder:
              (context) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
      },
    );
  }
}
