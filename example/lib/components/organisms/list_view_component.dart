import 'package:flutter/material.dart';
import 'package:layout_builder/component.dart';
import 'package:layout_builder/slot.dart';

class ListViewComponent extends Component {
  ListViewComponent()
      : super(
            name: 'ListView',
            props: {
              'total':
                  Property(name: 'total', value: 3, type: PropertyType.number),
            },
            jsonBuilder: (props, slots) {
              return {'key': 'value'};
            },
            previewBuilder: (props, slots) {
              return ListView(
                children: List.generate(props[0]?.value, (index) => Slot()),
              );
            });
}
