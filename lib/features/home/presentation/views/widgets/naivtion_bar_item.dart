import 'package:flutter/material.dart';
import 'package:fruits_app/features/home/presentation/views/domain/entites/bottom_navigation_bar_entity.dart';
import 'package:fruits_app/features/home/presentation/views/widgets/active_item.dart';
import 'package:fruits_app/features/home/presentation/views/widgets/in_active_item.dart';

class NaivationBarItem extends StatelessWidget {
  const NaivationBarItem(
      {super.key,
      required this.isSelected,
      required this.bottomNavigationBarEntity});

  final bool isSelected;
  final BottomNavigationBarEntity bottomNavigationBarEntity;
  @override
  Widget build(BuildContext context) {
    return isSelected
        ? const ActiveItem()
        : InActiveItem(
            image: bottomNavigationBarEntity.inAactiveImage,
          );
  }
}
