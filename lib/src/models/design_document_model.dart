import 'package:meta/meta.dart';

import '../clients/base/couchdb_base_client.dart';
import '../entities/db_response.dart';
import '../exceptions/couchdb_exception.dart';
import '../utils/includer_path.dart';
import 'base/design_document_base_model.dart';

/// Class that contains methods that allow operate with design documents
class DesignDocumentModel extends DesignDocumentBaseModel {
  /// Create DesignDocumentBaseModel by accepting web-based or server-based client
  DesignDocumentModel(CouchDbBaseClient client) : super(client);

  @override
  Future<DbResponse> designDocHeaders(String dbName, String ddocId,
      {Map<String, String> headers,
      bool attachments = false,
      bool attEncodingInfo = false,
      List<String> attsSince,
      bool conflicts = false,
      bool deletedConflicts = false,
      bool latest = false,
      bool localSeq = false,
      bool meta = false,
      Object openRevs,
      String rev,
      bool revs = false,
      bool revsInfo = false}) async {
    DbResponse result;

    final path =
        '$dbName/$ddocId?attachments=$attachments&att_encoding_info=$attEncodingInfo&'
        '${includeNonNullParam('atts_since', attsSince)}&conflicts=$conflicts&deleted_conflicts=$deletedConflicts&'
        'latest=$latest&local_seq=$localSeq&meta=$meta&${includeNonNullParam('open_revs', openRevs)}&'
        '${includeNonNullParam('rev', rev)}&revs=$revs&revs_info=$revsInfo';

    try {
      result = await client.head(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> designDoc(String dbName, String ddocId,
      {Map<String, String> headers,
      bool attachments = false,
      bool attEncodingInfo = false,
      List<String> attsSince,
      bool conflicts = false,
      bool deletedConflicts = false,
      bool latest = false,
      bool localSeq = false,
      bool meta = false,
      Object openRevs,
      String rev,
      bool revs = false,
      bool revsInfo = false}) async {
    DbResponse result;

    final path =
        '$dbName/$ddocId?attachments=$attachments&att_encoding_info=$attEncodingInfo&'
        '${includeNonNullParam('atts_since', attsSince)}&conflicts=$conflicts&deleted_conflicts=$deletedConflicts&'
        'latest=$latest&local_seq=$localSeq&meta=$meta&${includeNonNullParam('open_revs', openRevs)}&'
        '${includeNonNullParam('rev', rev)}&revs=$revs&revs_info=$revsInfo';

    try {
      result = await client.get(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> insertDesignDoc(
      String dbName, String ddocId, Map<String, Object> body,
      {Map<String, String> headers,
      String rev,
      String batch,
      bool newEdits = true}) async {
    DbResponse result;

    final path =
        '$dbName/$ddocId?new_edits=$newEdits&${includeNonNullParam('rev', rev)}&'
        '${includeNonNullParam('batch', batch)}';

    try {
      result = await client.put(path, reqHeaders: headers, body: body);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> deleteDesignDoc(String dbName, String ddocId, String rev,
      {Map<String, String> headers, String batch}) async {
    DbResponse result;

    final path =
        '$dbName/$ddocId?rev=$rev&${includeNonNullParam('batch', batch)}';

    try {
      result = await client.delete(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> copyDesignDoc(String dbName, String ddocId,
      {Map<String, String> headers, String rev, String batch}) async {
    DbResponse result;

    final path = '$dbName/$ddocId?${includeNonNullParam('rev', rev)}&'
        '${includeNonNullParam('batch', batch)}';

    try {
      result = await client.copy(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> attachmentInfo(
      String dbName, String ddocId, String attName,
      {Map<String, String> headers, String rev}) async {
    DbResponse result;

    final path = '$dbName/$ddocId/$attName?${includeNonNullParam('rev', rev)}';

    try {
      result = await client.head(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> attachment(String dbName, String ddocId, String attName,
      {Map<String, String> headers, String rev}) async {
    DbResponse result;

    final path = '$dbName/$ddocId/$attName?${includeNonNullParam('rev', rev)}';

    try {
      result = await client.get(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> uploadAttachment(
      String dbName, String ddocId, String attName, Object body,
      {Map<String, String> headers, String rev}) async {
    DbResponse result;

    final path = '$dbName/$ddocId/$attName?${includeNonNullParam('rev', rev)}';

    try {
      result = await client.put(path, reqHeaders: headers, body: body);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> deleteAttachment(
      String dbName, String ddocId, String attName,
      {@required String rev, Map<String, String> headers, String batch}) async {
    DbResponse result;

    final path = '$dbName/$ddocId/$attName?rev=$rev&'
        '${includeNonNullParam('batch', batch)}';

    try {
      result = await client.delete(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> designDocInfo(String dbName, String ddocId,
      {Map<String, String> headers}) async {
    DbResponse result;

    final path = '$dbName/$ddocId/_info';

    try {
      result = await client.get(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> executeViewFunction(
      String dbName, String ddocId, String viewName,
      {bool conflicts = false,
      bool descending = false,
      Object endKey,
      String endKeyDocId,
      bool group = false,
      int groupLevel,
      bool includeDocs = false,
      bool attachments = false,
      bool attEncodingInfo = false,
      bool inclusiveEnd = true,
      Object key,
      List<Object> keys,
      int limit,
      bool reduce = false, // for solving conflict with [conflicts]
      int skip = 0,
      bool sorted = true,
      bool stable = false,
      String stale,
      Object startKey,
      String startKeyDocId,
      String update = 'true',
      bool updateSeq = false,
      Map<String, String> headers}) async {
    DbResponse result;
    String path;

    if (reduce == true) {
      path = '$dbName/$ddocId/_view/$viewName?&descending=$descending&'
          '${includeNonNullParam('endkey', endKey)}&${includeNonNullParam('endkey_docid', endKeyDocId)}&'
          'group=$group&${includeNonNullParam('group_level', groupLevel)}&include_docs=$includeDocs&'
          'attachments=$attachments&att_encoding_info=$attEncodingInfo&inclusive_end=$inclusiveEnd&'
          '${includeNonNullParam('key', key)}&${includeNonNullParam('keys', keys)}&'
          '${includeNonNullParam('limit', limit)}&${includeNonNullParam('reduce', reduce)}&'
          'skip=$skip&sorted=$sorted&stable=$stable&${includeNonNullParam('stale', stale)}&'
          '${includeNonNullParam('startkey', startKey)}&${includeNonNullParam('startkey_docid', startKeyDocId)}&'
          'update=$update&update_seq=$updateSeq';
    } else {
      path =
          '$dbName/$ddocId/_view/$viewName?conflicts=$conflicts&descending=$descending&'
          '${includeNonNullParam('endkey', endKey)}&${includeNonNullParam('endkey_docid', endKeyDocId)}&'
          'group=$group&${includeNonNullParam('group_level', groupLevel)}&include_docs=$includeDocs&'
          'attachments=$attachments&att_encoding_info=$attEncodingInfo&inclusive_end=$inclusiveEnd&'
          '${includeNonNullParam('key', key)}&${includeNonNullParam('keys', keys)}&'
          '${includeNonNullParam('limit', limit)}&${includeNonNullParam('reduce', reduce)}&'
          'skip=$skip&sorted=$sorted&stable=$stable&${includeNonNullParam('stale', stale)}&'
          '${includeNonNullParam('startkey', startKey)}&${includeNonNullParam('startkey_docid', startKeyDocId)}&'
          'update=$update&update_seq=$updateSeq';
    }

    try {
      result = await client.get(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> executeViewFunctionWithKeys(
      String dbName, String ddocId, String viewName,
      {@required List<Object> keys,
      bool conflicts = false,
      bool descending = false,
      Object endKey,
      String endKeyDocId,
      bool group = false,
      int groupLevel,
      bool includeDocs = false,
      bool attachments = false,
      bool attEncodingInfo = false,
      bool inclusiveEnd = true,
      Object key,
      int limit,
      bool reduce = false, // Reason is the same as above
      int skip = 0,
      bool sorted = true,
      bool stable = false,
      String stale,
      Object startKey,
      String startKeyDocId,
      String update = 'true',
      bool updateSeq = false,
      Map<String, String> headers}) async {
    DbResponse result;
    String path;

    if (reduce == true) {
      path = '$dbName/$ddocId/_view/$viewName?&descending=$descending&'
          '${includeNonNullParam('endkey', endKey)}&${includeNonNullParam('endkey_docid', endKeyDocId)}&'
          'group=$group&${includeNonNullParam('group_level', groupLevel)}&include_docs=$includeDocs&'
          'attachments=$attachments&att_encoding_info=$attEncodingInfo&inclusive_end=$inclusiveEnd&'
          '${includeNonNullParam('key', key)}&'
          '${includeNonNullParam('limit', limit)}&${includeNonNullParam('reduce', reduce)}&'
          'skip=$skip&sorted=$sorted&stable=$stable&${includeNonNullParam('stale', stale)}&'
          '${includeNonNullParam('startkey', startKey)}&${includeNonNullParam('startkey_docid', startKeyDocId)}&'
          'update=$update&update_seq=$updateSeq';
    } else {
      path =
          '$dbName/$ddocId/_view/$viewName?conflicts=$conflicts&descending=$descending&'
          '${includeNonNullParam('endkey', endKey)}&${includeNonNullParam('endkey_docid', endKeyDocId)}&'
          'group=$group&${includeNonNullParam('group_level', groupLevel)}&include_docs=$includeDocs&'
          'attachments=$attachments&att_encoding_info=$attEncodingInfo&inclusive_end=$inclusiveEnd&'
          '${includeNonNullParam('key', key)}&'
          '${includeNonNullParam('limit', limit)}&${includeNonNullParam('reduce', reduce)}&'
          'skip=$skip&sorted=$sorted&stable=$stable&${includeNonNullParam('stale', stale)}&'
          '${includeNonNullParam('startkey', startKey)}&${includeNonNullParam('startkey_docid', startKeyDocId)}&'
          'update=$update&update_seq=$updateSeq';
    }

    final body = <String, List<Object>>{'keys': keys};

    try {
      result = await client.post(path, reqHeaders: headers, body: body);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> executeViewQueries(String dbName, String ddocId,
      String viewName, List<Object> queries) async {
    DbResponse result;

    final body = <String, List<Object>>{'queries': queries};

    try {
      result = await client.post('$dbName/$ddocId/_view/$viewName/queries',
          body: body);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> executeShowFunctionForNull(
      String dbName, String ddocId, String funcName,
      {String format}) async {
    DbResponse result;

    try {
      result = await client.get(
          '$dbName/$ddocId/_show/$funcName?${includeNonNullParam('format', format)}');
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> executeShowFunctionForDocument(
      String dbName, String ddocId, String funcName, String docId,
      {String format}) async {
    DbResponse result;

    try {
      result = await client.get(
          '$dbName/$ddocId/_show/$funcName/$docId?${includeNonNullParam('format', format)}');
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> executeListFunctionForView(
      String dbName, String ddocId, String funcName, String view,
      {String format}) async {
    DbResponse result;

    try {
      result = await client.get(
          '$dbName/$ddocId/_list/$funcName/$view?${includeNonNullParam('format', format)}');
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> executeListFunctionForViewFromDoc(String dbName,
      String ddocId, String funcName, String otherDoc, String view,
      {String format}) async {
    DbResponse result;

    try {
      result = await client.get(
          '$dbName/$ddocId/_list/$funcName/$otherDoc/$view?${includeNonNullParam('format', format)}');
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> executeUpdateFunctionForNull(
      String dbName, String ddocId, String funcName, Object body) async {
    DbResponse result;

    try {
      result =
          await client.post('$dbName/$ddocId/_update/$funcName', body: body);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> executeUpdateFunctionForDocument(String dbName,
      String ddocId, String funcName, String docId, Object body) async {
    DbResponse result;

    try {
      result = await client.put('$dbName/$ddocId/_update/$funcName/$docId',
          body: body);
    } on CouchDbException {
      rethrow;
    }
    return result;
  }

  @override
  Future<DbResponse> rewritePath(
    String dbName,
    String ddocId,
    String path,
  ) async {
    DbResponse result;

    try {
      result = await client.put('$dbName/$ddocId/_rewrite/$path');
    } on CouchDbException {
      rethrow;
    }
    return result;
  }
}
