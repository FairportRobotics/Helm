import "dart:ui";

import "package:nt4/nt4.dart";

class NTUtils {
  static final NTUtils _instance = NTUtils._internal();

  factory NTUtils() {
    return _instance;
  }

  bool isConnected = false;
  String _serverAddress = "";

  NT4Client? _ntClient;

  final List<VoidCallback> connectCallbacks = [];
  final List<VoidCallback> disconnectCallbacks = [];

  void addConnectCallback(VoidCallback cb) {
    connectCallbacks.add(cb);
  }

  void addDisconnectCallback(VoidCallback cb) {
    disconnectCallbacks.add(cb);
  }

  void connect(String serverAddress) {
    _serverAddress = serverAddress;
    _ntClient = NT4Client(
      serverBaseAddress: serverAddress,
      onConnect: () {
        isConnected = true;

        for (VoidCallback cb in connectCallbacks) {
          cb();
        }
      },
      onDisconnect: () {
        isConnected = false;

        for (VoidCallback cb in disconnectCallbacks) {
          cb();
        }
      },
    );
  }

  String connectionStatus() {
    if (isConnected) {
      return "Connected";
    } else {
      return "Not Connected. Attempting to connect to $_serverAddress";
    }
  }

  NT4Subscription subscribe(String topic) {
    NT4Subscription subscrip = _ntClient!.subscribe(
      topic,
      NT4SubscriptionOptions(),
    );
    return subscrip;
  }

  final Map<String, NT4Topic> _nt4Topics = {};

  NT4Topic getPublicTopic(String topic, String type) {
    if (!_nt4Topics.containsKey(topic)) {
      NT4Topic top = _ntClient!.publishNewTopic(topic, type);
      _nt4Topics[topic] = top;
    }

    return _nt4Topics[topic]!;
  }

  NTUtils._internal();
}
