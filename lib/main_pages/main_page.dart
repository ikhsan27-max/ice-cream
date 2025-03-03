import 'package:flutter/material.dart';
import 'package:taxi_booking/main_pages/menu.dart';
import 'package:taxi_booking/main_pages/settings.dart';
import 'package:taxi_booking/main_pages/info.dart';
import 'package:taxi_booking/widgets/color.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Nav();
  }
}

class Nav extends StatefulWidget {
  const Nav({super.key});

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  int currentinx = 0;
  List pages = [Menu(), Settings(), Info()];

  @override
  void initState() {
    currentinx = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentinx],

      bottomNavigationBar: NavigationBar(
        backgroundColor: MyColor.primary,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        // overlayColor: ,
        indicatorColor: Colors.white,
        indicatorShape: CircleBorder(
          side: BorderSide(
            color: const Color.fromARGB(255, 91, 44, 61),
            width: 1,
            style: BorderStyle.solid,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),

        selectedIndex: currentinx,
        onDestinationSelected:
            (value) => setState(() {
              currentinx = value;
            }),
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          NavigationDestination(
            icon: Icon(Icons.info_outline_rounded),
            label: 'Info',
          ),
        ],
      ),
    );
  }
}
