// import 'package:test/test.dart';
import 'package:couchdb/couchdb.dart';
import 'package:couchdb/couchdb_server_client.dart';

Future<void> main() async {
  final c = CouchDbServerClient(username: 'name', password: 'pass');
  final sm = ServerModel(c);

  try {
    DbResponse o = await sm.getClusterSetup();
    print('${o.state} - success');
  } on CouchDbException catch (e) {
    print('$e - error');
  }
}

