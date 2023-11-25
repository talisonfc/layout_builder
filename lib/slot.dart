import 'package:flutter/material.dart';
import 'package:layout_builder/component.dart';
import 'package:layout_builder/settings/event_hub.dart';
import 'package:layout_builder/slot_state.dart';

class Slot extends StatefulWidget {
  Slot({Key? key, this.name, this.component, this.onAccept, this.onRemove})
      : super(key: key);

  final String? name;
  final Component? component;
  final Function(String slotName, Component component)? onAccept;
  final Function(String slotName)? onRemove;

  @override
  _SlotState createState() => _SlotState();
}

class _SlotState extends State<Slot> {
  Component? root;
  FocusNode focusNode = FocusNode();
  bool isFocused = false;
  OverlayEntry? overlayEntry;

  void listenUpdate(dynamic component) {
    setState(() {
      root = component;
    });
    widget.onAccept?.call(widget.name!, component);
  }

  @override
  void initState() {
    super.initState();
    if (widget.component != null) {
      onAccept(widget.component!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return root != null
        ? MouseRegion(
            onEnter: (event) {
              focusNode.requestFocus();
              // overlayEntry = OverlayEntry(builder: (context) {
              //   return Positioned(
              //     left: event.position.dx,
              //     top: event.position.dy,
              //     child: Container(
              //       width: 100.0,
              //       height: 100.0,
              //       color: Colors.blue,
              //     ),
              //   );
              // });
              // Overlay.of(context).insert(overlayEntry!);
            },
            onExit: (event) {
              focusNode.unfocus();
              // overlayEntry?.remove();
            },
            child: Focus(
              focusNode: focusNode,
              onFocusChange: (focus) {
                setState(() {
                  isFocused = focus;
                });
              },
              child: GestureDetector(
                onTap: () {
                  EventHub().publish('settings', root);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: isFocused
                        ? Border.all(
                            color: Colors.blue,
                            width: 2.0,
                          )
                        : null,
                  ),
                  child: root!.build(context),
                ),
              ),
            ),
          )
        : DragTarget<Component>(
            builder: (context, candidateData, rejectedData) {
              return Container(
                color: Colors.blue[100],
                child: const Center(
                  child: Text(
                    'Slot',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
            onAccept: onAccept,
          );
  }

  void onAccept(component) {
    final index = SlotState.generateIndex();
    EventHub().subscribe('update-$index', listenUpdate);
    EventHub().subscribe('remove-$index', (data) {
      EventHub().unsubscribe('remove-$index');
      widget.onRemove?.call(widget.name!);
      setState(() {
        root = null;
      });
    });
    setState(() {
      root = component.copyWith(index: index);
    });
    widget.onAccept?.call(widget.name!, root!);
  }

  Map<String, dynamic> toJson() {
    return root?.jsonBuilder?.call(root!.props, root!.slots) ??
        <String, dynamic>{};
  }
}
