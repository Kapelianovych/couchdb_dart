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
      this.result,
      this.name,
      this.indexes,
      this.index,
      this.selector,
      this.opts,
      this.limit,
      this.skip,
      this.fields,
      this.range,
      this.lastSeq,
      this.pending,
      this.admins,
      this.members,
      this.purged,
      this.missedRevs,
      this.revsDiff,
      this.list
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
  /// Returned by [DatabaseModel.queriesDocsFrom], [DatabaseModel.bulkDocs], [DatabaseModel.changesIn]
  List<Map<String, Object>> results;
  /// Holds documents matching the search
  List<Map<String, Object>> docs;
  /// Holds execution warnings
  String warning;
  /// Execution statistics info
  Map<String, num> executionStats;
  /// An opaque string used for paging
  String bookmark;
  /// Flag to show whether the index was created or one already exists. Can be “created” or “exists”
  String result;
  /// Holds name of the index created
  String name;
  /// Holds array of index definitions
  List<Map<String, Object>> indexes;
  /// Index used to fulfill the query
  Map<String, Object> index;
  /// Holds query selector used
  Map<String, Map<String, Object>> selector;
  /// Holds query options used
  Map<String, Object> opts;
  /// Holds limit parameter used
  /// 
  /// Returns by [DatabaseModel.purgedInfosLimit], [DatabaseModel.explain]
  int limit;
  /// Holds skip parameter used
  int skip;
  /// Fields to be returned by the query
  List<String> fields;
  /// Range parameters passed to the underlying view
  Map<String, List<Object>> range;
  /// Last change update sequence info
  String lastSeq;
  /// Count of remaining items in the feed
  int pending;
  /// Holds list of users and/or roles that have admin rights
  Map<String, List<String>> admins;
  /// Holds list of users and/or roles that have member rights
  Map<String, List<String>> members;
  /// Mapping of document ID to list of purged revisions
  Map<String, Map<String, List<String>>> purged;
  /// Holds mapping of document ID to list of missed revisions
  Map<String, List<String>> missedRevs;
  /// Holds revs diffs for specified document
  /// 
  /// Returns by [DatabaseModel.revsDiff]
  Map<String, Map<String, List<String>>> revsDiff;
  /// List of some objects (if JSON itself is list)
  /// 
  /// Returned by [DatabaseModel.insertBulkDocs]
  List<Map<String, Object>> list;
}