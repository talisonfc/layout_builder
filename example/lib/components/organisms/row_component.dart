import 'package:flutter/material.dart';
import 'package:layout_builder/component.dart';
import 'package:layout_builder/slot.dart';

class RowComponent extends Component {
  RowComponent()
      : super(
            name: 'Row',
            props: {
              'mainAxisAlignment': Property(
                  name: 'mainAxisAlignment',
                  value: MainAxisAlignment.start,
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
                  ])
            },
            previewBuilder: (props, slots) {
              return Row(
                mainAxisAlignment: props['mainAxisAlignment']?.value ??
                    MainAxisAlignment.start,
                children: [
                  Slot(),
                  Slot(),
                  Slot(),
                ],
              );
            });
}
