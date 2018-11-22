import 'package:couchdb/couchdb.dart';

Future<void> main(List<String> args) async {
  final c = CouchDbServerClient(username: 'name', password: 'pass');
  final dm = DocumentModel(c);

  try {
    DbResponse r = await dm.deleteDoc('ddds', 'asdf', '1-47abcaa8abbf8ce6ce772d92e423e24d');
    print('$r - success');
  } on CouchDbException catch (e) {
    print('$e - error');
  }
}
