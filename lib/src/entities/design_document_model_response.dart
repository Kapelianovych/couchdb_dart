import '../responses/api_response.dart';
import '../responses/design_documents_response.dart';

/// Only provided for backward compatibility
@Deprecated('Use DesignDocumentsResponse instead')
class DesignDocumentModelResponse extends DesignDocumentsResponse {
  DesignDocumentModelResponse.from(ApiResponse response) : super.from(response);

  DesignDocumentModelResponse(
      {Map<String, Object> ddoc,
      bool ok,
      String id,
      String rev,
      Object attachment,
      List<String> conflicts,
      bool deleted,
      List<String> deletedConflicts,
      String localSeq,
      List<Map<String, Object>> revsInfo,
      Map<String, Object> revisions,
      String name,
      Map<String, Object> viewIndex,
      int offset,
      List<Map<String, Object>> rows,
      int totalRows,
      String updateSeq,
      List<Map<String, Object>> results,
      String status,
      String raw})
      : super(
            ddoc: ddoc,
            ok: ok,
            id: id,
            rev: rev,
            attachment: attachment,
            conflicts: conflicts,
            deleted: deleted,
            deletedConflicts: deletedConflicts,
            localSeq: localSeq,
            revsInfo: revsInfo,
            revisions: revisions,
            name: name,
            viewIndex: viewIndex,
            offset: offset,
            rows: rows,
            totalRows: totalRows,
            updateSeq: updateSeq,
            results: results,
            status: status,
            raw: raw);
}
