import 'package:meta/meta.dart';

import '../../clients/base/couchdb_base_client.dart';
import 'base_model.dart';

abstract class DocumentBaseModel extends BaseModel {

  DocumentBaseModel(CouchDbBaseClient client): super(client);

  Future<String> docInfo(String dbName, String docId);
  Future<String> getDoc(
    String dbName,
    String docId,
    {
      bool attachments = false,
      bool attEncodingInfo = false,
      List<String> attsSince,
      bool conflicts = false,
      bool deletedConflicts = false,
      bool latest = false,
      bool localSeq = false,
      bool meta = false,
      List<String> openRevs,
      String rev,
      bool revs = false,
      bool revsInfo = false
    }
  );
  Future<String> insertDoc(
    String dbName,
    String docId,
    {
      String rev,
      String batch,
      bool newEdits = true
    }
  );
  Future<String> deleteDoc(
    String dbName,
    String docId,
    String rev,
    {
      String batch
    }
  );
  Future<String> copyDoc(
    String dbName,
    String docId,
    {
      String rev,
      String batch
    }
  );
  Future<String> attachmentInfo(
    String dbName,
    String docId,
    String attName,
    {
      String rev
    }
  );
  Future<String> getAttachment(
    String dbName,
    String docId,
    String attName,
    {
      String rev
    }
  );
  Future<String> insertAttachment(
    String dbName,
    String docId,
    String attName,
    {
      String rev
    }
  );
  Future<String> deleteAttachment(
    String dbName,
    String docId,
    String attName,
    {
      @required String rev,
      String batch
    }
  );
}