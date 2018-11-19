# A library for Dart developers for work with CouchDb

Created under a MIT-style
[license](https://github.com/YevhenKap/couchdb_dart/blob/master/LICENSE).

## Usage

A simple usage example:

```dart
import 'package:couchdb/couchdb.dart';

Future<void> main() async {
  final c = CouchDbServerClient(username: 'name', password: 'password');
  final dm = DatabaseModel(c);

  try {
    final o = await dm.getAllDocs('denta');

    // Some code here

  } on CouchDbException catch (e) {
    print('$e - error');
  }
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/YevhenKap/couchdb_dart/issues
