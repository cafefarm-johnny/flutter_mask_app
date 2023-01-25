import 'package:flutter/material.dart';

import '../../model/remain_stats_type.dart';
import '../../model/store.dart';

class StoreListTileTrailing extends StatelessWidget {
  final Store store;

  const StoreListTileTrailing({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildTrailing(this.store);
  }

  Widget _buildTrailing(Store store) {
    final remainStatsType = RemainStatsType.byString(store.remainStat ?? '');

    return Column(
      children: [
        Text(
          remainStatsType.status,
          style: TextStyle(
            color: remainStatsType.color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          remainStatsType.description,
          style: TextStyle(
            color: remainStatsType.color,
          ),
        ),
      ],
    );
  }
}
