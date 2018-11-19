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
    this.totalRows
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
      totalRows: json['total_rows']
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

  // Map<String, Object> toJson() => <String, Object>{ 'ok': ok, 'error': error, 'reason': reason };

  @override
  String toString() => '''Headers: $headers

    Ok: $ok.
    Error: $error, reason: $reason
    Id: $id, rev: $rev
    Offset: $offset, total rows: $totalRows
    Rows: $rows''';
}