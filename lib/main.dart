import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mask/model/remain_stats_type.dart';
import 'package:flutter_mask/repository/store_repository.dart';
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
  var stores = <Store>[];
  var isLoading = false;

  final storeRepository = StoreRepository();

  @override
  void initState() {
    super.initState();

    storeRepository.fetch()
      .then((stores) {
        setState(() {
          this.stores = stores;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '마스크 재고 있는 곳 : ${stores.where((e) => RemainStatsType.byString(e.remainStat ?? '').isGreaterThanFew()).length}곳'),
        actions: [
          // 새로고침
          IconButton(
            onPressed: () {
              storeRepository.fetch()
                .then((stores) {
                  setState(() {
                    this.stores = stores;
                  });
              });
            },
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
      children: stores
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
