import 'package:couchdb/couchdb.dart';

Future<void> main() async {
  final c = CouchDbServerClient(username: 'name', password: 'pass');
  final dm = DatabaseModel(c);

  try {
    DbResponse o = await dm.dbInfo('db');
    print('$o - success');
  } on CouchDbException catch (e) {
    print('$e - error');
  }
}
