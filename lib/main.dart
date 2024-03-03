import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mengedegna_app/providers/auth.dart';
import 'package:mengedegna_app/providers/miscellaneous.dart';
import 'package:mengedegna_app/providers/request.dart';
import 'package:mengedegna_app/screens/home.dart';
import 'package:mengedegna_app/screens/verficationScreen.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/welcome_screen.dart';
import 'widgets/bottom_nav.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (ctx) => Auth()),
        // ChangeNotifierProvider(create: (ctx) => Miscellaneous())
        ChangeNotifierProvider<Auth>(create: (ctx) => Auth()),
        ChangeNotifierProvider<Miscellaneous>(create: (ctx) => Miscellaneous()),
        ChangeNotifierProvider<Request>(create: (ctx) => Request()),
      ],
      child: Consumer(
        builder: (BuildContext context, auth, _) => MaterialApp(
          title: 'Mengedegna App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.indigo,
              textTheme: GoogleFonts.montserratTextTheme(
                Theme.of(context).textTheme,
              )),
          home: LoginScreen(),
          routes: {
            BottomNav.routeName: (context) => const BottomNav(),
            Home.routeName: (context) => const Home(),
            WelcomeScreen.routeName: (context) => WelcomeScreen(),
            SignupScreen.routeName: (context) => const SignupScreen(),
            LoginScreen.routeName: (context) => LoginScreen(),
          },
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}
