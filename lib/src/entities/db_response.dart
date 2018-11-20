class DbResponse {
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

  String id;
  String rev;
  bool ok;
  String error;
  String reason;
  Map<String, List<String>> headers;
  int offset;
  List<Object> rows;
  int totalRows;
  List<Object> results;
  List<Object> docs;
  String warning;
  Map<String, Object> executionStats;
  String bookmark;
  String result;
  String name;
  List<Object> indexes;
  String dbName;
  Map<String, Object> index;
  Map<String, Object> selector;
  Map<String, Object> opts;
  int limit;
  int skip;

  // May be an array of fields or sring value: 'all_fields'
  Object fields;
  Map<String, Object> range;
  String lastSeq;
  int pending;
  String instanceStartTime;
  Map<String, Object> admins;
  Map<String, Object> members;
  int purgeSeq;
  Map<String, Object> purged;
  Map<String, Object> missedRevs;
  Map<String, Object> other;


  // Map<String, Object> toJson() => <String, Object>{ 'ok': ok, 'error': error, 'reason': reason };

  @override
  String toString() => '''Headers: $headers

    Ok: $ok.
    Error: $error, reason: $reason
    Id: $id, rev: $rev
    Offset: $offset, total rows: $totalRows
    Rows: $rows
    Results: $results
    Docs: $docs
    Warning: $warning
    Execution stats: $executionStats
    Bookmark: $bookmark
    Result: $result, name: $name
    Indexes: $indexes
    Db name: $dbName
    Index: $index
    Selector: $selector
    Fields: $fields
    Limit: $limit
    Skip: $skip
    Range: $range
    Opts: $opts
    Last seq: $lastSeq
    Pending: $pending
    Instance start time: $instanceStartTime
    Admins: $admins, members: $members
    Purge seq: $purgeSeq, purged: $purged
    Missed revs: $missedRevs
    Other: $other''';
}