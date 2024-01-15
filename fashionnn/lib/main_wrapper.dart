import 'package:animate_do/animate_do.dart';
import 'package:fashionnn/screens/cart.dart';
import 'package:fashionnn/screens/home.dart';
import 'package:fashionnn/screens/search.dart';
import 'package:fashionnn/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:bottom_bar_matu/bottom_bar_matu.dart';
import 'package:line_icons/line_icons.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final _index = 0;
  bool isSeacrhActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),
        title: isSeacrhActive
            ? FadeIn(
                delay: Duration(milliseconds: 300),
                child: Text(
                  'Search',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              )
            : FadeIn(
                delay: Duration(milliseconds: 300),
                child: Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSeacrhActive = !isSeacrhActive;
              });
            },
            icon: isSeacrhActive
                ? Icon(
                    LineIcons.searchMinus,
                    color: Colors.black,
                    size: 30,
                  )
                : Icon(
                    LineIcons.search,
                    color: Colors.black,
                    size: 30,
                  ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Cart(),
                ),
              );
            },
            icon: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      ),

      // when press the search button,
      // it will directly switch to another page
      body: isSeacrhActive ? Search() : Home(),
      bottomNavigationBar: BottomBarDoubleBullet(
        selectedIndex: _index,
        color: primaryColor,
        items: [
          BottomBarItem(iconData: Icons.home),
          BottomBarItem(iconData: Icons.search),
          BottomBarItem(iconData: Icons.explore),
          BottomBarItem(iconData: Icons.settings),
          BottomBarItem(iconData: Icons.mail),
        ],
        onSelect: (value) {},
      ),
    );
  }
}
