import 'package:flutter/material.dart';

IconData? parseIcon(String iconId) {
  switch (iconId) {
    case 'star':
      return Icons.star;
    case 'new_releases':
      return Icons.new_releases;
    case 'map':
      return Icons.map;
    case 'sunny':
      return Icons.sunny;
    case 'local_offer':
      return Icons.local_offer;
  }

  return null;
}
