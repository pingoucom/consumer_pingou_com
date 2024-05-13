import 'package:consumer_pingou_com/infrastructure/providers/store_provider.dart';
import 'package:consumer_pingou_com/presentation/layouts/bannered_bottomed_screen_layout.dart';
import 'package:consumer_pingou_com/presentation/partials/product/tag_chip.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'daily_message_factory.dart';
part 'tag_list.dart';

class StoreIndexScreen extends StatefulWidget {
  const StoreIndexScreen({super.key});

  @override
  State<StoreIndexScreen> createState() => _StoreIndexScreenState();
}

class _StoreIndexScreenState extends State<StoreIndexScreen> {
  @override
  void initState() {
    super.initState();

    final storeProvider = context.read<StoreProvider>();
    storeProvider.loadFeaturedProductTags();
  }

  @override
  Widget build(BuildContext context) {
    return BanneredBottomedScreenLayout(
      icon: Icons.local_drink,
      message: _DailyMessageFactory.make(),
      stickyHeader: _TagList(),
      children: const [
        Text('asd'),
      ],
    );
  }
}
