import 'package:couchdb/couchdb.dart';

/// Only provided for backward compatibility
@Deprecated('Use Server instead')
class ServerModel extends Server {
  ServerModel(ClientInterface client) : super(client);
}