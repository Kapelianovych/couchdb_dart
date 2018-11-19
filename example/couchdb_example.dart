import 'package:couchdb/couchdb.dart';

Future<void> main() async {
  final c = CouchDbServerClient(username: 'admin', password: 'poiu7890_A');
  final dm = DatabaseModel(c);

  final keys = <String>['e290f58b934cfdede1da55cf180055a6', 'e290f58b934cfdede1da55cf1800261a'];
  final doc = <String, String>{
    'lkjsd': 'a;skjd',
    'alsdl': 'kjsdkf'
  };

  try {
    final o = await dm.getDocsByKeys('denta', keys: keys);
    print('$o - success');
  } on CouchDbException catch (e) {
    print('$e - error');
  }
  
}
