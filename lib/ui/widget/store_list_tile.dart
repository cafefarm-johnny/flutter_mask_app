import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
    return ListTile(
      title: Text(store.name ?? ''),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(store.addr ?? ''),
          Text('${store.km ?? 0}km'),
        ],
      ),
      trailing: _buildTrailing(store),
      onTap: () {
        _launchUrl(store.lat?.toDouble() ?? 0, store.lng?.toDouble() ?? 0);
      },
    );
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

  Future<void> _launchUrl(double lat, double lng) async {
    final uri =
        Uri.parse('https://google.com/maps/search/?api=1&query=$lat,$lng');
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }
}
