import 'package:flutter/material.dart';
import 'package:layout_builder/component.dart';

class IconComponent extends Component {
  IconComponent()
      : super(
            name: 'Icon',
            previewBuilder: (props, slots) {
              return Icon(Icons.ac_unit);
            });
}
