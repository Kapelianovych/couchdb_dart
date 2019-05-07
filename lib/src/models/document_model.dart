import 'package:meta/meta.dart';

import '../clients/couchdb_client.dart';
import '../entities/db_response.dart';
import '../entities/document_model_response.dart';
import '../exceptions/couchdb_exception.dart';
import '../utils/includer_path.dart';
import 'base/document_base_model.dart';

/// Class that implements methods for create, read, update and delete documents within a database
class DocumentModel extends DocumentBaseModel {
  /// Create DocumentModel by accepting web-based or server-based client
  DocumentModel(CouchDbClient client) : super(client);

  @override
  Future<DocumentModelResponse> docInfo(String dbName, String docId,
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
        '$dbName/$docId?attachments=$attachments&att_encoding_info=$attEncodingInfo&'
        '${includeNonNullParam('atts_since', attsSince)}&conflicts=$conflicts&deleted_conflicts=$deletedConflicts&'
        'latest=$latest&local_seq=$localSeq&meta=$meta&${includeNonNullParam('open_revs', openRevs)}&'
        '${includeNonNullParam('rev', rev)}&revs=$revs&revs_info=$revsInfo';

    try {
      result = await client.head(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.documentModelResponse();
  }

  @override
  Future<DocumentModelResponse> doc(String dbName, String docId,
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
        '$dbName/$docId?attachments=$attachments&att_encoding_info=$attEncodingInfo&'
        '${includeNonNullParam('atts_since', attsSince)}&conflicts=$conflicts&deleted_conflicts=$deletedConflicts&'
        'latest=$latest&local_seq=$localSeq&meta=$meta&${includeNonNullParam('open_revs', openRevs)}&'
        '${includeNonNullParam('rev', rev)}&revs=$revs&revs_info=$revsInfo';

    try {
      result = await client.get(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.documentModelResponse();
  }

  @override
  Future<DocumentModelResponse> insertDoc(
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
    return result.documentModelResponse();
  }

  @override
  Future<DocumentModelResponse> deleteDoc(
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
    return result.documentModelResponse();
  }

  @override
  Future<DocumentModelResponse> copyDoc(
    String dbName, 
    String docId, 
    String destinationId,
    {
      Map<String, String> headers, 
      String rev, 
      String destinationRev, 
      String batch
    }
  ) async {
    DbResponse result;

    final path = '$dbName/$docId?${includeNonNullParam('rev', rev)}&'
        '${includeNonNullParam('batch', batch)}';
    
    final destination = 
        '$destinationId?${includeNonNullParam("rev", destinationRev)}';

    headers ??= <String,String>{};
    headers['Destination'] = destination;
    
    try {
      result = await client.copy(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.documentModelResponse();
  }

  @override
  Future<DocumentModelResponse> attachmentInfo(
      String dbName, String docId, String attName,
      {Map<String, String> headers, String rev}) async {
    DbResponse result;

    final path = '$dbName/$docId/$attName?${includeNonNullParam('rev', rev)}';

    try {
      result = await client.head(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.documentModelResponse();
  }

  @override
  Future<DocumentModelResponse> attachment(
      String dbName, String docId, String attName,
      {Map<String, String> headers, String rev}) async {
    DbResponse result;

    final path = '$dbName/$docId/$attName?${includeNonNullParam('rev', rev)}';

    try {
      result = await client.get(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.documentModelResponse();
  }

  @override
  Future<DocumentModelResponse> uploadAttachment(
      String dbName, String docId, String attName, Object body,
      {Map<String, String> headers, String rev}) async {
    DbResponse result;

    final path = '$dbName/$docId/$attName?${includeNonNullParam('rev', rev)}';

    try {
      result = await client.put(path, reqHeaders: headers, body: body);
    } on CouchDbException {
      rethrow;
    }
    return result.documentModelResponse();
  }

  @override
  Future<DocumentModelResponse> deleteAttachment(
      String dbName, String docId, String attName,
      {@required String rev, Map<String, String> headers, String batch}) async {
    DbResponse result;

    final path = '$dbName/$docId/$attName?rev=$rev&'
        '${includeNonNullParam('batch', batch)}';

    try {
      result = await client.delete(path, reqHeaders: headers);
    } on CouchDbException {
      rethrow;
    }
    return result.documentModelResponse();
  }
}
