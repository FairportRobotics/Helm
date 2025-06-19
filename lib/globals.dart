library;

import "package:nt4/nt4.dart";

NT4Client ntClient = NT4Client(serverBaseAddress: '10.5.78.2', onConnect: () { print("NT4 Connected"); }, onDisconnect: () { print("NT4 Disconnected"); });

List<NT4Subscription> nt4Subscriptions = [];

NT4Subscription subscribe(String topic){

  NT4Subscription subscrip = ntClient.subscribe(topic, NT4SubscriptionOptions());

  nt4Subscriptions.add(subscrip);

  return subscrip;
}

List<NT4Topic> nt4Topics = [];
