// import 'package:test/test.dart';
import 'package:couchdb/couchdb.dart';
import 'package:couchdb/couchdb_server_client.dart';

Future<void> main() async {
  final c = CouchDbServerClient(username: 'name', password: 'pass');
  final sm = ServerModel(c);
  final dm = DatabaseModel(c);

  try {
    // final r = await sm.favicon();
    final o = await dm.revsLimitOf('denta');
    print(o.limit);
  } on CouchDbException catch (e) {
    print('$e - error');
  }
}

