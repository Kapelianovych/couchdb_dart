import 'package:couchdb/couchdb.dart';

/// Only provided for backward compatibility
@Deprecated('Use Databases instead')
class DatabaseModel extends Databases {
  DatabaseModel(ClientInterface client) : super(client);
}