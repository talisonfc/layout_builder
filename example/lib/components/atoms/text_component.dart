import 'package:flutter/material.dart';
import 'package:layout_builder/component.dart';

class TextComponent extends Component {
  TextComponent()
      : super(
            name: 'Text',
            props: {'value': Property(name: 'value', value: 'Text')},
            jsonBuilder: (props, slots) {
              return {'Text': props['value']?.value};
            },
            previewBuilder: (props, slots) {
              return Text(props['value']?.value);
            });
}
