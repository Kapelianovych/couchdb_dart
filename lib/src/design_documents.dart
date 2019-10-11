import 'package:meta/meta.dart';

import 'interfaces/client_interface.dart';
import 'interfaces/design_documents_interface.dart';
import 'responses/api_response.dart';
import 'responses/design_documents_response.dart';
import 'utils/includer_path.dart';

/// Class that contains methods that allow operate with design documents
class DesignDocuments implements DesignDocumentsInterface {
  /// Instance of connected client
  final ClientInterface _client;

  /// Create DesignDocument by accepting web-based or server-based client
  DesignDocuments(this._client);

  @override
  Future<DesignDocumentsResponse> designDocHeaders(String dbName, String ddocId,
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
    final path =
        '$dbName/$ddocId?attachments=$attachments&att_encoding_info=$attEncodingInfo&'
        '${includeNonNullParam('atts_since', attsSince)}&conflicts=$conflicts&deleted_conflicts=$deletedConflicts&'
        'latest=$latest&local_seq=$localSeq&meta=$meta&${includeNonNullParam('open_revs', openRevs)}&'
        '${includeNonNullParam('rev', rev)}&revs=$revs&revs_info=$revsInfo';

    ApiResponse result = await _client.head(path, reqHeaders: headers);
    return DesignDocumentsResponse.from(result);
  }

  @override
  Future<DesignDocumentsResponse> designDoc(String dbName, String ddocId,
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
    final path =
        '$dbName/$ddocId?attachments=$attachments&att_encoding_info=$attEncodingInfo&'
        '${includeNonNullParam('atts_since', attsSince)}&conflicts=$conflicts&deleted_conflicts=$deletedConflicts&'
        'latest=$latest&local_seq=$localSeq&meta=$meta&${includeNonNullParam('open_revs', openRevs)}&'
        '${includeNonNullParam('rev', rev)}&revs=$revs&revs_info=$revsInfo';

    ApiResponse result = await _client.get(path, reqHeaders: headers);
    return DesignDocumentsResponse.from(result);
  }

  @override
  Future<DesignDocumentsResponse> insertDesignDoc(
      String dbName, String ddocId, Map<String, Object> body,
      {Map<String, String> headers,
      String rev,
      String batch,
      bool newEdits = true}) async {
    final path =
        '$dbName/$ddocId?new_edits=$newEdits&${includeNonNullParam('rev', rev)}&'
        '${includeNonNullParam('batch', batch)}';

    ApiResponse result =
        await _client.put(path, reqHeaders: headers, body: body);
    return DesignDocumentsResponse.from(result);
  }

  @override
  Future<DesignDocumentsResponse> deleteDesignDoc(
      String dbName, String ddocId, String rev,
      {Map<String, String> headers, String batch}) async {
    final path =
        '$dbName/$ddocId?rev=$rev&${includeNonNullParam('batch', batch)}';

    ApiResponse result = await _client.delete(path, reqHeaders: headers);
    return DesignDocumentsResponse.from(result);
  }

  @override
  Future<DesignDocumentsResponse> copyDesignDoc(String dbName, String ddocId,
      {Map<String, String> headers, String rev, String batch}) async {
    final path = '$dbName/$ddocId?${includeNonNullParam('rev', rev)}&'
        '${includeNonNullParam('batch', batch)}';

    ApiResponse result = await _client.copy(path, reqHeaders: headers);
    return DesignDocumentsResponse.from(result);
  }

  @override
  Future<DesignDocumentsResponse> attachmentInfo(
      String dbName, String ddocId, String attName,
      {Map<String, String> headers, String rev}) async {
    final path = '$dbName/$ddocId/$attName?${includeNonNullParam('rev', rev)}';

    ApiResponse result = await _client.head(path, reqHeaders: headers);
    return DesignDocumentsResponse.from(result);
  }

  @override
  Future<DesignDocumentsResponse> attachment(
      String dbName, String ddocId, String attName,
      {Map<String, String> headers, String rev}) async {
    final path = '$dbName/$ddocId/$attName?${includeNonNullParam('rev', rev)}';

    ApiResponse result = await _client.get(path, reqHeaders: headers);
    return DesignDocumentsResponse.from(result);
  }

  @override
  Future<DesignDocumentsResponse> uploadAttachment(
      String dbName, String ddocId, String attName, Object body,
      {Map<String, String> headers, String rev}) async {
    final path = '$dbName/$ddocId/$attName?${includeNonNullParam('rev', rev)}';

    ApiResponse result =
        await _client.put(path, reqHeaders: headers, body: body);
    return DesignDocumentsResponse.from(result);
  }

  @override
  Future<DesignDocumentsResponse> deleteAttachment(
      String dbName, String ddocId, String attName,
      {@required String rev, Map<String, String> headers, String batch}) async {
    final path = '$dbName/$ddocId/$attName?rev=$rev&'
        '${includeNonNullParam('batch', batch)}';

    ApiResponse result = await _client.delete(path, reqHeaders: headers);
    return DesignDocumentsResponse.from(result);
  }

  @override
  Future<DesignDocumentsResponse> designDocInfo(String dbName, String ddocId,
      {Map<String, String> headers}) async {
    final path = '$dbName/$ddocId/_info';

    ApiResponse result = await _client.get(path, reqHeaders: headers);
    return DesignDocumentsResponse.from(result);
  }

  @override
  Future<DesignDocumentsResponse> executeViewFunction(
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

    ApiResponse result = await _client.get(path, reqHeaders: headers);
    return DesignDocumentsResponse.from(result);
  }

  @override
  Future<DesignDocumentsResponse> executeViewFunctionWithKeys(
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

    ApiResponse result =
        await _client.post(path, reqHeaders: headers, body: body);
    return DesignDocumentsResponse.from(result);
  }

  @override
  Future<DesignDocumentsResponse> executeViewQueries(String dbName,
      String ddocId, String viewName, List<Object> queries) async {
    final body = <String, List<Object>>{'queries': queries};

    ApiResponse result = await _client
        .post('$dbName/$ddocId/_view/$viewName/queries', body: body);
    return DesignDocumentsResponse.from(result);
  }

  @override
  Future<DesignDocumentsResponse> executeShowFunctionForNull(
      String dbName, String ddocId, String funcName,
      {String format}) async {
    ApiResponse result = await _client.get(
        '$dbName/$ddocId/_show/$funcName?${includeNonNullParam('format', format)}');
    return DesignDocumentsResponse.from(result);
  }

  @override
  Future<DesignDocumentsResponse> executeShowFunctionForDocument(
      String dbName, String ddocId, String funcName, String docId,
      {String format}) async {
    ApiResponse result = await _client.get(
        '$dbName/$ddocId/_show/$funcName/$docId?${includeNonNullParam('format', format)}');
    return DesignDocumentsResponse.from(result);
  }

  @override
  Future<DesignDocumentsResponse> executeListFunctionForView(
      String dbName, String ddocId, String funcName, String view,
      {String format}) async {
    ApiResponse result = await _client.get(
        '$dbName/$ddocId/_list/$funcName/$view?${includeNonNullParam('format', format)}');
    return DesignDocumentsResponse.from(result);
  }

  @override
  Future<DesignDocumentsResponse> executeListFunctionForViewFromDoc(
      String dbName,
      String ddocId,
      String funcName,
      String otherDoc,
      String view,
      {String format}) async {
    ApiResponse result = await _client.get(
        '$dbName/$ddocId/_list/$funcName/$otherDoc/$view?${includeNonNullParam('format', format)}');
    return DesignDocumentsResponse.from(result);
  }

  @override
  Future<DesignDocumentsResponse> executeUpdateFunctionForNull(
      String dbName, String ddocId, String funcName, Object body) async {
    ApiResponse result =
        await _client.post('$dbName/$ddocId/_update/$funcName', body: body);
    return DesignDocumentsResponse.from(result);
  }

  @override
  Future<DesignDocumentsResponse> executeUpdateFunctionForDocument(
      String dbName,
      String ddocId,
      String funcName,
      String docId,
      Object body) async {
    ApiResponse result = await _client
        .put('$dbName/$ddocId/_update/$funcName/$docId', body: body);
    return DesignDocumentsResponse.from(result);
  }

  @override
  Future<DesignDocumentsResponse> rewritePath(
    String dbName,
    String ddocId,
    String path,
  ) async {
    ApiResponse result = await _client.put('$dbName/$ddocId/_rewrite/$path');
    return DesignDocumentsResponse.from(result);
  }
}
