import 'package:flutter/material.dart';
import 'package:mengedegna_app/style/colors.dart';
import 'package:mengedegna_app/style/style.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/welcome-screen';

  Widget routeButton(
      Color buttonColor, String title, Color textColor, BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 25, left: 24, right: 24),
      child: ElevatedButton(
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        // color: buttonColor,
        // style: ButtonStyle(shape: ),
        onPressed: () => context,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/road.png'), fit: BoxFit.fill),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 60, left: 25),
                  child: Column(
                    children: const [
                      TitleFont(
                        text: 'Hello',
                        size: 50,
                        color: AppColors.black,
                      ),
                      DescriptionFont(
                        text: 'Welcome to Mengedegna',
                        size: 20,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                ),
              ),
              const Expanded(flex: 5, child: SizedBox()),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      width: double.infinity,
                      padding:
                          const EdgeInsets.only(top: 25, left: 24, right: 24),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            primary: AppColors.primary,
                            padding:
                                const EdgeInsets.only(top: 15, bottom: 15)),
                        onPressed: () => Navigator.of(context)
                            .pushNamed(LoginScreen.routeName),
                        // elevation: 0,
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(25),
                        // ),
                        // color: Colors.indigo,
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      width: double.infinity,
                      padding:
                          const EdgeInsets.only(top: 25, left: 24, right: 24),
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context)
                            .pushNamed(SignupScreen.routeName),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            primary: AppColors.secondary,
                            padding:
                                const EdgeInsets.only(top: 15, bottom: 15)),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
