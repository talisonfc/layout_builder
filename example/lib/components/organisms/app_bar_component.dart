import 'package:flutter/material.dart';
import 'package:layout_builder/component.dart';
import 'package:layout_builder/slot.dart';

class AppBarComponent extends Component {
  AppBarComponent()
      : super(
            name: 'AppBar',
            props: {
              'title': Property(name: 'title', value: 'AppBar'),
            },
            previewBuilder: (props, slots) {
              return AppBar(
                title: Text(props['title']?.value),
                actions: [Slot(), Slot()],
              );
            });
}
