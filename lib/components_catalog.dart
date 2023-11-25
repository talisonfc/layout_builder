import 'package:flutter/material.dart';
import 'package:layout_builder/component.dart';

class ComponentsCatalog extends StatelessWidget {
  ComponentsCatalog({Key? key, this.components = const []}) : super(key: key);

  final List<Component> components;

  @override
  Widget build(BuildContext context) {
    return GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        children: components.map(
          (component) {
            return Draggable(
                data: component,
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.blue[100],
                  child: Text(
                    component.name,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                feedback: Material(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.blue[100],
                    width: 100,
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Center(
                        child: Text(
                          component.name,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ));
          },
        ).toList());
  }
}
