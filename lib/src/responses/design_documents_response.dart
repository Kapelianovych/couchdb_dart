import 'package:couchdb/couchdb.dart';

import '../design_documents.dart';

/// Class that contains responses from `DesignDocumentModel` class
class DesignDocumentsResponse {
  /// Creates instance of [DesignDocumentsResponse]
  DesignDocumentsResponse(
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

  DesignDocumentsResponse.from(ApiResponse response) : this(
      ddoc: response.json,
      ok: response.json['ok'] as bool,
      id: (response.json['_id'] ?? response.json['id']) as String,
      rev: (response.json['_rev'] ?? response.json['rev']) as String,
      attachment: response.json['_attachments'] ?? response.raw,
      conflicts: (response.json['_conflicts'] as List<Object>)
          ?.map((e) => e as String)
          ?.toList(),
      deleted: response.json['_deleted'] as bool,
      deletedConflicts: (response.json['_deleted_conflicts'] as List<Object>)
          ?.map((e) => e as String)
          ?.toList(),
      localSeq: response.json['_local_seq'] as String,
      revsInfo: (response.json['_revs_info'] as List<Object>)
          ?.map((e) => e as Map<String, Object>)
          ?.toList(),
      revisions: response.json['_revisions'] as Map<String, Object>,
      name: response.json['name'] as String,
      viewIndex: response.json['view_index'] as Map<String, Object>,
      offset: response.json['offset'] as int,
      rows: (response.json['rows'] as List<Object>)
          ?.map((e) => e as Map<String, Object>)
          ?.toList(),
      totalRows: response.json['total_rows'] as int,
      updateSeq: response.json['update_seq'] as String,
      results: (response.json['results'] as List<Object>)
          ?.map((e) => e as Map<String, Object>)
          ?.toList(),
      status: response.json['status'] as String,
      raw: response.raw);

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
  /// This properties are listed separately in [DesignDocumentsResponse] and you can get them directly.
  ///
  /// Returns by [DesignDocuments.designDoc]
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
  /// Can be returned by [DesignDocuments.executeUpdateFunctionForNull]
  /// and [DesignDocuments.executeUpdateFunctionForDocument]
  final String status;

  /// Contains non-JSON body
  ///
  /// Can be returned by [DesignDocuments.executeShowFunctionForNull]
  final String raw;
}
