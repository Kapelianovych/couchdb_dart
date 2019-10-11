import '../components/design_document.dart';

/// Class that contains responses from `DesignDocument` class
class DesignDocumentResponse {
  /// Creates instance of [DesignDocumentResponse]
  DesignDocumentResponse(
      {this.ddoc,
      this.ok,
      this.id,
      this.rev,
      this.attachment,
      this.conflicts,
      this.deleted,
      this.deletedConflicts,
      this.localSeq,
      this.revsInfo,
      this.revisions,
      this.name,
      this.viewIndex,
      this.offset,
      this.rows,
      this.totalRows,
      this.updateSeq,
      this.results,
      this.status,
      this.raw});

  /// Holds document object
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
  /// This properties are listed separately in [DesignDocumentResponse] and you can get their directly.
  ///
  /// Returns by [DesignDocument.designDoc]
  final Map<String, Object> ddoc;

  /// Holds operation status. Available in case of success
  final bool ok;

  /// Holds document ID
  final String id;

  /// Holds revision info of document
  final String rev;

  /// Attachment's raw data
  final Object attachment;

  /// List of conflicted revisions
  final List<String> conflicts;

  /// Deletion flag. Available if document was removed
  final bool deleted;

  /// List of deleted conflicted revisions
  final List<String> deletedConflicts;

  /// Document’s update sequence in current database
  final String localSeq;

  /// List of objects with information about local revisions and their status
  final List<Map<String, Object>> revsInfo;

  /// List of local revision tokens without
  final Map<String, Object> revisions;

  /// Holds design document name
  final String name;

  /// View index information
  final Map<String, Object> viewIndex;

  /// Holds offset where the document list started
  final int offset;

  /// List array of view row objects
  final List<Map<String, Object>> rows;

  /// Holds number of documents in the database/view
  final int totalRows;

  /// Current update sequence for the database
  final String updateSeq;

  /// Holds an array of result objects - one for each query
  final List<Map<String, Object>> results;

  /// Holds execution status
  ///
  /// Can be returned by [DesignDocument.executeUpdateFunctionForNull]
  /// and [DesignDocument.executeUpdateFunctionForDocument]
  final String status;

  /// Contains non-JSON body
  ///
  /// Can be returned by [DesignDocument.executeShowFunctionForNull]
  final String raw;
}
