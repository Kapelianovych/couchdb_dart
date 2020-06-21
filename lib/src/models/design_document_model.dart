import 'package:couchdb/couchdb.dart';

/// Only provided for backward compatibility
@Deprecated('Use DesignDocuments instead')
class DesignDocumentModel extends DesignDocuments {
  DesignDocumentModel(ClientInterface client) : super(client);
}