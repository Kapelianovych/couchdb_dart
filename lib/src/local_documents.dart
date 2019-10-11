import 'package:meta/meta.dart';

import 'interfaces/client_interface.dart';
import 'interfaces/local_documents_interface.dart';
import 'responses/api_response.dart';
import 'responses/local_documents_response.dart';
import 'utils/includer_path.dart';

/// The Local (non-replicating) document interface allows to create local documents
/// that are not replicated to other databases
class LocalDocuments implements LocalDocumentsInterface {
  /// Instance of connected client
  final ClientInterface _client;

  /// Create LocalDocuments by accepting web-based or server-based client
  LocalDocuments(this._client);

  @override
  Future<LocalDocumentsResponse> localDocs(String dbName,
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
      bool updateSeq = false,
      Map<String, String> headers}) async {
    final path =
        '$dbName/_local_docs?conflicts=$conflicts&descending=$descending&'
        '${includeNonNullParam('endkey', endKey)}&${includeNonNullParam('endkey_docid', endKeyDocId)}&'
        'include_docs=$includeDocs&inclusive_end=$inclusiveEnd&${includeNonNullParam('key', key)}&'
        '${includeNonNullParam('keys', keys)}&${includeNonNullParam('limit', limit)}&'
        'skip=$skip&${includeNonNullParam('startkey', startKey)}&'
        '${includeNonNullParam('startkey_docid', startKeyDocId)}&update_seq=$updateSeq';

    ApiResponse result = await _client.get(path, reqHeaders: headers);
    return LocalDocumentsResponse.from(result);
  }

  @override
  Future<LocalDocumentsResponse> localDocsWithKeys(String dbName,
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
      bool updateSeq = false}) async {
    final path =
        '$dbName/_local_docs?conflicts=$conflicts&descending=$descending&'
        '${includeNonNullParam('endkey', endKey)}&${includeNonNullParam('endkey_docid', endKeyDocId)}&'
        'include_docs=$includeDocs&inclusive_end=$inclusiveEnd&${includeNonNullParam('key', key)}&'
        '${includeNonNullParam('limit', limit)}&'
        'skip=$skip&${includeNonNullParam('startkey', startKey)}&'
        '${includeNonNullParam('startkey_docid', startKeyDocId)}&update_seq=$updateSeq';
    final body = <String, List<String>>{'keys': keys};

    ApiResponse result = await _client.post(path, body: body);
    return LocalDocumentsResponse.from(result);
  }

  @override
  Future<LocalDocumentsResponse> localDoc(String dbName, String docId,
      {Map<String, String> headers,
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
        '$dbName/$docId?conflicts=$conflicts&deleted_conflicts=$deletedConflicts&'
        'latest=$latest&local_seq=$localSeq&meta=$meta&${includeNonNullParam('open_revs', openRevs)}&'
        '${includeNonNullParam('rev', rev)}&revs=$revs&revs_info=$revsInfo';

    ApiResponse result = await _client.get(path, reqHeaders: headers);
    return LocalDocumentsResponse.from(result);
  }

  @override
  Future<LocalDocumentsResponse> copyLocalDoc(String dbName, String docId,
      {Map<String, String> headers, String rev, String batch}) async {
    final path = '$dbName/$docId?${includeNonNullParam('rev', rev)}&'
        '${includeNonNullParam('batch', batch)}';

    ApiResponse result = await _client.copy(path, reqHeaders: headers);
    return LocalDocumentsResponse.from(result);
  }

  @override
  Future<LocalDocumentsResponse> deleteLocalDoc(
      String dbName, String docId, String rev,
      {Map<String, String> headers, String batch}) async {
    final path =
        '$dbName/$docId?rev=$rev&${includeNonNullParam('batch', batch)}';

    ApiResponse result = await _client.delete(path, reqHeaders: headers);
    return LocalDocumentsResponse.from(result);
  }

  @override
  Future<LocalDocumentsResponse> putLocalDoc(
      String dbName, String docId, Map<String, Object> body,
      {Map<String, String> headers,
        String rev,
        String batch,
        bool newEdits = true}) async {
    final path =
        '$dbName/$docId?new_edits=$newEdits&${includeNonNullParam('rev', rev)}&'
        '${includeNonNullParam('batch', batch)}';

    ApiResponse result =
    await _client.put(path, reqHeaders: headers, body: body);
    return LocalDocumentsResponse.from(result);
  }
}
