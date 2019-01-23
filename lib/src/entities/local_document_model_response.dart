import '../models/local_document_model.dart';

/// Class that contains responses from `LocalDocumentModel` class
class LocalDocumentModelResponse {
  /// Creates instance of [LocalDocumentModelResponse]
  LocalDocumentModelResponse(
      {this.offset,
      this.rows,
      this.totalRows,
      this.updateSeq,
      this.doc,
      this.ok,
      this.id,
      this.rev,
      this.attachment,
      this.conflicts,
      this.deleted,
      this.deletedConflicts,
      this.localSeq,
      this.revsInfo,
      this.revisions});

  /// Holds offset where the document list started
  int offset;

  /// List array of view row objects
  List<Map<String, Object>> rows;

  /// Holds number of documents in the database
  int totalRows;

  /// Current update sequence for the database
  String updateSeq;

  /// Holds local document object
  ///
  /// May contain:
  /// - `_id` (string) – Document ID
  /// - `_rev` (string) – Revision MVCC token
  /// - `_deleted` (boolean) – Deletion flag. Available if document was removed
  /// - `_attachments` (object) – Attachment’s stubs. Available if document has any attachments
  /// - `_conflicts` (array) – List of conflicted revisions. Available if requested with `conflicts=true` query parameter
  /// - `_deleted_conflicts` (array) – List of deleted conflicted revisions. Available if requested with `deleted_conflicts=true` query parameter
  /// - `_local_seq (string)` – Document’s update sequence in current database. Available if requested with `local_seq=true` query parameter
  /// - `_revs_info (array)` – List of objects with information about local revisions and their status. Available if requested with `open_revs` query parameter
  /// - `_revisions (object)` – List of local revision tokens without. Available if requested with `revs=true` query parameter
  ///
  /// This properties are listed separately in [LocalDocumentModelResponse] and you can get their directly.
  ///
  /// Returns by [LocalDocumentModel.localDoc]
  Map<String, Object> doc;

  /// Holds operation status. Available in case of success
  bool ok;

  /// Holds document ID
  String id;

  /// Holds revision info of document
  String rev;

  /// Attachment's raw data
  Object attachment;

  /// List of conflicted revisions
  List<String> conflicts;

  /// Deletion flag. Available if document was removed
  bool deleted;

  /// List of deleted conflicted revisions
  List<String> deletedConflicts;

  /// Document’s update sequence in current database
  String localSeq;

  /// List of objects with information about local revisions and their status
  List<Map<String, Object>> revsInfo;

  /// List of local revision tokens without
  Map<String, Object> revisions;
}
