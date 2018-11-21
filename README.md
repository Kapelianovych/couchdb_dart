# A library for Dart developers for work with CouchDB

`This library is under heavy development. Methods and entire classes may change in the future!`

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

## Overview

> Requests to the API are categorised by the different areas of the CouchDB system that you are accessing.

Exist 5 areas of API:

    1. Server
    2. Database
    3. Documents
    4. Design documents
    5. Local documents

Every area (layer) contain own method for interacting with CouchDB.
Detailed information you can find in [official documentation site](http://docs.couchdb.org/en/stable/api/basics.html).

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/YevhenKap/couchdb_dart/issues

**With ❤️ to CouchDb**