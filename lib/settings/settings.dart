import 'package:flutter/material.dart';
import 'package:layout_builder/component.dart';
import 'package:layout_builder/settings/event_hub.dart';

class Settings extends StatefulWidget {
  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {
  Component? component;

  @override
  void initState() {
    super.initState();
    EventHub().subscribe('settings', (obj) {
      setState(() {
        component = obj;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return component != null
        ? ListView(
            children: [
              ...component!.props.values.toList().map((prop) {
                if (prop.type == PropertyType.list) {
                  return DropdownButton(
                      hint: Text(prop.name),
                      items: (prop.options ?? []).map((op) {
                        return DropdownMenuItem(
                            child: Text(op.label), value: op.value);
                      }).toList(),
                      onChanged: (v) {
                        prop.value = v;
                      });
                } else if (prop.type == PropertyType.number) {
                  return TextField(
                    controller: TextEditingController(text: '${prop.value}'),
                    onChanged: (value) {
                      prop.value = int.parse(value);
                    },
                  );
                } else if (prop.type == PropertyType.boolean) {
                  return Switch(
                      value: prop.value,
                      onChanged: (value) {
                        prop.value = value;
                      });
                }
                return TextField(
                  controller: TextEditingController(text: prop.value),
                  onChanged: (value) {
                    prop.value = value;
                  },
                );
              }).toList(),
              ElevatedButton(
                  onPressed: () {
                    EventHub().publish('update-${component!.index}', component);
                  },
                  child: Text('Save')),
              ElevatedButton(
                  onPressed: () {
                    EventHub().unsubscribe('update-${component!.index}');
                    EventHub().publish('remove-${component!.index}', null);
                  },
                  child: Text('Remover'))
            ],
          )
        : Container();
  }
}
