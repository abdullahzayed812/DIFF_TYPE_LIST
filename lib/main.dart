import 'dart:html';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static String title = "This is title";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: MyHomePage(
          appBarTitle: title,
          items: List<ListItem>.generate(
              1000,
              (index) => index % 6 == 0
                  ? HeadingItem("Heading $index")
                  : MessageItem("Sender $index", "Body $index"))),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.items, required this.appBarTitle});

  final String appBarTitle;
  final List<ListItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(appBarTitle)),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            return ListTile(
              title: item.buildTitle(context),
              subtitle: item.buildSubtitle(context),
            );
          },
        ));
  }
}

abstract class ListItem {
  Widget buildTitle(BuildContext context);
  Widget buildSubtitle(BuildContext context);
}

class HeadingItem implements ListItem {
  const HeadingItem(this.heading);

  final String heading;

  @override
  Widget buildTitle(BuildContext context) {
    return Text(heading);
  }

  @override
  Widget buildSubtitle(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class MessageItem implements ListItem {
  MessageItem(this.sender, this.body);

  final String sender;
  final String body;

  @override
  Widget buildTitle(BuildContext context) => Text(sender);

  @override
  Widget buildSubtitle(BuildContext context) => Text(body);
}
