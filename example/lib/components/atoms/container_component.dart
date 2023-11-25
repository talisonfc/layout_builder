import 'package:flutter/material.dart';
import 'package:layout_builder/component.dart';
import 'package:layout_builder/slot.dart';

class ContainerComponent extends Component {
  ContainerComponent()
      : super(
            name: 'Container',
            jsonBuilder: (props, slots) {
              return {
                'Container': {
                  'child': slots['child']
                      ?.jsonBuilder
                      ?.call(slots['child']!.props, slots['child']!.slots)
                }
              };
            },
            previewBuilder: (props, slots) {
              return Container(
                child: Slot(
                  name: 'child',
                  onAccept: (slotName, component) {
                    print('onAccept: $slotName, $component');
                    slots['child'] = component;
                  },
                ),
              );
            });
}
