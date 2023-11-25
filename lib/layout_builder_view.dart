import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:layout_builder/component.dart';
import 'package:layout_builder/components_catalog.dart';
import 'package:layout_builder/slot.dart';
import 'package:layout_builder/settings/settings.dart';

class LayoutBuilderView extends StatelessWidget {
  LayoutBuilderView({Key? key, this.components = const []}) : super(key: key);

  final List<Component> components;

  final GlobalKey _root = GlobalKey();
  Component? root;

  // Component? root = ScaffoldComponent(
  //     body: PaddingComponent(
  //         child: ColumnComponent(children: [
  //   CardComponent(child: ListTileComponent()),
  //   CardComponent(child: ListTileComponent()),
  //   CardComponent(child: ListTileComponent()),
  // ])));

  final frame = {
    "Scaffold": {
      "appBar": {
        "title": "Scaffold",
        "backgroundColor": 4294967295,
        "actions": [null]
      },
      "body": null
    }
  };

  String code = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Layout Builder'),
        actions: [
          ElevatedButton(
              onPressed: () {
                if (root != null) {
                  final json =
                      root!.jsonBuilder?.call(root!.props, root!.slots);
                  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
                  String prettyprint = encoder.convert(json);
                  print(prettyprint);
                } else {
                  print('nenhum component adicionado');
                }
              },
              child: Text('generate json')),
          ElevatedButton(
              onPressed: () {
                final json = root!.jsonBuilder?.call(root!.props, root!.slots);
                JsonEncoder encoder = new JsonEncoder.withIndent('      ');
                String prettyprint = encoder.convert(json);

                showModalBottomSheet(
                    context: context,
                    builder: (context) => Scaffold(
                            body: ListView(
                          padding: EdgeInsets.all(32),
                          children: [SelectableText(prettyprint)],
                        )));
              },
              child: Text('show json')),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: ComponentsCatalog(components: components),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Container(
                  width: 400,
                  child: Slot(
                    name: 'root',
                    key: _root,
                    component: root,
                    onAccept: (slot, component) {
                      root = component;
                    },
                    onRemove: (slot) {
                      root = null;
                    },
                  )),
            ),
          ),
          Expanded(flex: 1, child: Settings())
        ],
      ),
    );
  }
}
