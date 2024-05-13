import 'package:consumer_pingou_com/domain/entities/address.dart';
import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  final Address address;

  final bool isSelected;

  final Widget? trailing;

  final GestureTapCallback? onTap;

  const AddressCard({
    super.key,
    required this.address,
    required this.isSelected,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final titlePieces = [
      address.street,
      address.number,
      address.complement,
      address.neighborhood,
    ].where((piece) => piece != null && piece.isNotEmpty).toList();

    final subtitlePieces = [
      address.city,
      address.state.name,
      address.postalCode,
    ];

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
            title: Row(
              children: [
                Flexible(
                  child: Text(
                    titlePieces.join(', '),
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
                    subtitlePieces.join(', '),
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
}
