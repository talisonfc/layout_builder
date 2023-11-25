import 'package:flutter/material.dart';

enum PropertyType { text, number, color, image, icon, list, map, boolean }

class PropertyOption {
  final String label;
  final dynamic value;

  PropertyOption({required this.label, required this.value});

  PropertyOption copyWith(
      {String? label,
      dynamic value,
      PropertyType? type,
      List<String>? options}) {
    return PropertyOption(
      label: label ?? this.label,
      value: value ?? this.value,
    );
  }
}

class Property {
  final String name;
  final PropertyType type;
  dynamic value;
  final List<PropertyOption>? options;
  final dynamic defaultValue;

  Property(
      {required this.name,
      this.value,
      this.type = PropertyType.text,
      this.options,
      this.defaultValue});

  Property copyWith({
    String? name,
    dynamic value,
    PropertyType? type,
    List<PropertyOption>? options,
    dynamic defaultValue,
  }) {
    return Property(
      name: name ?? this.name,
      value: value ?? this.value,
      type: type ?? this.type,
      options:
          (options ?? this.options ?? []).map((e) => e.copyWith()).toList(),
      defaultValue: defaultValue ?? this.defaultValue,
    );
  }
}

typedef MapOfProperties = Map<String, Property>;
typedef MapOfSlots = Map<String, Component>;

class Component {
  final int index;
  final int? parent;
  final String name;
  final Widget Function(MapOfProperties, MapOfSlots)? previewBuilder;
  final Map<String, dynamic> Function(MapOfProperties, MapOfSlots)? jsonBuilder;
  final Map<String, Property> props;
  Map<String, Component> slots = {};

  Component(
      {this.index = 0,
      this.parent,
      required this.name,
      this.previewBuilder,
      this.jsonBuilder,
      this.props = const {},
      Map<String, Component>? slots}) {
    if (slots != null) {
      this.slots = slots;
    }
  }

  Component copyWith(
      {int? index,
      String? name,
      Widget Function(MapOfProperties, MapOfSlots)? previewBuilder,
      Map<String, dynamic> Function(MapOfProperties, MapOfSlots)? jsonBuilder,
      Map<String, Property>? props,
      Map<String, Component>? slots}) {
    return Component(
        index: index ?? this.index,
        name: name ?? this.name,
        previewBuilder: previewBuilder ?? this.previewBuilder,
        jsonBuilder: jsonBuilder ?? this.jsonBuilder,
        props: (props ?? this.props)
            .map((key, prop) => MapEntry(key, prop.copyWith())),
        slots: (slots ?? this.slots)
            .map((key, component) => MapEntry(key, component.copyWith())));
  }

  @override
  String toString() {
    return 'Component{name: $name}';
  }

  Widget build(BuildContext context, {Component? parent}) {
    return previewBuilder != null
        ? previewBuilder!(props, slots)
        : Container(
            alignment: Alignment.center,
            color: Colors.blue[100],
            child: Text(
              name,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
