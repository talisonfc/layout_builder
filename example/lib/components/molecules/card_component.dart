import 'package:flutter/material.dart';
import 'package:layout_builder/component.dart';
import 'package:layout_builder/slot.dart';

class CardComponent extends Component {
  CardComponent({Component? child})
      : super(
          name: 'Card',
          jsonBuilder: (props, slots) {
            return {
              'Card': {
                'child': slots['child']
                    ?.jsonBuilder
                    ?.call(slots['child']!.props, slots['child']!.slots)
              }
            };
          },
          previewBuilder: (props, slots) {
            return Card(
              child: Slot(
                component: child,
                name: 'child',
                onAccept: (slotName, component) {
                  print('onAccept: $slotName, $component');
                  slots['child'] = component;
                },
              ),
            );
          },
        );
}
