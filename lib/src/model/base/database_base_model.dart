import 'dart:async';

import 'package:meta/meta.dart';

import '../../couchdb_client.dart';
import 'base_model.dart';

abstract class DatabaseBaseModel extends BaseModel {

  DatabaseBaseModel(CouchDbClient client): super(client);

  // HEAD {db} will be soon
  Future<String> dbInfo(String dbName);
  Future<String> createDb(String dbName);
  Future<String> deleteDb(String dbName);
  Future<String> createDocInDb(String dbName, { String batch });
  Future<String> getAllDocs(String dbName);
  Future<String> getDocsByKeys(String dbName, List<String> keys);
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
  );
  Future<String> getDesignDocsByKeys(String dbName, List<String> keys);
  Future<String> queriesDocsFrom(String dbName, List<String> keys);
  Future<String> getBulkDocs(List<Object> docs, { bool revs });
  Future<List<String>> insertBulkDocs(List<Object> docs, { bool newEdits = true });
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
  );
  Future<String> createIndex(
    String dbName,
    {
      @required Object index,
      String ddoc,
      String name,
      String type = 'json',
      Object partialFilterSelector
    }
  );
  Future<String> indexAt(String dbName);
  Future<String> deleteIndexDoc(String dbName, String designDoc, String name);
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
  );
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
  );
  // POST changes method will be soon
  Future<String> compact(String dbName);
  Future<String> compactViewIndexesWith({ String ddocName, String dbName });
  Future<String> ensureFullCommit(String dbName);
  Future<String> viewCleanup(String dbName);
  Future<String> securityOf(String dbName);
  Future<String> setSecurityFor(String dbName, Object obj);
  Future<String> purgeOf(String dbName, Object obj);
  Future<String> missingRevs(String dbName, List<Object> revs);
  Future<String> revsDiff(String dbName, List<String> revs);
  Future<String> revsLimit(String dbName, int limit);
}