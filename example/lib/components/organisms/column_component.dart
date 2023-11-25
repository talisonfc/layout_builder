import 'package:flutter/material.dart';
import 'package:layout_builder/component.dart';
import 'package:layout_builder/slot.dart';

class ColumnComponent extends Component {
  ColumnComponent({List<Component>? children})
      : super(
          name: 'Column',
          props: {
            'total': Property(
                name: 'total',
                type: PropertyType.number,
                value: children != null ? children.length : 3),
            'mainAxisAlignment': Property(
                name: 'mainAxisAlignment',
                type: PropertyType.list,
                options: [
                  PropertyOption(
                      label: 'start', value: MainAxisAlignment.start),
                  PropertyOption(label: 'end', value: MainAxisAlignment.end),
                  PropertyOption(
                      label: 'center', value: MainAxisAlignment.center),
                  PropertyOption(
                      label: 'spaceBetween',
                      value: MainAxisAlignment.spaceBetween),
                  PropertyOption(
                      label: 'spaceAround',
                      value: MainAxisAlignment.spaceAround),
                  PropertyOption(
                      label: 'spaceEvenly',
                      value: MainAxisAlignment.spaceEvenly),
                ],
                defaultValue: MainAxisAlignment.start)
          },
          jsonBuilder: (props, slots) {
            return {
              'Column': {
                'children': List.generate(props['total']?.value, (index) {
                  return slots['item-$index']?.jsonBuilder?.call(
                      slots['item-$index']!.props, slots['item-$index']!.slots);
                })
              }
            };
          },
          previewBuilder: (props, slots) {
            return Column(
              mainAxisAlignment:
                  props['mainAxisAlignment']?.value ?? MainAxisAlignment.start,
              children: List.generate(props['total']?.value, (index) {
                return Slot(
                  name: 'item-$index',
                  component: children != null ? children[index] : null,
                  onAccept: (slotName, component) {
                    print('onAccept: $slotName, $component');
                    slots['item-$index'] = component;
                  },
                  onRemove: (slotName) {
                    print('onRemove: $slotName');
                    slots.remove(slotName);
                  },
                );
              }),
            );
          },
        );
}
