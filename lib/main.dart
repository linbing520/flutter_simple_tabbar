import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_simple_tabbar/simple_tabbar.dart';

import 'simple_tabbar.dart';

void main() => runApp(ExampleApp());

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Demo',
        theme: ThemeData(accentColor: Colors.pinkAccent),
        home: MyHomePage(),
      );
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {

  ValueNotifier selectIndex = new ValueNotifier(2);

  var tabs = <Tab>[
    Tab(text: "Tab1",),
    Tab(text: "Tab2",),
    Tab(text: "Tab3",),
    Tab(text: "Tab4",),
  ];

  @override
  void initState() {
    super.initState();

    this.changeSelectIndex();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changeSelectIndex() {
    Future.delayed(Duration(seconds: 3)).then((value) {
        this.selectIndex.value = 0;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body:SimpleTabBar(
         tabs: tabs,
         selectIndex:selectIndex,
         onTabChange:(index) {
           print('onTabChange');
           print(index);
         },
         tabContents: tabs
              .map((Tab tab) =>
              Container(child: Center(child: Text(tab.text),),))
              .toList(),
        ),
      );

}
