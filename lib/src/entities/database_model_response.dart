import '../models/database_model.dart';

/// Class that contains responses from `DatabaseModel` class
class DatabaseModelResponse {
  /// Creates instance of [DatabaseModelResponse]
  DatabaseModelResponse({ 
      this.cluster,
      this.compactRunning,
      this.dbName,
      this.diskFormatVersion,
      this.docCount,
      this.docDelCount,
      this.purgeSeq,
      this.sizes,
      this.updateSeq,
      this.ok,
      this.id,
      this.rev,
      this.offset,
      this.rows,
      this.totalRows,
      this.results,
      this.docs,
      this.warning,
      this.executionStats,
      this.bookmark,



      this.list,





      this.replicationIdVersion,
      this.sessionId,
      this.database,
      this.docId,
      this.info,
      this.errorCount,
      this.status,
      this.uuids,
    });

  /// Holds cluster's info
  Map<String, int> cluster;
  /// Is true if the database compaction routine is operating on this database
  /// 
  /// Returns by [DatabaseModel.dbInfo]
  bool compactRunning;
  /// Holds the name of the database
  String dbName;
  /// The version of the physical format used for the data when it is stored on disk
  int diskFormatVersion;
  /// A count of the documents in the specified database
  int docCount;
  /// Number of deleted documents
  int docDelCount;
  /// An opaque string that describes the purge state of the database
  /// 
  /// Do not rely on this string for counting the number of purge operations.
  String purgeSeq;
  /// Sizes info returned by [DatabaseModel.dbInfo]
  Map<String, int> sizes;
  /// An opaque string that describes the state of the database
  /// 
  /// Do not rely on this string for counting the number of updates.
  String updateSeq;
  /// Holds operation status. Available in case of success
  bool ok;
  /// Holds document ID
  String id;
  /// Holds revision info
  String rev;
  /// Holds counts of documents skipped by search?
  int offset;
  /// List of documents returned by search
  List<Map<String, Object>> rows;
  /// Holds total number of documents returned by search
  int totalRows;
  /// Holds result objects - one for each query
  /// 
  /// Returned by [DatabaseModel.queriesDocsFrom], [DatabaseModel.bulkDocs]
  List<Map<String, Object>> results;
  /// Holds documents matching the search
  List<Map<String, Object>> docs;
  /// Holds execution warnings
  String warning;
  /// Execution statistics info
  Map<String, num> executionStats;
  /// An opaque string used for paging
  String bookmark;


  /// List of some objects (if JSON itself is list)
  /// 
  /// Returned by [DatabaseModel.insertBulkDocs]
  List<Map<String, Object>> list;





  String state;
  /// Holds replication protocol version
  int replicationIdVersion;
  /// Holds unique session ID
  String sessionId;
  /// Holds replication document database
  String database;
  /// Holds replication document ID
  String docId;
  /// May contain additional information about the state.
  /// 
  /// For error states, this will be a string. For success states this will contain a JSON object.
  Object info;
  /// Holds consecutive errors count
  int errorCount;
  /// Status of current running node
  String status;
  /// List of uuids returned by CouchDB
  /// 
  /// Returned by [ServerModel.uuids]
  List<String> uuids;
}