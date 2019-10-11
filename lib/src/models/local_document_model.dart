import 'package:couchdb/couchdb.dart';

/// Only provided for backward compatibility
@Deprecated("Use LocalDocuments innstead")
class LocalDocumentModel extends LocalDocuments {
  LocalDocumentModel(ClientInterface client) : super(client);
}