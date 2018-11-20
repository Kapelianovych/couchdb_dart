import 'package:couchdb/couchdb.dart';

Future<void> main() async {
  final c = CouchDbServerClient(username: 'admin', password: 'poiu7890_A');
  final dm = DatabaseModel(c);

  final revs = {
    'e290f58b934cfdede1da55cf1800261a': <String>['1-b5b337f482d2de50b10aed655c357a9b', '3-bb72a7682290f94a985f7afac8b27137']
};

  try {
    final o = await dm.revsLimitOf('denta');
    print('$o - success');
  } on CouchDbException catch (e) {
    print('$e - error');
  }
  
}
