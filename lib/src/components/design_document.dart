import 'package:meta/meta.dart';

import '../clients/couchdb_client.dart';
import '../responses/response.dart';
import '../responses/design_document_response.dart';
import '../exceptions/couchdb_exception.dart';
import '../utils/includer_path.dart';
import 'component.dart';

/// Class that contains methods that allow operate with design documents
class DesignDocument extends Component {
  /// Create DesignDocumentBase by accepting web-based or server-based client
  DesignDocument(CouchDbClient client) : super(client);

  /// Returns the HTTP Headers containing a minimal amount of information about the specified design document
  Future<DesignDocumentResponse> designDocHeaders(String dbName, String ddocId,
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
    Response result;

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
    return result.designDocumentResponse();
  }

  /// Returns the contents of the design document specified with the name of the design document and
  /// from the specified database
  Future<DesignDocumentResponse> designDoc(String dbName, String ddocId,
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
    Response result;

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
    return result.designDocumentResponse();
  }

  /// Creates a new named design document, or creates a new revision of the existing design document
  ///
  /// The design documents have some agreement upon their fields and structure. Currently it is the following:
  ///
  ///     1. language (string): Defines Query Server key to process design document functions
  ///     2. options (object): View’s default options
  ///     3. filters (object): Filter functions definition
  ///     4. lists (object): List functions definition
  ///     5. rewrites (array or string): Rewrite rules definition
  ///     6. shows (object): Show functions definition
  ///     7. updates (object): Update functions definition
  ///     8. validate_doc_update (string): Validate document update function source
  ///     9. views (object): View functions definition.
  ///
  /// Note, that for `filters`, `lists`, `shows` and `updates` fields objects are mapping of function name to string function
  /// source code. For `views` mapping is the same except that values are objects with `map` and `reduce` (optional) keys
  /// which also contains functions source code.
  Future<DesignDocumentResponse> insertDesignDoc(
      String dbName, String ddocId, Map<String, Object> body,
      {Map<String, String> headers,
      String rev,
      String batch,
      bool newEdits = true}) async {
    Response result;

    final path =
        '$dbName/$ddocId?new_edits=$newEdits&${includeNonNullParam('rev', rev)}&'
        '${includeNonNullParam('batch', batch)}';

    try {
      result = await client.put(path, reqHeaders: headers, body: body);
    } on CouchDbException {
      rethrow;
    }
    return result.designDocumentResponse();
  }

  /// Deletes the specified document from the database
  Future<DesignDocumentResponse> deleteDesignDoc(
      String dbName, String ddocId, String rev,
      {Map<String, String> headers, String batch}) async {
    Response result;

    final path =
        '$dbName/$ddocId?rev=$rev&${includeNonNullParam('batch', batch)}';

    try {
      result = await client.delete(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.designDocumentResponse();
  }

  /// Copies an existing design document to a new or existing one
  Future<DesignDocumentResponse> copyDesignDoc(String dbName, String ddocId,
      {Map<String, String> headers, String rev, String batch}) async {
    Response result;

    final path = '$dbName/$ddocId?${includeNonNullParam('rev', rev)}&'
        '${includeNonNullParam('batch', batch)}';

    try {
      result = await client.copy(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.designDocumentResponse();
  }

  /// Returns the HTTP headers containing a minimal amount of information about the specified attachment
  Future<DesignDocumentResponse> attachmentInfo(
      String dbName, String ddocId, String attName,
      {Map<String, String> headers, String rev}) async {
    Response result;

    final path = '$dbName/$ddocId/$attName?${includeNonNullParam('rev', rev)}';

    try {
      result = await client.head(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.designDocumentResponse();
  }

  /// Returns the file attachment associated with the design document
  Future<DesignDocumentResponse> attachment(
      String dbName, String ddocId, String attName,
      {Map<String, String> headers, String rev}) async {
    Response result;

    final path = '$dbName/$ddocId/$attName?${includeNonNullParam('rev', rev)}';

    try {
      result = await client.get(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.designDocumentResponse();
  }

  /// Uploads the supplied content as an attachment to the specified design document
  ///
  /// You must supply the `Content-Type` header, and for an existing document
  /// you must also supply either the [rev] query argument or the `If-Match` HTTP header
  Future<DesignDocumentResponse> uploadAttachment(
      String dbName, String ddocId, String attName, Object body,
      {Map<String, String> headers, String rev}) async {
    Response result;

    final path = '$dbName/$ddocId/$attName?${includeNonNullParam('rev', rev)}';

    try {
      result = await client.put(path, reqHeaders: headers, body: body);
    } on CouchDbException {
      rethrow;
    }
    return result.designDocumentResponse();
  }

  /// Deletes the attachment of the specified design document
  Future<DesignDocumentResponse> deleteAttachment(
      String dbName, String ddocId, String attName,
      {@required String rev, Map<String, String> headers, String batch}) async {
    Response result;

    final path = '$dbName/$ddocId/$attName?rev=$rev&'
        '${includeNonNullParam('batch', batch)}';

    try {
      result = await client.delete(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.designDocumentResponse();
  }

  /// Obtains information about the specified design document, including the index, index size
  /// and current status of the design document and associated index information
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "name": "recipe",
  ///     "view_index": {
  ///         "compact_running": false,
  ///         "data_size": 926691,
  ///         "disk_size": 1982704,
  ///         "language": "python",
  ///         "purge_seq": 0,
  ///         "signature": "a59a1bb13fdf8a8a584bc477919c97ac",
  ///         "update_seq": 12397,
  ///         "updater_running": false,
  ///         "waiting_clients": 0,
  ///         "waiting_commit": false
  ///     }
  /// }
  /// ```
  Future<DesignDocumentResponse> designDocInfo(String dbName, String ddocId,
      {Map<String, String> headers}) async {
    Response result;

    final path = '$dbName/$ddocId/_info';

    try {
      result = await client.get(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.designDocumentResponse();
  }

  /// Executes the specified view function from the specified design document
  ///
  /// Supported values for [update]:
  ///
  ///     - true
  ///     - false
  ///     - lazy
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "offset": 0,
  ///     "rows": [
  ///         {
  ///             "id": "SpaghettiWithMeatballs",
  ///             "key": "meatballs",
  ///             "value": 1
  ///         },
  ///         {
  ///             "id": "SpaghettiWithMeatballs",
  ///             "key": "spaghetti",
  ///             "value": 1
  ///         },
  ///         {
  ///             "id": "SpaghettiWithMeatballs",
  ///             "key": "tomato sauce",
  ///             "value": 1
  ///         }
  ///     ],
  ///     "total_rows": 3
  /// }
  /// ```
  Future<DesignDocumentResponse> executeViewFunction(
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
    Response result;
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
    return result.designDocumentResponse();
  }

  /// Executes the specified view function from the specified design document.
  ///
  /// Unlike GET [executeViewFunction] for accessing views, the POST method
  /// supports the specification of explicit [keys] to be retrieved from the view results.
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "offset": 0,
  ///     "rows": [
  ///         {
  ///             "id": "SpaghettiWithMeatballs",
  ///             "key": "meatballs",
  ///             "value": 1
  ///         },
  ///         {
  ///             "id": "SpaghettiWithMeatballs",
  ///             "key": "spaghetti",
  ///             "value": 1
  ///         }
  ///     ],
  ///     "total_rows": 3
  /// }
  /// ```
  Future<DesignDocumentResponse> executeViewFunctionWithKeys(
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
    Response result;
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
    return result.designDocumentResponse();
  }

  /// Executes multiple specified view queries against the view function from the specified design document
  ///
  /// [queries] might have the same parameters as [executeViewFunctionWithKeys] or [executeViewFunction].
  /// Multi-key fetchs for `reduce` views must use `group=true`.
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "results" : [
  ///         {
  ///             "offset": 0,
  ///             "rows": [
  ///                 {
  ///                     "id": "SpaghettiWithMeatballs",
  ///                     "key": "meatballs",
  ///                     "value": 1
  ///                 },
  ///                 {
  ///                     "id": "SpaghettiWithMeatballs",
  ///                     "key": "spaghetti",
  ///                     "value": 1
  ///                 },
  ///                 {
  ///                     "id": "SpaghettiWithMeatballs",
  ///                     "key": "tomato sauce",
  ///                     "value": 1
  ///                 }
  ///             ],
  ///             "total_rows": 3
  ///         },
  ///         {
  ///             "offset" : 2,
  ///             "rows" : [
  ///                 {
  ///                     "id" : "Adukiandorangecasserole-microwave",
  ///                     "key" : "Aduki and orange casserole - microwave",
  ///                     "value" : [
  ///                         null,
  ///                         "Aduki and orange casserole - microwave"
  ///                     ]
  ///                 },
  ///                 {
  ///                     "id" : "Aioli-garlicmayonnaise",
  ///                     "key" : "Aioli - garlic mayonnaise",
  ///                     "value" : [
  ///                         null,
  ///                         "Aioli - garlic mayonnaise"
  ///                     ]
  ///                 },
  ///                 {
  ///                     "id" : "Alabamapeanutchicken",
  ///                     "key" : "Alabama peanut chicken",
  ///                     "value" : [
  ///                         null,
  ///                         "Alabama peanut chicken"
  ///                     ]
  ///                 }
  ///             ],
  ///             "total_rows" : 2667
  ///         }
  ///     ]
  /// }
  /// ```
  Future<DesignDocumentResponse> executeViewQueries(String dbName,
      String ddocId, String viewName, List<Object> queries) async {
    Response result;

    final body = <String, List<Object>>{'queries': queries};

    try {
      result = await client.post('$dbName/$ddocId/_view/$viewName/queries',
          body: body);
    } on CouchDbException {
      rethrow;
    }
    return result.designDocumentResponse();
  }

  /// Applies show function for null document
  ///
  /// Returns responce like:
  ///
  /// `some data that returned by show function`
  Future<DesignDocumentResponse> executeShowFunctionForNull(
      String dbName, String ddocId, String funcName,
      {String format}) async {
    Response result;

    try {
      result = await client.get(
          '$dbName/$ddocId/_show/$funcName?${includeNonNullParam('format', format)}');
    } on CouchDbException {
      rethrow;
    }
    return result.designDocumentResponse();
  }

  /// Applies show function for the specified document
  ///
  /// Returns responce like:
  ///
  /// `some data that returned by show function`
  Future<DesignDocumentResponse> executeShowFunctionForDocument(
      String dbName, String ddocId, String funcName, String docId,
      {String format}) async {
    Response result;

    try {
      result = await client.get(
          '$dbName/$ddocId/_show/$funcName/$docId?${includeNonNullParam('format', format)}');
    } on CouchDbException {
      rethrow;
    }
    return result.designDocumentResponse();
  }

  /// Applies list function for the [view] function from the same design document
  ///
  /// Returns responce like:
  ///
  /// `some data that returned by show function`
  Future<DesignDocumentResponse> executeListFunctionForView(
      String dbName, String ddocId, String funcName, String view,
      {String format}) async {
    Response result;

    try {
      result = await client.get(
          '$dbName/$ddocId/_list/$funcName/$view?${includeNonNullParam('format', format)}');
    } on CouchDbException {
      rethrow;
    }
    return result.designDocumentResponse();
  }

  /// Applies list function for the [view] function from the other design document
  ///
  /// Returns responce like:
  ///
  /// `some data that returned by show function`
  Future<DesignDocumentResponse> executeListFunctionForViewFromDoc(
      String dbName,
      String ddocId,
      String funcName,
      String otherDoc,
      String view,
      {String format}) async {
    Response result;

    try {
      result = await client.get(
          '$dbName/$ddocId/_list/$funcName/$otherDoc/$view?${includeNonNullParam('format', format)}');
    } on CouchDbException {
      rethrow;
    }
    return result.designDocumentResponse();
  }

  /// Executes update function on server side for null document
  ///
  /// Update function must return JSON like:
  /// ```json
  /// {"status": "ok"}
  /// ```
  /// for success exucution or error for fail.
  Future<DesignDocumentResponse> executeUpdateFunctionForNull(
      String dbName, String ddocId, String funcName, Object body) async {
    Response result;

    try {
      result =
          await client.post('$dbName/$ddocId/_update/$funcName', body: body);
    } on CouchDbException {
      rethrow;
    }
    return result.designDocumentResponse();
  }

  /// Executes update function on server side for the specified document
  Future<DesignDocumentResponse> executeUpdateFunctionForDocument(String dbName,
      String ddocId, String funcName, String docId, Object body) async {
    Response result;

    try {
      result = await client.put('$dbName/$ddocId/_update/$funcName/$docId',
          body: body);
    } on CouchDbException {
      rethrow;
    }
    return result.designDocumentResponse();
  }

  /// Rewrites the specified path by rules defined in the specified design document
  ///
  /// The rewrite rules are defined by the `rewrites` field of the design document.
  /// The `rewrites` field can either be a string containing the a rewrite function or an array of rule definitions.
  Future<DesignDocumentResponse> rewritePath(
    String dbName,
    String ddocId,
    String path,
  ) async {
    Response result;

    try {
      result = await client.put('$dbName/$ddocId/_rewrite/$path');
    } on CouchDbException {
      rethrow;
    }
    return result.designDocumentResponse();
  }
}
