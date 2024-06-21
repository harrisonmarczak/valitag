import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:valitag/providers/auth_provider.dart';
import 'package:valitag/providers/common_provider.dart';
import 'package:valitag/providers/dialogProvider.dart';
import 'package:valitag/providers/helpSupport_provider.dart';
import 'package:valitag/providers/imageDialogProvider.dart';
import 'package:valitag/providers/scanAsset_provider.dart';
import 'package:valitag/ui/splash/splashScreen.dart';
import 'package:valitag/utils/navigator_service.dart';
import 'package:valitag/utils/shared_preferences.dart';

SpUtil? sp;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sp = await SpUtil.getInstance();

  runApp(
    MultiProvider(
    providers: [
      ChangeNotifierProvider<ImageDialogProvider>(create: (_) =>  ImageDialogProvider()),
      ChangeNotifierProvider<DialogProvider>(create: (_) =>  DialogProvider()),
      ChangeNotifierProvider<AuthProvider>(create: (_) =>  AuthProvider()),
      ChangeNotifierProvider<CommonProvider>(create: (_) =>  CommonProvider()),
      ChangeNotifierProvider<HelpAndSupportProvider>(create: (_) =>  HelpAndSupportProvider()),
      ChangeNotifierProvider<ScanAssetProvider>(create: (_) =>  ScanAssetProvider()),
    ],
        child: const MyApp(),
   )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Valitag',
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        ),
      ),
      navigatorKey: NavigationService.navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen() ,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
