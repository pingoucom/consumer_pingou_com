import 'package:consumer_pingou_com/domain/entities/product_tag.dart';
import 'package:consumer_pingou_com/presentation/components/skeleton_shape.dart';
import 'package:consumer_pingou_com/utils/parse_icon.dart';
import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {
  final ProductTag tag;

  final String? selectedTagId;

  final ValueChanged<bool> onSelected;

  const TagChip({
    super.key,
    required this.tag,
    required this.selectedTagId,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      avatar: Icon(parseIcon(tag.iconId) ?? Icons.local_offer),
      label: Text(tag.name),
      selected: tag.id == selectedTagId,
      onSelected: onSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  static Widget skeleton(BuildContext context, double width) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.25),
        ),
      ),
      child: SkeletonShape(
        width: width,
        height: 38,
        borderRadius: 24,
      ),
    );
  }
}
