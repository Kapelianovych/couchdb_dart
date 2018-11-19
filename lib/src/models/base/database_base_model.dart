import 'package:meta/meta.dart';

import '../../clients/base/couchdb_base_client.dart';
import '../../entities/db_response.dart';
import 'base_model.dart';

abstract class DatabaseBaseModel extends BaseModel {

  DatabaseBaseModel(CouchDbBaseClient client): super(client);

  Future<DbResponse> headDbInfo(String dbName);
  Future<DbResponse> dbInfo(String dbName);
  Future<DbResponse> createDb(String dbName, { int q = 8 });
  Future<DbResponse> deleteDb(String dbName);
  Future<DbResponse> createDocInDb(String dbName, Map<String, Object> doc, { String batch, Map<String, String> headers });
  Future<DbResponse> getAllDocs(String dbName);
  Future<DbResponse> getDocsByKeys(String dbName, { List<String> keys });
  Future<DbResponse> getAllDesignDocs(
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