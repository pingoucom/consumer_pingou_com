import 'package:consumer_pingou_com/domain/entities/order.dart';
import 'package:consumer_pingou_com/presentation/components/skeleton_shape.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  final Widget? trailing;

  final GestureTapCallback? onTap;

  const OrderCard({
    super.key,
    required this.order,
    this.trailing,
    this.onTap,
  });

  static Widget skeleton() {
    return SizedBox(
      height: 80,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: const ListTile(
          title: SkeletonShape(
            height: 16,
            width: 100,
            borderRadius: 8,
          ),
          subtitle: SkeletonShape(
            height: 16,
            width: 100,
            borderRadius: 8,
          ),
          trailing: SkeletonShape(
            height: 24,
            width: 24,
            borderRadius: 12,
          ),
          isThreeLine: false,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Pedido #${order.id}';

    final secondLine =
        DateFormat('yMMMMEEEEd', 'pt_BR').format(order.createdAt);

    return SizedBox(
      height: 80,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: onTap,
          child: ListTile(
            title: Text(
              title,
              overflow: TextOverflow.ellipsis,
            ),
            titleTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
            subtitle: Text(secondLine),
            isThreeLine: false,
            trailing: trailing,
          ),
        ),
      ),
    );
  }
}
