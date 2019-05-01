import 'dart:convert';

import 'package:meta/meta.dart';

import '../clients/couchdb_client.dart';
import '../entities/db_response.dart';
import '../entities/database_model_response.dart';
import '../exceptions/couchdb_exception.dart';
import '../utils/includer_path.dart';
import 'base/database_base_model.dart';

/// Class that implements methods for interacting with entire database
/// in CouchDB
class DatabaseModel extends DatabaseBaseModel {
  /// Create DatabaseModel by accepting web-based or server-based client
  DatabaseModel(CouchDbClient client) : super(client);

  @override
  Future<DatabaseModelResponse> headDbInfo(String dbName) async {
    DbResponse info;
    try {
      info = await client.head(dbName);
    } on CouchDbException catch (e) {
      e.response = DbResponse(<String, String>{
        'error': 'Not found',
        'reason': 'Database doesn\'t exist.'
      }).errorResponse();
      rethrow;
    }
    return info.databaseModelResponse();
  }

  @override
  Future<DatabaseModelResponse> dbInfo(String dbName) async {
    DbResponse info;
    try {
      info = await client.get(dbName);
    } on CouchDbException {
      rethrow;
    }
    return info.databaseModelResponse();
  }

  @override
  Future<DatabaseModelResponse> createDb(String dbName, {int q = 8}) async {
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
    return result.databaseModelResponse();
  }

  @override
  Future<DatabaseModelResponse> deleteDb(String dbName) async {
    DbResponse result;

    try {
      result = await client.delete(dbName);
    } on CouchDbException {
      rethrow;
    }
    return result.databaseModelResponse();
  }

  @override
  Future<DatabaseModelResponse> createDocIn(
      String dbName, Map<String, Object> doc,
      {String batch, Map<String, String> headers}) async {
    DbResponse result;

    final path = '$dbName${includeNonNullParam('?batch', batch)}';

    try {
      result = await client.post(path, body: doc, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.databaseModelResponse();
  }

  @override
  Future<DatabaseModelResponse> allDocs(String dbName,
      {bool includeDocs = false}) async {
    DbResponse result;

    try {
      result = await client.get('$dbName/_all_docs?include_docs=$includeDocs');
    } on CouchDbException {
      rethrow;
    }
    return result.databaseModelResponse();
  }

  @override
  Future<DatabaseModelResponse> docsByKeys(String dbName,
      {List<String> keys}) async {
    DbResponse result;

    final body = <String, List<String>>{'keys': keys};

    try {
      result = keys == null
          ? await client.post('$dbName/_all_docs')
          : await client.post('$dbName/_all_docs', body: body);
    } on CouchDbException {
      rethrow;
    }
    return result.databaseModelResponse();
  }

  @override
  Future<DatabaseModelResponse> allDesignDocs(String dbName,
      {bool conflicts = false,
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
      bool updateSeq = false}) async {
    DbResponse result;

    final path =
        '$dbName/_design_docs?conflicts=$conflicts&descending=$descending&'
        '${includeNonNullParam('endkey', endKey)}&${includeNonNullParam('endkey_docid', endKeyDocId)}&'
        'include_docs=$includeDocs&inclusive_end=$inclusiveEnd&${includeNonNullParam('key', key)}&'
        '${includeNonNullParam('keys', keys)}&${includeNonNullParam('limit', limit)}&'
        'skip=$skip&${includeNonNullParam('startkey', startKey)}&${includeNonNullParam('startkey_docid', startKeyDocId)}&'
        'update_seq=$updateSeq';

    try {
      result = await client.get(path);
    } on CouchDbException {
      rethrow;
    }
    return result.databaseModelResponse();
  }

  @override
  Future<DatabaseModelResponse> designDocsByKeys(
      String dbName, List<String> keys) async {
    DbResponse result;

    final body = <String, List<String>>{'keys': keys};

    try {
      result = await client.post('$dbName/_design_docs', body: body);
    } on CouchDbException {
      rethrow;
    }
    return result.databaseModelResponse();
  }

  @override
  Future<DatabaseModelResponse> queriesDocsFrom(
      String dbName, List<Map<String, Object>> queries) async {
    DbResponse result;

    final body = <String, List<Map<String, Object>>>{'queries': queries};

    try {
      result = await client.post('$dbName/_all_docs/queries', body: body);
    } on CouchDbException {
      rethrow;
    }
    return result.databaseModelResponse();
  }

  @override
  Future<DatabaseModelResponse> bulkDocs(String dbName, List<Object> docs,
      {@required bool revs}) async {
    DbResponse result;

    final body = <String, List<Object>>{'docs': docs};

    try {
      result = await client.post('$dbName?revs=$revs', body: body);
    } on CouchDbException {
      rethrow;
    }
    return result.databaseModelResponse();
  }

  @override
  Future<DatabaseModelResponse> insertBulkDocs(String dbName, List<Object> docs,
      {bool newEdits = true, Map<String, String> headers}) async {
    DbResponse result;

    final body = <String, Object>{'docs': docs, 'new_edits': newEdits};

    try {
      result = await client.post('$dbName/_bulk_docs',
          body: body, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.databaseModelResponse();
  }

  @override
  Future<DatabaseModelResponse> find(
      String dbName, Map<String, Object> selector,
      {int limit = 25,
      int skip,
      List<Object> sort,
      List<String> fields,
      Object useIndex,
      int r = 1,
      String bookmark,
      bool update = true,
      bool stable,
      String stale = 'false',
      bool executionStats = false}) async {
    DbResponse result;

    final body = <String, Object>{
      'selector': selector,
      'limit': limit,
      'r': r,
      'bookmark': bookmark,
      'update': update,
      'stale': stale,
      'execution_stats': executionStats
    };
    if (skip != null) {
      body['skip'] = skip;
    }
    if (sort != null) {
      body['sort'] = sort;
    }
    if (fields != null) {
      body['fields'] = fields;
    }
    if (useIndex != null) {
      body['use_index'] = useIndex;
    }
    if (stable != null) {
      body['stable'] = stable;
    }

    try {
      result = await client.post('$dbName/_find', body: body);
    } on CouchDbException {
      rethrow;
    }
    return result.databaseModelResponse();
  }

  @override
  Future<DatabaseModelResponse> createIndexIn(String dbName,
      {@required List<String> indexFields,
      String ddoc,
      String name,
      String type = 'json',
      Map<String, Object> partialFilterSelector}) async {
    DbResponse result;

    final body = <String, Object>{
      'index': <String, List<String>>{'fields': indexFields},
      'type': type
    };
    if (ddoc != null) {
      body['ddoc'] = ddoc;
    }
    if (name != null) {
      body['name'] = name;
    }
    if (partialFilterSelector != null) {
      body['partial_filter_selector'] = partialFilterSelector;
    }

    try {
      result = await client.post('$dbName/_index', body: body);
    } on CouchDbException {
      rethrow;
    }
    return result.databaseModelResponse();
  }

  @override
  Future<DatabaseModelResponse> indexesAt(String dbName) async {
    DbResponse result;

    try {
      result = await client.get('$dbName/_index');
    } on CouchDbException {
      rethrow;
    }
    return result.databaseModelResponse();
  }

  @override
  Future<DatabaseModelResponse> deleteIndexIn(
      String dbName, String designDoc, String name) async {
    DbResponse result;

    try {
      result = await client.delete('$dbName/_index/$designDoc/json/$name');
    } on CouchDbException {
      rethrow;
    }
    return result.databaseModelResponse();
  }

  @override
  Future<DatabaseModelResponse> explain(
      String dbName, Map<String, Object> selector,
      {int limit = 25,
      int skip,
      List<Object> sort,
      List<String> fields,
      Object useIndex,
      int r = 1,
      String bookmark,
      bool update = true,
      bool stable,
      String stale = 'false',
      bool executionStats = false}) async {
    DbResponse result;

    final body = <String, Object>{
      'selector': selector,
      'limit': limit,
      'r': r,
      'bookmark': bookmark,
      'update': update,
      'stale': stale,
      'execution_stats': executionStats
    };
    if (skip != null) {
      body['skip'] = skip;
    }
    if (sort != null) {
      body['sort'] = sort;
    }
    if (fields != null) {
      body['fields'] = fields;
    }
    if (useIndex != null) {
      body['use_index'] = useIndex;
    }
    if (stable != null) {
      body['stable'] = stable;
    }

    try {
      result = await client.post('$dbName/_explain', body: body);
    } on CouchDbException {
      rethrow;
    }
    return result.databaseModelResponse();
  }

  @override
  Future<DatabaseModelResponse> shards(String dbName) async {
    DbResponse result;

    try {
      result = await client.get('$dbName/_shards');
    } on CouchDbException {
      rethrow;
    }
    return result.databaseModelResponse();
  }

  @override
  Future<DatabaseModelResponse> shard(String dbName, String docId) async {
    DbResponse result;

    try {
      result = await client.get('$dbName/_shards/$docId');
    } on CouchDbException {
      rethrow;
    }
    return result.databaseModelResponse();
  }

  @override
  Future<DatabaseModelResponse> synchronizeShards(String dbName) async {
    DbResponse result;

    try {
      result = await client.post('$dbName/_sync_shards');
    } on CouchDbException {
      rethrow;
    }
    return result.databaseModelResponse();
  }

  @override
  Future<Stream<DbResponse>> changesIn(String dbName,
      {List<String> docIds,
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
      int seqInterval}) async {
    Stream<DbResponse> result;

    final path =
        '$dbName/_changes?${includeNonNullParam('doc_ids', docIds)}&conflicts=$conflicts&'
        'descending=$descending&feed=$feed&${includeNonNullParam('filter', filter)}&heartbeat=$heartbeat&'
        'include_docs=$includeDocs&attachments=$attachments&att_encoding_info=$attEncodingInfo&'
        '${includeNonNullParam('last-event-id', lastEventId)}&${includeNonNullParam('limit', limit)}&'
        'since=$since&style=$style&timeout=$timeout&${includeNonNullParam('view', view)}&'
        '${includeNonNullParam('seq_interval', seqInterval)}';

    try {
      final streamedRes = await client.streamed('get', path);
      switch (feed) {
        case 'longpoll':
          var strRes = await streamedRes.join();
          strRes = '{"result": [$strRes';
          result = Stream<DbResponse>.fromFuture(
              Future<DbResponse>.value(DbResponse(jsonDecode(strRes))));
          break;
        case 'continuous':
          final mappedRes =
              streamedRes.map((v) => v.replaceAll('}\n{', '},\n{'));
          result =
              mappedRes.map((v) => DbResponse(jsonDecode('{"result": [$v]}')));
          break;
        case 'eventsource':
          final mappedRes = streamedRes
              .map((v) => v.replaceAll(RegExp('\n+data'), '},\n{data'))
              .map((v) => v.replaceAll('data', '"data"'))
              .map((v) => v.replaceAll('\nid', ',\n"id"'));
          result = mappedRes
              .map((v) => DbResponse(jsonDecode('{"result": [{$v}]}')));
          break;
        default:
          var strRes = await streamedRes.join();
          strRes = '{"result": [$strRes';
          result = Stream<DbResponse>.fromFuture(
              Future<DbResponse>.value(DbResponse(jsonDecode(strRes))));
      }
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<Stream<DbResponse>> postChangesIn(String dbName,
      {List<String> docIds,
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
      int seqInterval}) async {
    Stream<DbResponse> result;

    final path = '$dbName/_changes?conflicts=$conflicts&'
        'descending=$descending&feed=$feed&filter=$filter&heartbeat=$heartbeat&'
        'include_docs=$includeDocs&attachments=$attachments&att_encoding_info=$attEncodingInfo&'
        '${includeNonNullParam('last-event-id', lastEventId)}&${includeNonNullParam('limit', limit)}&'
        'since=$since&style=$style&timeout=$timeout&${includeNonNullParam('view', view)}&'
        '${includeNonNullParam('seq_interval', seqInterval)}';

    final body = <String, List<String>>{'doc_ids': docIds};

    try {
      //result = await client.post(path, body: body);
      final streamedRes = await client.streamed('post', path, body: body);
      switch (feed) {
        case 'longpoll':
          var strRes = await streamedRes.join();
          strRes = '{"result": [$strRes';
          result = Stream<DbResponse>.fromFuture(
              Future<DbResponse>.value(DbResponse(jsonDecode(strRes))));
          break;
        case 'continuous':
          final mappedRes =
              streamedRes.map((v) => v.replaceAll('}\n{', '},\n{'));
          result =
              mappedRes.map((v) => DbResponse(jsonDecode('{"result": [$v]}')));
          break;
        case 'eventsource':
          final mappedRes = streamedRes
              .map((v) => v.replaceAll(RegExp('\n+data'), '},\n{data'))
              .map((v) => v.replaceAll('data', '"data"'))
              .map((v) => v.replaceAll('\nid', ',\n"id"'));
          result = mappedRes
              .map((v) => DbResponse(jsonDecode('{"result": [{$v}]}')));
          break;
        default:
          var strRes = await streamedRes.join();
          strRes = '{"result": [$strRes';
          result = Stream<DbResponse>.fromFuture(
              Future<DbResponse>.value(DbResponse(jsonDecode(strRes))));
      }
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DatabaseModelResponse> compact(String dbName) async {
    DbResponse result;

    try {
      result = await client.post('$dbName/_compact');
    } on CouchDbException {
      rethrow;
    }
    return result.databaseModelResponse();
  }

  @override
  Future<DatabaseModelResponse> compactViewIndexesWith(
      String dbName, String ddocName) async {
    DbResponse result;

    try {
      result = await client.post('$dbName/_compact/$ddocName');
    } on CouchDbException {
      rethrow;
    }
    return result.databaseModelResponse();
  }

  @override
  Future<DatabaseModelResponse> ensureFullCommit(String dbName) async {
    DbResponse result;

    try {
      result = await client.post('$dbName/_ensure_full_commit');
    } on CouchDbException {
      rethrow;
    }
    return result.databaseModelResponse();
  }

  @override
  Future<DatabaseModelResponse> viewCleanup(String dbName) async {
    DbResponse result;

    try {
      result = await client.post('$dbName/_view_cleanup');
    } on CouchDbException {
      rethrow;
    }
    return result.databaseModelResponse();
  }

  @override
  Future<DatabaseModelResponse> securityOf(String dbName) async {
    DbResponse result;

    try {
      result = await client.get('$dbName/_security');
    } on CouchDbException {
      rethrow;
    }
    return result.databaseModelResponse();
  }

  @override
  Future<DatabaseModelResponse> setSecurityFor(
      String dbName, Map<String, Map<String, List<String>>> security) async {
    DbResponse result;

    try {
      result = await client.put('$dbName/_security', body: security);
    } on CouchDbException {
      rethrow;
    }
    return result.databaseModelResponse();
  }

  @override
  Future<DatabaseModelResponse> purge(
      String dbName, Map<String, List<String>> docs) async {
    DbResponse result;

    try {
      result = await client.post('$dbName/_purge', body: docs);
    } on CouchDbException {
      rethrow;
    }
    return result.databaseModelResponse();
  }

  @override
  Future<DatabaseModelResponse> purgedInfosLimit(String dbName) async {
    DbResponse result;

    try {
      result = await client.get('$dbName/_purged_infos_limit');
    } on CouchDbException {
      rethrow;
    }
    return result.databaseModelResponse();
  }

  @override
  Future<DatabaseModelResponse> setPurgedInfosLimit(
      String dbName, int limit) async {
    DbResponse result;

    try {
      result = await client.put('$dbName/_purged_infos_limit', body: limit);
    } on CouchDbException {
      rethrow;
    }
    return result.databaseModelResponse();
  }

  @override
  Future<DatabaseModelResponse> missingRevs(
      String dbName, Map<String, List<String>> revs) async {
    DbResponse result;

    try {
      result = await client.post('$dbName/_missing_revs', body: revs);
    } on CouchDbException {
      rethrow;
    }
    return result.databaseModelResponse();
  }

  @override
  Future<DatabaseModelResponse> revsDiff(
      String dbName, Map<String, List<String>> revs) async {
    DbResponse result;

    try {
      result = await client.post('$dbName/_revs_diff', body: revs);
    } on CouchDbException {
      rethrow;
    }
    return result.databaseModelResponse();
  }

  @override
  Future<DatabaseModelResponse> revsLimitOf(String dbName) async {
    DbResponse result;

    try {
      result = await client.get('$dbName/_revs_limit');
    } on CouchDbException {
      rethrow;
    }
    return result.databaseModelResponse();
  }

  /// Sets the maximum number of document revisions that will be tracked by CouchDB,
  /// even after compaction has occurred
  @override
  Future<DatabaseModelResponse> setRevsLimit(String dbName, int limit) async {
    DbResponse result;

    try {
      result = await client.put('$dbName/_revs_limit', body: limit);
    } on CouchDbException {
      rethrow;
    }
    return result.databaseModelResponse();
  }
}
