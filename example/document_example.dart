import 'package:couchdb/couchdb.dart';

Future<void> main(List<String> args) async {
  final c = CouchDbServerClient(username: 'name', password: 'pass');
  final dm = DocumentModel(c);

  try {
    DbResponse r = await dm.getDoc('db', 'some_id');
    print('$r - success');
  } on CouchDbException catch (e) {
    print('$e - error');
  }
}