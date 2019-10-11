import 'package:meta/meta.dart';

import '../clients/couchdb_client.dart';
import '../responses/response.dart';
import '../responses/document_response.dart';
import '../exceptions/couchdb_exception.dart';
import '../utils/includer_path.dart';
import 'component.dart';

/// Class that implements methods for create, read, update and delete documents within a database
class Document extends Component {
  /// Create Document by accepting web-based or server-based client
  Document(CouchDbClient client) : super(client);

  /// Returns the HTTP Headers containing a minimal amount of information about the specified document
  Future<DocumentResponse> docInfo(String dbName, String docId,
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
        '$dbName/$docId?attachments=$attachments&att_encoding_info=$attEncodingInfo&'
        '${includeNonNullParam('atts_since', attsSince)}&conflicts=$conflicts&deleted_conflicts=$deletedConflicts&'
        'latest=$latest&local_seq=$localSeq&meta=$meta&${includeNonNullParam('open_revs', openRevs)}&'
        '${includeNonNullParam('rev', rev)}&revs=$revs&revs_info=$revsInfo';

    try {
      result = await client.head(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.documentResponse();
  }

  /// Returns document by the specified [docId] from the specified [dbName]
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "_id": "SpaghettiWithMeatballs",
  ///     "_rev": "1-917fa2381192822767f010b95b45325b",
  ///     "description": "An Italian-American dish that usually consists of spaghetti, tomato sauce and meatballs.",
  ///     "ingredients": [
  ///         "spaghetti",
  ///         "tomato sauce",
  ///         "meatballs"
  ///     ],
  ///     "name": "Spaghetti with meatballs"
  /// }
  /// ```
  Future<DocumentResponse> doc(String dbName, String docId,
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
        '$dbName/$docId?attachments=$attachments&att_encoding_info=$attEncodingInfo&'
        '${includeNonNullParam('atts_since', attsSince)}&conflicts=$conflicts&deleted_conflicts=$deletedConflicts&'
        'latest=$latest&local_seq=$localSeq&meta=$meta&${includeNonNullParam('open_revs', openRevs)}&'
        '${includeNonNullParam('rev', rev)}&revs=$revs&revs_info=$revsInfo';

    try {
      result = await client.get(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.documentResponse();
  }

  /// Creates a new named document, or creates a new revision of the existing document
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "id": "SpaghettiWithMeatballs",
  ///     "ok": true,
  ///     "rev": "1-917fa2381192822767f010b95b45325b"
  /// }
  /// ```
  Future<DocumentResponse> insertDoc(
      String dbName, String docId, Map<String, Object> body,
      {Map<String, String> headers,
      String rev,
      String batch,
      bool newEdits = true}) async {
    Response result;

    final path =
        '$dbName/$docId?new_edits=$newEdits&${includeNonNullParam('rev', rev)}&'
        '${includeNonNullParam('batch', batch)}';

    try {
      result = await client.put(path, reqHeaders: headers, body: body);
    } on CouchDbException {
      rethrow;
    }
    return result.documentResponse();
  }

  /// Marks the specified document as deleted by adding a field `_deleted` with the value `true`
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "id": "SpaghettiWithMeatballs",
  ///     "ok": true,
  ///     "rev": "1-917fa2381192822767f010b95b45325b"
  /// }
  /// ```
  Future<DocumentResponse> deleteDoc(String dbName, String docId, String rev,
      {Map<String, String> headers, String batch}) async {
    Response result;

    final path =
        '$dbName/$docId?rev=$rev&${includeNonNullParam('batch', batch)}';

    try {
      result = await client.delete(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.documentResponse();
  }

  /// Copies an existing document to a new or existing document.
  ///
  /// If you are copying to an existing document, you must specify
  /// `destinationRev` as the current rev of the destination doc
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "id": "SpaghettiWithMeatballs",
  ///     "ok": true,
  ///     "rev": "1-917fa2381192822767f010b95b45325b"
  /// }
  /// ```
  Future<DocumentResponse> copyDoc(
      String dbName, String docId, String destinationId,
      {Map<String, String> headers,
      String rev,
      String destinationRev,
      String batch}) async {
    Response result;

    final path = '$dbName/$docId?${includeNonNullParam('rev', rev)}&'
        '${includeNonNullParam('batch', batch)}';

    final destination = destinationRev == null
        ? destinationId
        : '$destinationId?rev=$destinationRev';

    headers ??= <String, String>{};
    headers['Destination'] = destination;

    try {
      result = await client.copy(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.documentResponse();
  }

  /// Returns the HTTP headers containing a minimal amount of information about the specified attachment
  Future<DocumentResponse> attachmentInfo(
      String dbName, String docId, String attName,
      {Map<String, String> headers, String rev}) async {
    Response result;

    final path = '$dbName/$docId/$attName?${includeNonNullParam('rev', rev)}';

    try {
      result = await client.head(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.documentResponse();
  }

  /// Returns the file attachment associated with the document
  ///
  /// Result is available in [DocumentModelResponse.attachment] or [DbResponse.raw] field as bytes of data.
  Future<DocumentResponse> attachment(
      String dbName, String docId, String attName,
      {Map<String, String> headers, String rev}) async {
    Response result;

    final path = '$dbName/$docId/$attName?${includeNonNullParam('rev', rev)}';

    try {
      result = await client.get(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.documentResponse();
  }

  /// Uploads the supplied content as an attachment to the specified document
  ///
  /// You must supply the `Content-Type` header, and for an existing document
  /// you must also supply either the [rev] query argument or the `If-Match` HTTP header.
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "id": "SpaghettiWithMeatballs",
  ///     "ok": true,
  ///     "rev": "1-917fa2381192822767f010b95b45325b"
  /// }
  /// ```
  Future<DocumentResponse> uploadAttachment(
      String dbName, String docId, String attName, Object body,
      {Map<String, String> headers, String rev}) async {
    Response result;

    final path = '$dbName/$docId/$attName?${includeNonNullParam('rev', rev)}';

    try {
      result = await client.put(path, reqHeaders: headers, body: body);
    } on CouchDbException {
      rethrow;
    }
    return result.documentResponse();
  }

  /// Deletes the attachment with filename [attName] of the specified [docId]
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "id": "SpaghettiWithMeatballs",
  ///     "ok": true,
  ///     "rev": "1-917fa2381192822767f010b95b45325b"
  /// }
  /// ```
  Future<DocumentResponse> deleteAttachment(
      String dbName, String docId, String attName,
      {@required String rev, Map<String, String> headers, String batch}) async {
    Response result;

    final path = '$dbName/$docId/$attName?rev=$rev&'
        '${includeNonNullParam('batch', batch)}';

    try {
      result = await client.delete(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.documentResponse();
  }
}
