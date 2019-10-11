import '../responses/api_response.dart';
import '../responses/documents_response.dart';

/// Only provided for backward compatibility
@Deprecated('Use DocumentsResponse instead')
class DocumentModelResponse extends DocumentsResponse {
  DocumentModelResponse.from(ApiResponse response) : super.from(response);

  DocumentModelResponse(
      {Map<String, Object> doc,
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
