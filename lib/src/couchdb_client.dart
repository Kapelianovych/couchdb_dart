class CouchDbClient {
  static CouchDbClient _client;
  
  String host;
  int port;
  String username;
  String password;

  factory CouchDbClient({
    String username,
    String password,
    String host = '127.0.0.1',
    int port = 5984
  }) => _client ??= CouchDbClient._create(
          username,
          password,
          host,
          port
        );

  CouchDbClient._create(
    this.username,
    this.password,
    this.host,
    this.port
  );

  String getConnectUri() => 'http://$username:$password@$host:$port';
}