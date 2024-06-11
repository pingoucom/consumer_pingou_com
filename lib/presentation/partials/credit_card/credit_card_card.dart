import 'package:consumer_pingou_com/domain/entities/credit_card.dart';
import 'package:consumer_pingou_com/presentation/components/skeleton_shape.dart';
import 'package:consumer_pingou_com/presentation/partials/credit_card/card_brand_icon.dart';
import 'package:flutter/material.dart';

class CreditCardCard extends StatelessWidget {
  final CreditCard creditCard;

  final bool isSelected;

  final Widget? trailing;

  final GestureTapCallback? onTap;

  const CreditCardCard({
    super.key,
    required this.creditCard,
    required this.isSelected,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final title = '**** ' * 3 + creditCard.lastFourDigits;

    final cardShape = isSelected
        ? RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          )
        : RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          );

    return SizedBox(
      height: 80,
      child: Card(
        shape: cardShape,
        child: InkWell(
          onTap: onTap,
          child: ListTile(
            leading: CardBrandIcon(brand: creditCard.brand),
            title: Row(
              children: [
                Flexible(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            titleTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
            subtitle: Row(
              children: [
                Flexible(
                  child: Text(
                    creditCard.holderFirstName,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            isThreeLine: false,
            trailing: trailing,
          ),
        ),
      ),
    );
  }

  static skeleton(BuildContext context, Widget? trailing) {
    return SizedBox(
      height: 80,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          leading: const SkeletonShape(
            height: 48,
            width: 48,
            borderRadius: 24,
          ),
          title: const SkeletonShape(
            height: 16,
            width: 96,
            borderRadius: 8,
          ),
          subtitle: const SkeletonShape(
            height: 16,
            width: 48,
            borderRadius: 8,
          ),
          isThreeLine: false,
          trailing: trailing,
        ),
      ),
    );
  }
}
