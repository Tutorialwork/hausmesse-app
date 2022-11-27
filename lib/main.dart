import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hausmesse/pages/StatusPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:http/http.dart' as http;

String apiUrl = 'https://443f-141-31-147-115.eu.ngrok.io';

void main() {
  initFirebase();

  runApp(const MainPage());
}

Future<void> initFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  if (fcmToken == null) {
    return;
  }
  await registerToken(fcmToken);
}

Future<void> registerToken(String token) async {
  http.Response serverResponse = await http.post(
      Uri.parse(apiUrl + '/registerToken'),
      body: token
  );
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: StatusPage(),
        ),
      ),
    );
  }
}
