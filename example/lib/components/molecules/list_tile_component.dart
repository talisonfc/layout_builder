import 'package:flutter/material.dart';
import 'package:layout_builder/component.dart';

class ListTileComponent extends Component {
  ListTileComponent()
      : super(
            name: 'ListTile',
            props: {
              'title': Property(name: 'title', value: 'ListTile'),
              'subtitle': Property(name: 'subtitle', value: 'ListTile'),
            },
            jsonBuilder: (props, slots) {
              return {
                'ListTile': {
                  'title': props['title']?.value,
                  'subtitle': props['subtitle']?.value,
                }
              };
            },
            previewBuilder: (props, slotsw) {
              return ListTile(
                title: Text(props['title']?.value),
                subtitle: Text(props['subtitle']?.value),
              );
            });
}
