import '../clients/couchdb_client.dart';

/// Base component that hold connected [client]
abstract class Component {
  /// Creates instanse of [Component] with given [client]
  Component(this.client);

  /// Instance of connected client
  CouchDbClient client;
}
