import 'package:meta/meta.dart';

import '../clients/couchdb_client.dart';
import '../responses/response.dart';
import '../responses/local_document_response.dart';
import '../exceptions/couchdb_exception.dart';
import '../utils/includer_path.dart';
import 'component.dart';

/// The Local (non-replicating) document interface allows to create local documents
/// that are not replicated to other databases
class LocalDocument extends Component {
  /// Create LocalDocument by accepting web-based or server-based client
  LocalDocument(CouchDbClient client) : super(client);

  /// Returns a JSON structure of all of the local documents in a given database
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "offset": null,
  ///     "rows": [
  ///         {
  ///             "id": "_local/localdoc01",
  ///             "key": "_local/localdoc01",
  ///             "value": {
  ///                 "rev": "0-1"
  ///             }
  ///         },
  ///         {
  ///             "id": "_local/localdoc02",
  ///             "key": "_local/localdoc02",
  ///             "value": {
  ///                 "rev": "0-1"
  ///             }
  ///         },
  ///         {
  ///             "id": "_local/localdoc03",
  ///             "key": "_local/localdoc03",
  ///             "value": {
  ///                 "rev": "0-1"
  ///             }
  ///         },
  ///         {
  ///             "id": "_local/localdoc04",
  ///             "key": "_local/localdoc04",
  ///             "value": {
  ///                 "rev": "0-1"
  ///             }
  ///         },
  ///         {
  ///             "id": "_local/localdoc05",
  ///             "key": "_local/localdoc05",
  ///             "value": {
  ///                 "rev": "0-1"
  ///             }
  ///         }
  ///     ],
  ///     "total_rows": null
  /// }
  /// ```
  Future<LocalDocumentResponse> localDocs(String dbName,
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
    Response result;

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
    return result.localDocumentResponse();
  }

  /// Requests multiple local documents in a single request specifying multiple [keys]
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "total_rows" : null,
  ///     "rows" : [
  ///         {
  ///             "value" : {
  ///                 "rev" : "0-1"
  ///             },
  ///             "id" : "_local/localdoc02",
  ///             "key" : "_local/localdoc02"
  ///         },
  ///         {
  ///             "value" : {
  ///                 "rev" : "0-1"
  ///             },
  ///             "id" : "_local/localdoc05",
  ///             "key" : "_local/localdoc05"
  ///         }
  ///     ],
  ///     "offset" : null
  /// }
  /// ```
  Future<LocalDocumentResponse> localDocsWithKeys(String dbName,
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
    Response result;

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
    return result.localDocumentResponse();
  }

  /// Gets the specified local document.
  Future<LocalDocumentResponse> localDoc(String dbName, String docId,
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
    Response result;

    final path =
        '$dbName/_local/$docId?conflicts=$conflicts&deleted_conflicts=$deletedConflicts&'
        'latest=$latest&local_seq=$localSeq&meta=$meta&${includeNonNullParam('open_revs', openRevs)}&'
        '${includeNonNullParam('rev', rev)}&revs=$revs&revs_info=$revsInfo';

    try {
      result = await client.get(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.localDocumentResponse();
  }

  /// Stores the specified local document.
  Future<LocalDocumentResponse> putLocalDoc(
      String dbName, String docId, Map<String, Object> body,
      {Map<String, String> headers,
      String rev,
      String batch,
      bool newEdits = true}) async {
    Response result;

    final path =
        '$dbName/_local/$docId?new_edits=$newEdits&${includeNonNullParam('rev', rev)}&'
        '${includeNonNullParam('batch', batch)}';

    try {
      result = await client.put(path, reqHeaders: headers, body: body);
    } on CouchDbException {
      rethrow;
    }
    return result.localDocumentResponse();
  }

  /// Deletes the specified local document.
  Future<LocalDocumentResponse> deleteLocalDoc(
      String dbName, String docId, String rev,
      {Map<String, String> headers, String batch}) async {
    Response result;

    final path =
        '$dbName/_local/$docId?rev=$rev&${includeNonNullParam('batch', batch)}';

    try {
      result = await client.delete(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.localDocumentResponse();
  }

  /// Copies the specified local document.
  Future<LocalDocumentResponse> copyLocalDoc(String dbName, String docId,
      {Map<String, String> headers, String rev, String batch}) async {
    Response result;

    final path = '$dbName/_local/$docId?${includeNonNullParam('rev', rev)}&'
        '${includeNonNullParam('batch', batch)}';

    try {
      result = await client.copy(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.localDocumentResponse();
  }
}
