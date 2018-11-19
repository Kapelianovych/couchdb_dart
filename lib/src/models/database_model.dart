import 'package:meta/meta.dart';

import '../clients/base/couchdb_base_client.dart';
import '../entities/db_response.dart';
import '../exceptions/couchdb_exception.dart';
import 'base/database_base_model.dart';

class DatabaseModel extends DatabaseBaseModel {

  DatabaseModel(CouchDbBaseClient client): super(client);

  @override
  Future<DbResponse> headDbInfo(String dbName) async {
    DbResponse info;
    try {
      info = await client.head(dbName);
    } on CouchDbException catch (e) {
      e.response = DbResponse(error: 'Not found', reason: 'Database doesn\'t exist.');
      rethrow;
    }
    return info;
  }

  @override
  Future<DbResponse> dbInfo(String dbName) async {
    DbResponse info;
    try {
      info = await client.get(dbName);
    } on CouchDbException {
      rethrow;
    }
    return info;
  }

  @override
  Future<DbResponse> createDb(String dbName, { int q = 8 }) async {
    final regexp = RegExp(r'^[a-z][a-z0-9_$()+/-]*$');
    DbResponse result;

    if (!regexp.hasMatch(dbName)) {
      throw ArgumentError(r'''Incorrect db name!
      Name must be validating by this rules:
        - Name must begin with a lowercase letter (a-z)
        - Lowercase characters (a-z)
        - Digits (0-9)
        - Any of the characters _, $, (, ), +, -, and /.''');
    }

    final path = '$dbName?q=$q';
    try {
      result = await client.put(path);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> deleteDb(String dbName) async {
    DbResponse result;

    try {
      result = await client.delete(dbName);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> createDocInDb(String dbName, Map<String, Object> doc, { String batch, Map<String, String> headers }) async {
    DbResponse result;

    final path = batch != null ? '$dbName?batch=$batch' : '$dbName';

    try {
      result = await client.post(path, body: doc, headers: headers);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> getAllDocs(String dbName) async {
    DbResponse result;

    try {
      result = await client.get('$dbName/_all_docs');
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> getDocsByKeys(String dbName, { List<String> keys }) async {
    DbResponse result;

    final body = <String, List<String>>{ 'keys': keys };

    try {
      result = keys == null
        ? await client.post('$dbName/_all_docs')
        : await client.post('$dbName/_all_docs', body: body);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
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
  ) async {
    DbResponse result;

    // try {

    // }
  }

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