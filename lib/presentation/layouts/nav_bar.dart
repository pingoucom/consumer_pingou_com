import 'package:consumer_pingou_com/presentation/screens/credit_cards/index/screen.dart';
import 'package:consumer_pingou_com/presentation/screens/home/screen.dart';
import 'package:consumer_pingou_com/presentation/screens/store/index/screen.dart';
import 'package:consumer_pingou_com/presentation/screens/subscription_plan/subscriptionBanner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MyNavBar extends StatelessWidget {
  const MyNavBar({Key? key}) : super(key: key);

  List<Widget> _buildScreens() {
    return [
      HomeIndexScreen(),
      StoreIndexScreen(),
      SubscriptionBanner(),
      CreditCardsIndexScreen(), // orderBanner();
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.store),
        title: ("Loja"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.subscriptions),
        title: ("Assinatura"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.menu_book),
        title: ("Pedidos"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;
    _controller = PersistentTabController(initialIndex: 0);
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      navBarStyle:
          NavBarStyle.style6, // Choose the nav bar style with this property.
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
    );
  }
}
