import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reciclase_coletor/InfiniteButtoColor.dart';
import 'package:reciclase_coletor/Navegador.dart';
import 'package:reciclase_coletor/TrashColors.dart';

import 'Home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeFireabase();
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

Future<void> initializeFireabase() async {
  await Firebase.initializeApp()
      .whenComplete(() => print('Firebase Initialized !!!'));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _initializeFlutterFire() async {
    /*
    // Wait for Firebase to initialize
    //await Firebase.initializeApp();
    if (_kTestingCrashlytics) {
      // Force enable crashlytics collection enabled if we're testing it.
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    } else {
      // Else only enable it in non-debug builds.
      // You could additionally extend this to allow users to opt-in.
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(!kDebugMode);
    }

    // Pass all uncaught errors to Crashlytics.
    Function originalOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      // Forward to original handler.
      originalOnError(errorDetails);
    };*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: TrashColors().appBarBackGround,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Bem Vindo ao recicla.se Coletor",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 30)),
            InfiniteButtonColor(
              color: TrashColors().buttonColor,
              action: () {
                Navegador().goToLogin(context);
              },
              text: 'Começar !',
            )
          ],
        ));
  }
}
