import '../../clients/couchdb_client.dart';

/// Base model that hold connected [client]
abstract class BaseModel {
  /// Creates instanse of [BaseModel] with given [client]
  BaseModel(this.client);

  /// Instance of connected client
  CouchDbClient client;
}
