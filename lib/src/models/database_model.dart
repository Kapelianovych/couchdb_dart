import 'package:meta/meta.dart';

import '../clients/base/couchdb_base_client.dart';
import '../entities/db_response.dart';
import '../exceptions/couchdb_exception.dart';
import '../utils/includer_path.dart';
import 'base/database_base_model.dart';

/// Class that implements methods for interacting with entire database in CouchDB
class DatabaseModel extends DatabaseBaseModel {
  /// Create DatabaseModel by accepting web-based or server-based client
  DatabaseModel(CouchDbBaseClient client) : super(client);

  @override
  Future<DbResponse> headDbInfo(String dbName) async {
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
  Future<DbResponse> createDb(String dbName, {int q = 8}) async {
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
  Future<DbResponse> createDocIn(String dbName, Map<String, Object> doc,
      {String batch, Map<String, String> headers}) async {
    DbResponse result;

    final path = '$dbName${includeNonNullParam('?batch', batch)}';

    try {
      result = await client.post(path, body: doc, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> allDocs(String dbName, {bool includeDocs = false}) async {
    DbResponse result;

    try {
      result = await client.get('$dbName/_all_docs?include_docs=$includeDocs');
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> docsByKeys(String dbName, {List<String> keys}) async {
    DbResponse result;

    final body = <String, List<String>>{'keys': keys};

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
  Future<DbResponse> allDesignDocs(String dbName,
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
    return result;
  }

  @override
  Future<DbResponse> designDocsByKeys(String dbName, List<String> keys) async {
    DbResponse result;

    final body = <String, List<String>>{'keys': keys};

    try {
      result = await client.post('$dbName/_design_docs', body: body);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> queriesDocsFrom(
      String dbName, List<Map<String, Object>> queries) async {
    DbResponse result;

    final body = <String, List<Map<String, Object>>>{'queries': queries};

    try {
      result = await client.post('$dbName/_all_docs/queries', body: body);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> bulkDocs(String dbName, List<Object> docs,
      {@required bool revs}) async {
    DbResponse result;

    final body = <String, List<Object>>{'docs': docs};

    try {
      result = await client.post('$dbName?revs=$revs', body: body);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> insertBulkDocs(String dbName, List<Object> docs,
      {bool newEdits = true, Map<String, String> headers}) async {
    DbResponse result;

    final body = <String, Object>{'docs': docs, 'new_edits': newEdits};

    try {
      result = await client.post('$dbName/_bulk_docs',
          body: body, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> find(String dbName, Map<String, Object> selector,
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
    return result;
  }

  @override
  Future<DbResponse> createIndexIn(String dbName,
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
    return result;
  }

  @override
  Future<DbResponse> indexesAt(String dbName) async {
    DbResponse result;

    try {
      result = await client.get('$dbName/_index');
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> deleteIndexIn(
      String dbName, String designDoc, String name) async {
    DbResponse result;

    try {
      result = await client.delete('$dbName/_index/$designDoc/json/$name');
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> explain(String dbName, Map<String, Object> selector,
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
    return result;
  }

  @override
  Future<DbResponse> changesIn(String dbName,
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
    DbResponse result;

    final path =
        '$dbName/_changes?${includeNonNullParam('doc_ids', docIds)}&conflicts=$conflicts&'
        'descending=$descending&feed=$feed&${includeNonNullParam('filter', filter)}&heartbeat=$heartbeat&'
        'include_docs=$includeDocs&attachments=$attachments&att_encoding_info=$attEncodingInfo&'
        '${includeNonNullParam('last-event-id', lastEventId)}&${includeNonNullParam('limit', limit)}&'
        'since=$since&style=$style&timeout=$timeout&${includeNonNullParam('view', view)}&'
        '${includeNonNullParam('seq_interval', seqInterval)}';

    try {
      result = await client.get(path);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> postChangesIn(String dbName,
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
    DbResponse result;

    final path = '$dbName/_changes?conflicts=$conflicts&'
        'descending=$descending&feed=$feed&filter=$filter&heartbeat=$heartbeat&'
        'include_docs=$includeDocs&attachments=$attachments&att_encoding_info=$attEncodingInfo&'
        '${includeNonNullParam('last-event-id', lastEventId)}&${includeNonNullParam('limit', limit)}&'
        'since=$since&style=$style&timeout=$timeout&${includeNonNullParam('view', view)}&'
        '${includeNonNullParam('seq_interval', seqInterval)}';

    final body = <String, List<String>>{'doc_ids': docIds};

    try {
      result = await client.post(path, body: body);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> compact(String dbName) async {
    DbResponse result;

    try {
      result = await client.post('$dbName/_compact');
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> compactViewIndexesWith(
      String dbName, String ddocName) async {
    DbResponse result;

    try {
      result = await client.post('$dbName/_compact/$ddocName');
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> ensureFullCommit(String dbName) async {
    DbResponse result;

    try {
      result = await client.post('$dbName/_ensure_full_commit');
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> viewCleanup(String dbName) async {
    DbResponse result;

    try {
      result = await client.post('$dbName/_view_cleanup');
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> securityOf(String dbName) async {
    DbResponse result;

    try {
      result = await client.get('$dbName/_security');
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> setSecurityFor(
      String dbName, Map<String, Map<String, List<String>>> security) async {
    DbResponse result;

    try {
      result = await client.put('$dbName/_security', body: security);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> purge(
      String dbName, Map<String, List<String>> docs) async {
    DbResponse result;

    try {
      result = await client.post('$dbName/_purge', body: docs);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> purgedInfosLimit(String dbName) async {
    DbResponse result;

    try {
      result = await client.get('$dbName/_purged_infos_limit');
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> setPurgedInfosLimit(String dbName, int limit) async {
    DbResponse result;

    try {
      result = await client.put('$dbName/_purged_infos_limit', body: limit);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> missingRevs(
      String dbName, Map<String, List<String>> revs) async {
    DbResponse result;

    try {
      result = await client.post('$dbName/_missing_revs', body: revs);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> revsDiff(
      String dbName, Map<String, List<String>> revs) async {
    DbResponse result;

    try {
      result = await client.post('$dbName/_revs_diff', body: revs);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> revsLimitOf(String dbName) async {
    DbResponse result;

    try {
      result = await client.get('$dbName/_revs_limit');
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  /// Sets the maximum number of document revisions that will be tracked by CouchDB,
  /// even after compaction has occurred
  @override
  Future<DbResponse> setRevsLimit(String dbName, int limit) async {
    DbResponse result;

    try {
      result = await client.put('$dbName/_revs_limit', body: limit);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }
}
