import 'package:meta/meta.dart';

import '../clients/couchdb_client.dart';
import '../entities/db_response.dart';
import '../entities/local_document_model_response.dart';
import '../exceptions/couchdb_exception.dart';
import '../utils/includer_path.dart';
import 'base/local_document_base_model.dart';

/// The Local (non-replicating) document interface allows to create local documents
/// that are not replicated to other databases
class LocalDocumentModel extends LocalDocumentBaseModel {
  /// Create LocalDocumentModel by accepting web-based or server-based client
  LocalDocumentModel(CouchDbClient client) : super(client);

  @override
  Future<LocalDocumentModelResponse> localDocs(String dbName,
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
    DbResponse result;

    final path =
        '$dbName/_local_docs?conflicts=$conflicts&descending=$descending&'
        '${includeNonNullParam('endkey', endKey)}&${includeNonNullParam('endkey_docid', endKeyDocId)}&'
        'include_docs=$includeDocs&inclusive_end=$inclusiveEnd&${includeNonNullParam('key', key)}&'
        '${includeNonNullParam('keys', keys)}&${includeNonNullParam('limit', limit)}&'
        'skip=$skip&${includeNonNullParam('startkey', startKey)}&'
        '${includeNonNullParam('startkey_docid', startKeyDocId)}&update_seq=$updateSeq';

    try {
      result = await client.get(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.localDocumentModelResponse();
  }

  @override
  Future<LocalDocumentModelResponse> localDocsWithKeys(String dbName,
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
    DbResponse result;

    final path =
        '$dbName/_local_docs?conflicts=$conflicts&descending=$descending&'
        '${includeNonNullParam('endkey', endKey)}&${includeNonNullParam('endkey_docid', endKeyDocId)}&'
        'include_docs=$includeDocs&inclusive_end=$inclusiveEnd&${includeNonNullParam('key', key)}&'
        '${includeNonNullParam('limit', limit)}&'
        'skip=$skip&${includeNonNullParam('startkey', startKey)}&'
        '${includeNonNullParam('startkey_docid', startKeyDocId)}&update_seq=$updateSeq';
    final body = <String, List<String>>{'keys': keys};

    try {
      result = await client.post(path, body: body);
    } on CouchDbException {
      rethrow;
    }
    return result.localDocumentModelResponse();
  }

  @override
  Future<LocalDocumentModelResponse> localDoc(String dbName, String docId,
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
    DbResponse result;

    final path =
        '$dbName/$docId?conflicts=$conflicts&deleted_conflicts=$deletedConflicts&'
        'latest=$latest&local_seq=$localSeq&meta=$meta&${includeNonNullParam('open_revs', openRevs)}&'
        '${includeNonNullParam('rev', rev)}&revs=$revs&revs_info=$revsInfo';

    try {
      result = await client.get(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.localDocumentModelResponse();
  }

  @override
  Future<LocalDocumentModelResponse> putLocalDoc(
      String dbName, String docId, Map<String, Object> body,
      {Map<String, String> headers,
      String rev,
      String batch,
      bool newEdits = true}) async {
    DbResponse result;

    final path =
        '$dbName/$docId?new_edits=$newEdits&${includeNonNullParam('rev', rev)}&'
        '${includeNonNullParam('batch', batch)}';

    try {
      result = await client.put(path, reqHeaders: headers, body: body);
    } on CouchDbException {
      rethrow;
    }
    return result.localDocumentModelResponse();
  }

  @override
  Future<LocalDocumentModelResponse> deleteLocalDoc(
      String dbName, String docId, String rev,
      {Map<String, String> headers, String batch}) async {
    DbResponse result;

    final path =
        '$dbName/$docId?rev=$rev&${includeNonNullParam('batch', batch)}';

    try {
      result = await client.delete(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.localDocumentModelResponse();
  }

  @override
  Future<LocalDocumentModelResponse> copyLocalDoc(String dbName, String docId,
      {Map<String, String> headers, String rev, String batch}) async {
    DbResponse result;

    final path = '$dbName/$docId?${includeNonNullParam('rev', rev)}&'
        '${includeNonNullParam('batch', batch)}';

    try {
      result = await client.copy(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.localDocumentModelResponse();
  }
}
