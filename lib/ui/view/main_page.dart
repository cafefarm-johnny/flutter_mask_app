import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/remain_stats_type.dart';
import '../../model/store.dart';
import '../../view_model/store_model.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 3. ViewModel에서 변경 사항이 통지되면 build 사이클이 재실행된다.
    final storeModel = Provider.of<StoreModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            '마스크 재고 있는 곳 : ${storeModel.stores.where((e) => RemainStatsType.byString(e.remainStat ?? '').isGreaterThanFew()).length}곳'),
        actions: [
          // 새로고침
          IconButton(
            onPressed: () {
              storeModel.fetch();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: storeModel.isLoading ? buildLoading() : buildBody(storeModel),
    );
  }

  Widget buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('정보를 가져오는 중 입니다.'),
          CircularProgressIndicator(),
        ],
      ),
    );
  }

  Widget buildBody(StoreModel storeModel) {
    return ListView(
      children: storeModel.stores
          .where((e) =>
              RemainStatsType.byString(e.remainStat ?? '').isGreaterThanFew())
          .map((e) {
        return ListTile(
          title: Text(e.name ?? ''),
          subtitle: Text(e.addr ?? ''),
          trailing: _buildTrailing(e),
        );
      }).toList(),
    );
  }

  Widget _buildTrailing(Store store) {
    final remainStatsType = RemainStatsType.byString(store.remainStat ?? '');

    return Column(
      children: [
        Text(
          remainStatsType.status,
          style: TextStyle(
              color: remainStatsType.color, fontWeight: FontWeight.bold),
        ),
        Text(
          remainStatsType.description,
          style: TextStyle(color: remainStatsType.color),
        ),
      ],
    );
  }
}
