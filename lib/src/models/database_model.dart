import 'package:meta/meta.dart';

import '../clients/couchdb_server_client.dart';
import 'base/database_base_model.dart';

class DatabaseModel extends DatabaseBaseModel {

  DatabaseModel(CouchDbServerClient client): super(client);

  @override
  Future<Map<String, List<String>>> headDbInfo(String dbName) async => await client.head(dbName);
  @override
  Future<Map<String, Object>> dbInfo(String dbName) async => await client.get(dbName);
  @override
  Future<String> createDb(String dbName) {}
  @override
  Future<String> deleteDb(String dbName) {}
  @override
  Future<String> createDocInDb(String dbName, { String batch }) {}
  @override
  Future<String> getAllDocs(String dbName) {}
  @override
  Future<String> getDocsByKeys(String dbName, List<String> keys) {}
  @override
  Future<String> getAllDesignDocs(
    String dbName,
    {
      bool conflicts = false,
      bool descending = false,
      String endKey,
      String endKeyDocId,
      bool includeDocs = false,
      bool inclusiveEnd = true,
      String key,
      String keys,
      int limit,
      int skip = 0,
      String startKey,
      String startKeyDocId,
      bool updateSeq = false
    }
  ) {}
  @override
  Future<String> getDesignDocsByKeys(String dbName, List<String> keys) {}
  @override
  Future<String> queriesDocsFrom(String dbName, List<String> keys) {}
  @override
  Future<String> getBulkDocs(List<Object> docs, { bool revs }) {}
  @override
  Future<List<String>> insertBulkDocs(List<Object> docs, { bool newEdits = true }) {}
  @override
  Future<String> find(
    String dbName,
    Object selector,
    {
      int limit = 25,
      int skip,
      List<Object> sort,
      List<String> fields,
      String useIndexString,
      List<String> useIndexList, // same as above parameter
      int r = 1,
      String bookmark,
      bool update = true,
      bool stable,
      String stale,
      bool executionStats = false
    }
  ) {}
  @override
  Future<String> createIndex(
    String dbName,
    {
      @required Object index,
      String ddoc,
      String name,
      String type = 'json',
      Object partialFilterSelector
    }
  ) {}
  @override
  Future<String> indexAt(String dbName) {}
  @override
  Future<String> deleteIndexDoc(String dbName, String designDoc, String name) {}
  @override
  Future<String> explain(
    String dbName,
    Object selector,
    {
      int limit = 25,
      int skip,
      List<Object> sort,
      List<String> fields,
      String useIndexString,
      List<String> useIndexList, // same as above parameter
      int r = 1,
      String bookmark,
      bool update = true,
      bool stable,
      String stale,
      bool executionStats = false
    }
  ) {}
  @override
  Future<String> changesIn(
    String dbName,
    {
      List<String> docIds,
      bool conflicts = false,
      bool descending = false,
      String feed = 'normal',
      String filter,
      int heartbeat = 60000,
      bool includeDocs = false,
      bool attachments = false,
      bool attEncodingInfo = false,
      int lastEventId,
      int limit,
      int since = 0,
      String style = 'main_only',
      int timeout = 60000, // ?
      String view,
      int seqInterval
    }
  ) {}
  // POST changes method will be soon
  @override
  Future<String> compact(String dbName) {}
  @override
  Future<String> compactViewIndexesWith({ String ddocName, String dbName }) {}
  @override
  Future<String> ensureFullCommit(String dbName) {}
  @override
  Future<String> viewCleanup(String dbName) {}
  @override
  Future<String> securityOf(String dbName) {}
  @override
  Future<String> setSecurityFor(String dbName, Object obj) {}
  @override
  Future<String> purgeOf(String dbName, Object obj) {}
  @override
  Future<String> missingRevs(String dbName, List<Object> revs) {}
  @override
  Future<String> revsDiff(String dbName, List<String> revs) {}
  @override
  Future<String> revsLimit(String dbName, int limit) {}
}