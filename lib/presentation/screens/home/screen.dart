import 'package:consumer_pingou_com/domain/entities/banner.dart';
import 'package:consumer_pingou_com/infrastructure/providers/homeBannerScreen_provider.dart';
import 'package:consumer_pingou_com/presentation/components/daily_message_factory.dart';
import 'package:consumer_pingou_com/presentation/layouts/bannered_bottomed_screen_layout.dart';
import 'package:consumer_pingou_com/presentation/screens/store/index/screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'banner_skeleton.dart';
part 'banner_widget.dart';
part 'banner_widget_carrousel.dart';

class HomeIndexScreen extends StatefulWidget {
  const HomeIndexScreen({super.key});

  @override
  State<HomeIndexScreen> createState() => _HomeIndexScreenState();
}

class _HomeIndexScreenState extends State<HomeIndexScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BanneredBottomedScreenLayout(
      icon: Icons.local_drink,
      message: DailyMessageFactory.make(),
      children: [
        _BannerWidgetCarousel(),
      ],
    );
  }
}
