import 'package:couchdb/couchdb.dart';

/// Only provided for backward compatibility
@Deprecated('Use LocalDocuments instead')
class LocalDocumentModel extends LocalDocuments {
  LocalDocumentModel(ClientInterface client) : super(client);
}