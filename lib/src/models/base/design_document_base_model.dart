import 'package:meta/meta.dart';

import '../../clients/base/couchdb_base_client.dart';
import 'base_model.dart';

abstract class DesignDocumentBaseModel extends BaseModel {

  DesignDocumentBaseModel(CouchDbBaseClient client): super(client);

  Future<String> designDocHeaders(String dbName, String ddoc);
  Future<String> getDesignDoc(String dbName, String ddoc);
  Future<String> insertDesignDoc(String dbName, String ddoc);
  Future<String> deleteDesignDoc(String dbName, String ddoc);
  Future<String> copyDesignDoc(String dbName, String ddoc);
  Future<String> getAttachmentInfo(String dbName, String ddoc, String attName);
  Future<String> getAttachment(String dbName, String ddoc, String attName);
  Future<String> uploadAttachment(String dbName, String ddoc, String attName);
  Future<String> deleteAttachment(String dbName, String ddoc, String attName);
  Future<String> designDocInfo(String dbName, String ddoc);
  Future<String> executeViewFunction(
    String dbName,
    String ddoc,
    String viewName,
    {
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
      List<Object> keys,
      int limit,
      bool reduce,
      int skip = 0,
      bool sorted = true,
      bool stable = false,
      String stale,
      Object startKey,
      String startKeyDocId,
      String update = 'true',
      bool updateSeq = false
    }
  );
  Future<String> executeViewFunctionWithKeys(
    String dbName,
    String ddoc,
    String viewName,
    {
      @required List<Object> keys,
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
      bool reduce,
      int skip = 0,
      bool sorted = true,
      bool stable = false,
      String stale,
      Object startKey,
      String startKeyDocId,
      String update = 'true',
      bool updateSeq = false
    }
  );
  // View queries will be soon.
  Future<String> executeShowFunctionForNull(
    String dbName,
    String ddoc,
    String funcName,
    String format
  );
  Future<String> executeShowFunctionForDocument(
    String dbName,
    String ddoc,
    String funcName,
    String docId,
    String format
  );
  Future<String> executeListFunctionForView(
    String dbName,
    String ddoc,
    String funcName,
    String view,
    String format
  );
  Future<String> executeListFunctionForViewFromDoc(
    String dbName,
    String ddoc,
    String funcName,
    String otherDoc,
    String view,
    String format
  );
  Future<String> executeUpdateFunctionForNull(
    String dbName,
    String ddoc,
    String funcName
  );
  Future<String> executeUpdateFunctionForDocument(
    String dbName,
    String ddoc,
    String funcName,
    String docId
  );
  Future<String> rewritePath(
    String dbName,
    String ddoc,
    String path,
  );
}