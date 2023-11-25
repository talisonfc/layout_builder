import 'package:flutter/material.dart';
import 'package:layout_builder/component.dart';
import 'package:layout_builder/slot.dart';

class PaddingComponent extends Component {
  PaddingComponent({Component? child})
      : super(
            name: 'Padding',
            props: {
              'left':
                  Property(name: 'left', type: PropertyType.number, value: 8),
              'right':
                  Property(name: 'right', type: PropertyType.number, value: 8),
              'top': Property(name: 'top', type: PropertyType.number, value: 8),
              'bottom':
                  Property(name: 'bottom', type: PropertyType.number, value: 8),
            },
            jsonBuilder: (props, slots) {
              return {
                'Padding': {
                  'padding': {
                    'left': props['left']?.value,
                    'right': props['right']?.value,
                    'top': props['top']?.value,
                    'bottom': props['bottom']?.value,
                  },
                  'child': slots['child']
                      ?.jsonBuilder
                      ?.call(slots['child']!.props, slots['child']!.slots)
                }
              };
            },
            previewBuilder: (props, slots) {
              return Padding(
                  padding: EdgeInsets.only(
                    left: props['left']?.value,
                    right: props['right']?.value,
                    top: props['top']?.value,
                    bottom: props['bottom']?.value,
                  ),
                  child: Slot(
                    component: child,
                    name: 'child',
                    onAccept: (slotName, component) {
                      slots['child'] = component;
                    },
                    onRemove: (slotName) {
                      slots.remove(slotName);
                    },
                  ));
            });
}
