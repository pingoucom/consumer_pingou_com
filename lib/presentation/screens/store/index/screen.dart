import 'package:consumer_pingou_com/domain/entities/product.dart';
import 'package:consumer_pingou_com/domain/entities/product_tag.dart';
import 'package:consumer_pingou_com/infrastructure/providers/store_provider.dart';
import 'package:consumer_pingou_com/presentation/components/skeleton_shape.dart';
import 'package:consumer_pingou_com/presentation/layouts/bannered_bottomed_screen_layout.dart';
import 'package:consumer_pingou_com/presentation/partials/product/tag_chip.dart';
import 'package:consumer_pingou_com/presentation/partials/product/vertical_product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'daily_message_factory.dart';
part 'product_list_by_tag.dart';
part 'tag_list.dart';
part 'tag_products_list.dart';

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
    storeProvider.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return BanneredBottomedScreenLayout(
      icon: Icons.local_drink,
      message: _DailyMessageFactory.make(),
      stickyHeader: _TagList(),
      children: [
        _TagProductsList(),
      ],
    );
  }
}
