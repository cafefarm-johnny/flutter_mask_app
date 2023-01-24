import 'package:flutter/material.dart';

enum RemainStatsType {
  plenty('충분', '100개 이상', Colors.green),
  some('보통', '30 ~ 100개 미만', Colors.yellow),
  few('부족', '2 ~ 30개 미만', Colors.red),
  empty('없음', '1개 이하', Colors.grey),
  dfault('판매중지', '판매중지', Colors.black);

  const RemainStatsType(this.status, this.description, this.color);

  final String status;
  final String description;
  final Color color;

  factory RemainStatsType.byString(String remainStat) {
    return RemainStatsType.values
        .firstWhere((e) => e.name == remainStat, orElse: () => dfault);
  }
}
