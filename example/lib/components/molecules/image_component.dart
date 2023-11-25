import 'package:flutter/material.dart';
import 'package:layout_builder/component.dart';

class ImageComponent extends Component {
  ImageComponent()
      : super(
            name: 'Image',
            props: {
              'url': Property(name: 'url', type: PropertyType.text),
            },
            previewBuilder: (props, slots) {
              return Placeholder(
                fallbackHeight: 100,
                fallbackWidth: 100,
              );
            });
}
