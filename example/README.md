# Server

```dart
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
```

## Browser

```dart
import 'dart:html';

import 'package:couchdb/couchdb.dart';

Future<void> main(List<String> args) async {
  final ButtonElement btn = querySelector('#data');
  final DivElement output = querySelector('#output');

  final c = CouchDbWebClient(username: 'admin', password: 'poiu7890_A');
  final dm = DocumentModel(c);

  btn.onClick.listen((event) async {
    try {
      DbResponse r = await dm.getDoc('denta', 'FishStew');
      output.text = '${r.id}';
    } on CouchDbException catch (e) {
      window.console.log('${e.code} - error');
    }
  });
}
```