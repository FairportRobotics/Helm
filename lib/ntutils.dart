import "dart:ui";

import "package:nt4/nt4.dart";

class NTUtils {
  static final NTUtils _instance = NTUtils._internal();

  factory NTUtils() {
    return _instance;
  }

  bool isConnected = false;
  bool _isAttemptingToConnect = false;
  String _serverAddress = "";

  NT4Client? ntClient;

  final Map<String, NT4Subscription> _nt4Subscriptions = {};

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
    _isAttemptingToConnect = true;
    ntClient = NT4Client(
      serverBaseAddress: serverAddress,
      onConnect: () {
        isConnected = true;
        _isAttemptingToConnect = false;

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
    if (_isAttemptingToConnect) {
      return "Attempting to connect to $_serverAddress";
    }
    if (isConnected) {
      return "Connected";
    } else {
      return "Not Connected";
    }
  }

  NT4Subscription subscribe(String topic) {
    if (!_nt4Subscriptions.containsKey(topic)) {
      NT4Subscription subscrip = ntClient!.subscribe(
        topic,
        NT4SubscriptionOptions(),
      );
      _nt4Subscriptions[topic] = subscrip;
    }

    return _nt4Subscriptions[topic]!;
  }

  final Map<String, NT4Topic> _nt4Topics = {};

  NT4Topic getPublicTopic(String topic, String type) {
    if (!_nt4Topics.containsKey(topic)) {
      NT4Topic top = ntClient!.publishNewTopic(topic, type);
      _nt4Topics[topic] = top;
    }

    return _nt4Topics[topic]!;
  }

  NTUtils._internal();
}
