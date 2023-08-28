import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mask/config/app_contig.dart';
import 'package:provider/provider.dart';

import 'ui/view/main_page.dart';
import 'view_model/store_model.dart';

Future<void> main() async {
  // 앱 권한 요청과 같은 네이티브 코드 호출이 필요한 경우 앱(runApp)을 실행하기 전에 전처리가 되어야 한다.
  // 플러터 엔진 레이어 단계에서 초기화 과정이 수행될 수 있도록 처리한다. (Geolocator)
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ChangeNotifierProvider.value(
    value: StoreModel(),
    child: MyApp(
      appThemeColor: AppConfig.instance(flavor: await flavor).appThemeColor,
    ),
  ));
}

Future<String> get flavor async =>
    await const MethodChannel("flavor").invokeMethod("getFlavor");

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    this.appThemeColor,
  });

  final MaterialColor? appThemeColor;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: appThemeColor,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
