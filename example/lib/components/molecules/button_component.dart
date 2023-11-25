import 'package:flutter/material.dart';
import 'package:layout_builder/component.dart';

class ButtonComponent extends Component {
  ButtonComponent()
      : super(
            name: 'Button',
            props: {'label': Property(name: 'label', value: 'Button')},
            jsonBuilder: (props, slots) {
              return {'Button': props['label']?.value};
            },
            previewBuilder: (props, slots) {
              return ElevatedButton(
                  onPressed: null, child: Text(props['label']?.value));
            });
}
