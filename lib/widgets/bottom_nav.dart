import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mengedegna_app/providers/request.dart';
import 'package:mengedegna_app/screens/bookings.dart';
import 'package:mengedegna_app/screens/profile_page.dart';
import 'package:mengedegna_app/style/colors.dart';
import 'package:provider/provider.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import '../screens/home.dart';
import '../screens/welcome_screen.dart';

class BottomNav extends StatefulWidget {
  static const routeName = '/bottomNav';
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<Request>(context, listen: false).init(context);
  }

  int selectedpage = 0;
  PageController pageController = PageController();
  final _pageNo = [const Home(), const Bookings(), const Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(17, 83, 109, 254),
      body: _pageNo[selectedpage],
      extendBody: true,
      bottomNavigationBar: WaterDropNavBar(
        backgroundColor: Colors.white,
        onItemSelected: (int index) {
          setState(() {
            selectedpage = index;
          });
          // pageController.animateToPage(selectedpage,
          //     duration: const Duration(milliseconds: 400),
          //     curve: Curves.easeOutQuad);
        },
        selectedIndex: selectedpage,
        barItems: <BarItem>[
          BarItem(filledIcon: Icons.home, outlinedIcon: Icons.home_outlined),
          BarItem(filledIcon: Icons.book, outlinedIcon: Icons.book_outlined),
          BarItem(
            filledIcon: Icons.person,
            outlinedIcon: Icons.person_outlined,
          ),
        ],
      ),
    );
  }
}
