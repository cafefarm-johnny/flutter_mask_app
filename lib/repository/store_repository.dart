import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import '../model/store.dart';

class StoreRepository {
  final _distance = const Distance();
  final stores = <Store>[];

  Future<List<Store>> fetch(double lat, double lng) async {
    const url =
        'https://gist.githubusercontent.com/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      return [];
    }

    final result = jsonDecode(response.body);
    final jsonStores = result['stores'];

    stores.clear();

    jsonStores.forEach((e) {
      final store = Store.fromJson(e);
      // 위도, 경도에 대한 범위 탐색 알고리즘은 임의로 작성
      if (store.lat != null &&
          store.lat! <= lat &&
          store.lng != null &&
          store.lng! >= lng) {
        final km = _distance.as(
          LengthUnit.Kilometer,
          LatLng(store.lat?.toDouble() ?? 0, store.lng?.toDouble() ?? 0),
          LatLng(lat, lng),
        );
        store.km = km;

        stores.add(store);
      }
    });

    return stores;
  }
}
