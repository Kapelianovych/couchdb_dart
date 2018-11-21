/// Object containing all results returned by database
class DbResponse {
  /// Constructor for creating response. Prefer using factory constructor [DbResponse.fromJson(json)]
  DbResponse({
    this.ok,
    this.error,
    this.reason,
    this.id,
    this.rev,
    this.headers,
    this.offset,
    this.rows,
    this.totalRows,
    this.results,
    this.docs,
    this.bookmark,
    this.executionStats,
    this.warning,
    this.result,
    this.name,
    this.indexes,
    this.dbName,
    this.fields,
    this.index,
    this.limit,
    this.opts,
    this.range,
    this.selector,
    this.skip,
    this.lastSeq,
    this.pending,
    this.instanceStartTime,
    this.admins,
    this.members,
    this.purgeSeq,
    this.purged,
    this.missedRevs,
    this.other
  });

  /// Parses [json] response from database
  factory DbResponse.fromJson(Map<String, Object> json) =>
    DbResponse(
      ok: json['ok'],
      error: "${json['error']}",
      reason: "${json['reason']}",
      id: "${json['id']}",
      rev: "${json['rev']}",
      headers: json['headers'],
      offset: json['offset'],
      rows: json['rows'],
      totalRows: json['total_rows'],
      results: json['results'],
      docs: json['docs'],
      warning: '${json['warning']}',
      executionStats: json['execution_stats'],
      bookmark: '${json['bookmark']}',
      result: '${json['result']}',
      name: '${json['name']}',
      indexes: json['indexes'],
      dbName: '${json['dbname']}',
      fields: json['fields'],
      index: json['index'],
      limit: json['limit'],
      opts: json['opts'],
      range: json['range'],
      selector: json['selector'],
      skip: json['skip'],
      pending: json['pending'],
      lastSeq: '${json['last_seq']}',
      instanceStartTime: '${json['instance_start_time']}',
      admins: json['admins'],
      members: json['members'],
      purgeSeq: json['purge_seq'],
      purged: json['purged'],
      missedRevs: json['missed_revs'],
      other: json
    );

  /// Document id
  String id;

  /// Document revision
  String rev;

  /// Success of operation
  bool ok;

  /// Short description of error
  String error;

  /// Reason of error
  String reason;

  /// Headers of response
  Map<String, List<String>> headers;

  /// Offset where the design document list started
  int offset;

  ///  Array of view row objects
  List<Object> rows;

  /// Number of documents or indexes of database
  int totalRows;

  /// An array of result objects returning by [queriesDocsFrom()] method
  List<Object> results;

  /// Array of documents matching the search of [find()] method
  List<Object> docs;

  /// Warning that appear during execution process
  String warning;

  /// Object that show execution statistics
  Map<String, Object> executionStats;

  /// An opaque string used for paging
  String bookmark;

  ///  Flag to show whether the index was created or one already exists. Can be **created** or **exists**
  String result;

  /// Name of the created index
  String name;

  /// Array of index definitions
  List<Object> indexes;

  /// Name of database
  String dbName;

  /// Index used to fulfill the query
  Map<String, Object> index;

  /// Query selector used
  Map<String, Object> selector;

  /// Query options used
  Map<String, Object> opts;

  /// Count limit of returned parameters
  int limit;

  /// Count of skipped parameters
  int skip;

  /// Fields to be returned by the query of [explain()] method
  ///
  /// May be an array of fields or sring value: 'all_fields'
  Object fields;

  /// Range parameters passed to the underlying view of [explain()] method
  Map<String, Object> range;

  /// Last change update sequence
  String lastSeq;

  /// Count of remaining items in the feed of [changesIn()] and [postChangesIn()] methods
  int pending;

  /// Exist for legacy reasons. Always have value "0"
  String instanceStartTime;

  /// Users that have admin privileges
  Map<String, Object> admins;

  /// Users that have member privileges
  Map<String, Object> members;

  /// Purge sequence number
  int purgeSeq;

  /// List of the document IDs and revisions successfully purged
  Map<String, Object> purged;

  /// Document revisions that do not exist in the database
  Map<String, Object> missedRevs;

  /// Field that contain result of [revsDiff()] method
  Map<String, Object> other;

  @override
  String toString() => 'Instance of DbResponse';
}