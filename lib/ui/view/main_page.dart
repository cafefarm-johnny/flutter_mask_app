import 'package:flutter/material.dart';
import 'package:flutter_mask/ui/widget/store_list_tile.dart';
import 'package:provider/provider.dart';

import '../../model/remain_stats_type.dart';
import '../../view_model/store_model.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 3. ViewModel에서 변경 사항이 통지되면 build 사이클이 재실행된다.
    final storeModel = Provider.of<StoreModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            '마스크 재고 있는 곳 : ${storeModel.stores.where((e) => RemainStatsType.byString(e.remainStat ?? '').isGteFew()).length}곳'),
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
      body: buildBody(storeModel),
    );
  }

  Widget _buildLoading() {
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

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('반경 5km 이내에 재고가 있는 매장이 없습니다.'),
          Text('또는 인터넷이 연결되어 있는지 확인해주세요.'),
        ],
      ),
    );
  }

  Widget buildBody(StoreModel storeModel) {
    if (storeModel.isLoading) {
      return _buildLoading();
    }

    if (storeModel.stores.isEmpty) {
      return _buildError();
    }

    return ListView(
      children: storeModel.stores
          .where((e) => RemainStatsType.byString(e.remainStat ?? '').isGteFew())
          .map((e) => StoreListTileTrailing(store: e))
          .toList(),
    );
  }
}
