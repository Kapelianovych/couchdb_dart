import '../models/database_model.dart';

/// Class that contains responses from `DatabaseModel` class
class DatabaseModelResponse {
  /// Creates instance of [DatabaseModelResponse]
  DatabaseModelResponse(
      {this.cluster,
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
      this.list});

  /// Holds cluster's info
  final Map<String, int> cluster;

  /// Is true if the database compaction routine is operating on this database
  ///
  /// Returns by [DatabaseModel.dbInfo]
  final bool compactRunning;

  /// Holds the name of the database
  final String dbName;

  /// The version of the physical format used for the data when it is stored on disk
  final int diskFormatVersion;

  /// A count of the documents in the specified database
  final int docCount;

  /// Number of deleted documents
  final int docDelCount;

  /// An opaque string that describes the purge state of the database
  ///
  /// Do not rely on this string for counting the number of purge operations.
  final String purgeSeq;

  /// Sizes info returned by [DatabaseModel.dbInfo]
  final Map<String, int> sizes;

  /// An opaque string that describes the state of the database
  ///
  /// Do not rely on this string for counting the number of updates.
  final String updateSeq;

  /// Holds operation status. Available in case of success
  final bool ok;

  /// Holds document ID
  final String id;

  /// Holds revision info
  final String rev;

  /// Holds counts of documents skipped by search?
  final int offset;

  /// List of documents returned by search
  final List<Map<String, Object>> rows;

  /// Holds total number of documents returned by search
  final int totalRows;

  /// Holds result objects - one for each query
  ///
  /// Returned by [DatabaseModel.queriesDocsFrom], [DatabaseModel.bulkDocs], [DatabaseModel.changesIn]
  final List<Map<String, Object>> results;

  /// Holds documents matching the search
  final List<Map<String, Object>> docs;

  /// Holds execution warnings
  final String warning;

  /// Execution statistics info
  final Map<String, num> executionStats;

  /// An opaque string used for paging
  final String bookmark;

  /// Flag to show whether the index was created or one already exists. Can be “created” or “exists”
  final String result;

  /// Holds name of the index created
  final String name;

  /// Holds array of index definitions
  final List<Map<String, Object>> indexes;

  /// Index used to fulfill the query
  final Map<String, Object> index;

  /// Holds query selector used
  final Map<String, Map<String, Object>> selector;

  /// Holds query options used
  final Map<String, Object> opts;

  /// Holds limit parameter used
  ///
  /// Returns by [DatabaseModel.purgedInfosLimit], [DatabaseModel.explain]
  final int limit;

  /// Holds skip parameter used
  final int skip;

  /// Fields to be returned by the query
  final List<String> fields;

  /// Range parameters passed to the underlying view
  final Map<String, List<Object>> range;

  /// Last change update sequence info
  final String lastSeq;

  /// Count of remaining items in the feed
  final int pending;

  /// Holds list of users and/or roles that have admin rights
  final Map<String, List<String>> admins;

  /// Holds list of users and/or roles that have member rights
  final Map<String, List<String>> members;

  /// Mapping of document ID to list of purged revisions
  final Map<String, Map<String, List<String>>> purged;

  /// Holds mapping of document ID to list of missed revisions
  final Map<String, List<String>> missedRevs;

  /// Holds revs diffs for specified document
  ///
  /// Returns by [DatabaseModel.revsDiff]
  final Map<String, Map<String, List<String>>> revsDiff;

  /// List of some objects (if JSON itself is list)
  ///
  /// Returned by [DatabaseModel.insertBulkDocs]
  final List<Map<String, Object>> list;
}
