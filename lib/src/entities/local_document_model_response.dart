import '../responses/api_response.dart';
import '../responses/local_documents_response.dart';

/// Only provided for backward compatibility
@Deprecated('Use LocalDocumentsResponse instead')
class LocalDocumentModelResponse extends LocalDocumentsResponse {
  LocalDocumentModelResponse.from(ApiResponse response) : super.from(response);

  LocalDocumentModelResponse(
      {int offset,
      List<Map<String, Object>> rows,
      int totalRows,
      String updateSeq,
      Map<String, Object> doc,
      bool ok,
      String id,
      String rev,
      Object attachment,
      List<String> conflicts,
      bool deleted,
      List<String> deletedConflicts,
      String localSeq,
      List<Map<String, Object>> revsInfo,
      Map<String, Object> revisions})
      : super(
            offset: offset,
            rows: rows,
            totalRows: totalRows,
            updateSeq: updateSeq,
            doc: doc,
            ok: ok,
            id: id,
            rev: rev,
            attachment: attachment,
            conflicts: conflicts,
            deleted: deleted,
            deletedConflicts: deletedConflicts,
            localSeq: localSeq,
            revsInfo: revsInfo,
            revisions: revisions);
}
