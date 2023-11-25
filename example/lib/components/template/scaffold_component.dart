import 'package:flutter/material.dart';
import 'package:layout_builder/component.dart';
import 'package:layout_builder/slot.dart';

class ScaffoldComponent extends Component {
  ScaffoldComponent({
    Component? body,
  }) : super(
            name: 'Scaffold',
            props: {
              'title': Property(name: 'title', value: 'Scaffold'),
              'bodyBackgroundColor': Property(
                  name: 'bodyBackgroundColor',
                  type: PropertyType.list,
                  value: Colors.white,
                  options: [
                    PropertyOption(label: 'White', value: Colors.white),
                    PropertyOption(label: 'Black', value: Colors.black),
                    PropertyOption(label: 'Red', value: Colors.red),
                    PropertyOption(label: 'Green', value: Colors.green),
                    PropertyOption(label: 'Blue', value: Colors.blue),
                  ]),
              'titleBackgroundColor': Property(
                  name: 'titleBackgroundColor',
                  type: PropertyType.list,
                  value: Colors.white,
                  options: [
                    PropertyOption(label: 'White', value: Colors.white),
                    PropertyOption(label: 'Black', value: Colors.black),
                    PropertyOption(label: 'Red', value: Colors.red),
                    PropertyOption(label: 'Green', value: Colors.green),
                    PropertyOption(label: 'Blue', value: Colors.blue),
                  ]),
            },
            jsonBuilder: (props, slots) {
              return {
                'Scaffold': {
                  'appBar': {
                    'title': props['title']?.value.toString(),
                    'backgroundColor':
                        (props['titleBackgroundColor']?.value as Color).value,
                    'actions': [
                      slots['action-1']?.jsonBuilder?.call(
                          slots['action-1']!.props, slots['action-1']!.slots)
                    ]
                  },
                  'body': slots.containsKey('body')
                      ? slots['body']
                          ?.jsonBuilder
                          ?.call(slots['body']!.props, slots['body']!.slots)
                      : null
                }
              };
            },
            previewBuilder: (props, slots) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(props['title']?.value ?? 'Scaffold'),
                  backgroundColor:
                      props['titleBackgroundColor']?.value ?? Colors.white,
                  actions: [
                    Slot(
                      name: 'action-1',
                      onAccept: (slot, component) {
                        print('onAccept: $slot, $component');
                        slots[slot] = component;
                      },
                    )
                  ],
                ),
                backgroundColor:
                    props['bodyBackgroundColor']?.value ?? Colors.white,
                body: Slot(
                  name: 'body',
                  component: body,
                  onAccept: (slot, component) {
                    print('onAccept: $slot, $component');
                    slots[slot] = component;
                  },
                  onRemove: (slot) {
                    slots.remove(slot);
                  },
                ),
              );
            });
}
