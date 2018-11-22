import 'package:meta/meta.dart';

import '../../clients/base/couchdb_base_client.dart';
import 'base_model.dart';

/// Class is under heavy development - don't use it for implementing your own methods!
abstract class LocalDocumentBaseModel extends BaseModel {
  LocalDocumentBaseModel(CouchDbBaseClient client) : super(client);

  Future<String> localDocs(String dbName,
      {bool conflicts = false,
      bool descending = false,
      String endKey,
      String endKeyDocId,
      bool includeDocs = false,
      bool inclusiveEnd = true,
      String key,
      List<String> keys,
      int limit,
      int skip = 0,
      String startKey,
      String startKeyDocId,
      bool updateSeq = false});
  Future<String> localDocsWithKeys(String dbName,
      {@required List<String> keys,
      bool conflicts = false,
      bool descending = false,
      String endKey,
      String endKeyDocId,
      bool includeDocs = false,
      bool inclusiveEnd = true,
      String key,
      int limit,
      int skip = 0,
      String startKey,
      String startKeyDocId,
      bool updateSeq = false});
  Future<String> getLocalDoc(String dbName, String docId);
  Future<String> putLocalDoc(String dbName, String docId);
  Future<String> deleteLocalDoc(String dbName, String docId);
  Future<String> copyLocalDoc(String dbName, String docId);
}
