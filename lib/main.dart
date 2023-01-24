import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mask/model/remain_stats_type.dart';
import 'package:http/http.dart' as http;

import 'model/store.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final stores = <Store>[];
  bool isLoading = true;

  Future<void> fetch() async {
    setState(() {
      isLoading = true;
    });

    const url =
        'https://gist.githubusercontent.com/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      return;
    }

    final result = jsonDecode(response.body);
    final jsonStores = result['stores'];

    setState(() {
      stores.clear();

      jsonStores.forEach((e) {
        stores.add(Store.fromJson(e));
      });

      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마스크 재고 있는 곳 : ${stores.length}곳'),
        actions: [
          // 새로고침
          IconButton(
            onPressed: fetch,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: isLoading ? buildLoading() : buildBody(),
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

  Widget buildBody() {
    return ListView(
      children: stores.map((e) {
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
