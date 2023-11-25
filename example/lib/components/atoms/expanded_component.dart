import 'package:flutter/material.dart';
import 'package:layout_builder/component.dart';
import 'package:layout_builder/slot.dart';

class ExpandedComponent extends Component {
  ExpandedComponent()
      : super(
            name: 'Expanded',
            previewBuilder: (props, slots) {
              return Expanded(
                child: Slot(),
              );
            });
}
