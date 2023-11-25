class EventHub {
  static final EventHub _instance = EventHub._internal();

  factory EventHub() {
    return _instance;
  }

  EventHub._internal();

  static Map<String, Function(dynamic)> _subscriptions = {};

  void publish(String topic, dynamic data) {
    _subscriptions[topic]?.call(data);
  }

  void subscribe(String topic, void Function(dynamic) callback) {
    _subscriptions.putIfAbsent(topic, () => callback);
  }

  void unsubscribe(String topic) {
    _subscriptions.remove(topic);
  }
}
