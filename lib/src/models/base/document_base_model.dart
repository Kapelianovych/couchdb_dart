import 'package:meta/meta.dart';

import '../../clients/base/couchdb_base_client.dart';
import '../../entities/db_response.dart';
import 'base_model.dart';

/// Class that define methods for create, read, update and delete documents within a database
abstract class DocumentBaseModel extends BaseModel {
  /// Create DocumentModel by accepting web-based or server-based client
  DocumentBaseModel(CouchDbBaseClient client) : super(client);

  /// Returns the HTTP Headers containing a minimal amount of information about the specified document
  Future<DbResponse> docInfo(String dbName, String docId,
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
      bool revsInfo = false});

  /// Returns document by the specified [docId] from the specified [dbName]
  Future<DbResponse> getDoc(String dbName, String docId,
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
      bool revsInfo = false});

  /// Creates a new named document, or creates a new revision of the existing document
  Future<DbResponse> insertDoc(
      String dbName, String docId, Map<String, Object> body,
      {Map<String, String> headers,
      String rev,
      String batch,
      bool newEdits = true});

  /// Marks the specified document as deleted by adding a field `_deleted` with the value `true`
  Future<DbResponse> deleteDoc(String dbName, String docId, String rev,
      {Map<String, String> headers, String batch});

  /// Copies an existing document to a new or existing document
  Future<DbResponse> copyDoc(String dbName, String docId,
      {Map<String, String> headers, String rev, String batch});

  /// Returns the HTTP headers containing a minimal amount of information about the specified attachment
  Future<DbResponse> attachmentInfo(String dbName, String docId, String attName,
      {Map<String, String> headers, String rev});

  /// Returns the file attachment associated with the document
  Future<DbResponse> getAttachment(String dbName, String docId, String attName,
      {Map<String, String> headers, String rev});

  /// Uploads the supplied content as an attachment to the specified document
  Future<DbResponse> insertAttachment(
      String dbName, String docId, String attName, Object body,
      {Map<String, String> headers, String rev});

  /// Deletes the attachment with filename [attName] of the specified [docId]
  Future<DbResponse> deleteAttachment(
      String dbName, String docId, String attName,
      {@required String rev, Map<String, String> headers, String batch});
}
