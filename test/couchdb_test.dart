// import 'package:test/test.dart';
import 'package:couchdb/couchdb.dart';
import 'package:couchdb/couchdb_server_client.dart';

Future<void> main() async {
  final c = CouchDbServerClient(username: 'name', password: 'pass');
  final dm = DatabaseModel(c);
  final sm = ServerModel(c);

  try {
    final r = await dm.createDb('denta2');
    DbResponse o;
    if (r.ok) {
      o = await sm.replicate(source: 'denta', target: 'denta2');
    }
    await dm.deleteDb('denta4');
    print('${o.ok} - success');
    print('${o.sourceLastSeq} - success');
  } on CouchDbException catch (e) {
    print('$e - error');
  }
}

