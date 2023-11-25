import 'package:example/components/atoms/padding_component.dart';
import 'package:example/components/molecules/button_component.dart';
import 'package:example/components/molecules/card_component.dart';
import 'package:example/components/molecules/list_tile_component.dart';
import 'package:example/components/organisms/column_component.dart';
import 'package:example/components/organisms/list_view_component.dart';
import 'package:example/components/template/scaffold_component.dart';
import 'package:flutter/material.dart';
import 'package:layout_builder/layout_builder_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LayoutBuilderView(
        components: [
          ScaffoldComponent(),
          ColumnComponent(),
          CardComponent(),
          ListTileComponent(),
          ButtonComponent(),
          ListViewComponent(),
          PaddingComponent()
        ],
      ),
    );
  }
}
