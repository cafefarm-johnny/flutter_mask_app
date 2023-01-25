import 'package:flutter/foundation.dart';
import 'package:flutter_mask/model/store.dart';
import 'package:flutter_mask/repository/store_repository.dart';

class StoreModel with ChangeNotifier {
  var stores = <Store>[];

  final _storeRepository = StoreRepository();

  // 1. 생성자 호출 시점에 데이터를 가져온다.
  StoreModel() {
    fetch();
  }

  Future<void> fetch() async {
    stores = await _storeRepository.fetch();

    // 2. View에게 변경 사항을 통지한다.
    notifyListeners();
  }
}
