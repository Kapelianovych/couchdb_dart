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
  Future<DbResponse> getDesignDocsByKeys(String dbName, List<String> keys);
  Future<DbResponse> queriesDocsFrom(String dbName, List<Object> keys);
  Future<DbResponse> getBulkDocs(String dbName, List<Object> docs, { @required bool revs });
  Future<DbResponse> insertBulkDocs(String dbName, List<Object> docs, { bool newEdits = true, Map<String, String> headers });
  Future<DbResponse> find(
    String dbName,
    Map<String, Object> selector,
    {
      int limit = 25,
      int skip,
      List<Object> sort,
      List<String> fields,
      Object useIndex,
      int r = 1,
      String bookmark,
      bool update = true,
      bool stable,
      String stale = 'false',
      bool executionStats = false
    }
  );
  Future<DbResponse> createIndexIn(
    String dbName,
    {
      @required List<String> indexFields,
      String ddoc,
      String name,
      String type = 'json',
      Map<String, Object> partialFilterSelector
    }
  );
  Future<DbResponse> indexAt(String dbName);
  Future<DbResponse> deleteIndexIn(String dbName, String designDoc, String name);
  Future<DbResponse> explain(
    String dbName,
    Map<String, Object> selector,
    {
      int limit = 25,
      int skip,
      List<Object> sort,
      List<String> fields,
      Object useIndex,
      int r = 1,
      String bookmark,
      bool update = true,
      bool stable,
      String stale = 'false',
      bool executionStats = false
    }
  );
  Future<DbResponse> changesIn(
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
      String since = '0',
      String style = 'main_only',
      int timeout = 60000,
      String view,
      int seqInterval
    }
  );
  Future<DbResponse> postChangesIn(
    String dbName,
    {
      List<String> docIds,
      bool conflicts = false,
      bool descending = false,
      String feed = 'normal',
      String filter = '_doc_ids',
      int heartbeat = 60000,
      bool includeDocs = false,
      bool attachments = false,
      bool attEncodingInfo = false,
      int lastEventId,
      int limit,
      String since = '0',
      String style = 'main_only',
      int timeout = 60000,
      String view,
      int seqInterval
    }
  );
  Future<DbResponse> compact(String dbName);
  Future<DbResponse> compactViewIndexesWith(String dbName, String ddocName);
  Future<DbResponse> ensureFullCommit(String dbName);
  Future<DbResponse> viewCleanup(String dbName);
  Future<DbResponse> securityOf(String dbName);
  Future<DbResponse> setSecurityFor(String dbName, Map<String, Map<String, List<String>>> security);
  Future<DbResponse> purge(String dbName, Map<String, List<String>> docs);
  Future<DbResponse> missingRevs(String dbName, Map<String, List<String>> revs);
  Future<DbResponse> revsDiff(String dbName, Map<String, List<String>> revs);
  Future<DbResponse> revsLimitOf(String dbName);
  Future<DbResponse> setRevsLimit(String dbName, int limit);
}