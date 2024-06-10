import 'package:consumer_pingou_com/presentation/components/decorated_banner.dart';
import 'package:consumer_pingou_com/presentation/components/my_bottom_bar.dart';
import 'package:flutter/material.dart';

class BanneredBottomedScreenLayout extends StatelessWidget {
  final Widget? stickyHeader;

  final List<Widget> children;

  final IconData icon;

  final List<TextSpan> message;

  const BanneredBottomedScreenLayout({
    super.key,
    this.stickyHeader,
    required this.children,
    required this.icon,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          child: Image.asset(
            'assets/img/pingou-logo.png',
            height: 24,
            width: 24,
            fit: BoxFit.contain,
          ),
        ),
        title: const Text('Pingou!'),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children: [
                DecoratedBanner(
                  icon: icon,
                  message: message,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (stickyHeader != null)
            SliverAppBar(
              backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
              flexibleSpace: stickyHeader!,
              pinned: true,
            ),
          SliverList(
            delegate: SliverChildListDelegate(children),
          ),
        ],
      ),
    );
  }
}
