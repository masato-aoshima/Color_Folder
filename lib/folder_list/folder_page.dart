import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sort_note/component/folder_item.dart';

class FolderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('フォルダー'),
      ),
      body: GridView.extent(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        maxCrossAxisExtent: 150,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(100, (index) {
          return FolderItem((index + 1).toString());
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
