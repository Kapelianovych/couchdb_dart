# A CouchDB client written in Dart

Created under a MIT-style
[license](https://github.com/YevhenKap/couchdb_dart/blob/master/LICENSE).

## Overview

> CouchDB is a database system that completely embraces the web. Store your data as
> JSON documents. Access them via HTTP.

A basic understanding of CouchDB is required to use this library. Detailed
information can be found at the [official documentation site](http://docs.couchdb.org/en/stable/api/basics.html).

### API

The connection to the database, along with authentication, is handled via
`CouchDbClient` for both web and server environments.

Three types of authentication are available:

    - Basic
    - Cookie
    - Proxy

For `Basic` authentication simply pass `username` and `password` to constructor:

```dart
final c = CouchDbClient(username: 'name', password: 'pass');
```

For `Cookie` authentication you also must provide `auth` parameter, then call
`authenticate()` method (note that cookies are valid for 10 minutes by default,
you may specify other expiration in the `Expiration` header):

```dart
final c = CouchDbClient(username: 'name', password: 'pass', auth: 'cookie');
final res = await c.authenticate();
```

> `authenticate()`, `logout()` are suitable only for `cookie` authentication.
> `userInfo()` are suitable for all auth types.

For `Proxy` authentication pass `username` to constructor and provide:

- `X-Auth-CouchDB-UserName`: username (by default the `username` passed to the
   constructor is used, so it can be skipped);
- `X-Auth-CouchDB-Roles`: comma-separated (,) list of user roles;
- `X-Auth-CouchDB-Token`: authentication token. When `proxy_use_secret` is set
  (which is **strongly recommended!**), this header provides an HMAC of the username
  to authenticate and the secret token to prevent requests from untrusted sources
  (by default the `username` and `secret` passed to constructor are used,
  so it can be skipped).

Headers:

```dart
final c = CouchDbClient(username: 'name', auth: 'proxy', secret: '92de07df7e7a3fe14808cef90a7cc0d91');
c.modifyRequestHeaders(<String, String>{
  'X-Auth-CouchDB-Roles': 'users,blogger'
});
```

> Note that `X-Auth-CouchDB-Token` is not required if **proxy_use_secret** sets to `false`.

    [couch_httpd_auth]
    proxy_use_secret = false

> Otherwise you may provide `secret` option which is used to generate token.
> The secret key should be the same on the client and the CouchDB node:

    [couch_httpd_auth]
    secret = 92de07df7e7a3fe14808cef90a7cc0d91

> To use this authentication method make sure that the {chttpd_auth, proxy_authentication_handler}
> value in added to the list of the active chttpd/authentication_handlers:

    [chttpd]
    authentication_handlers = {chttpd_auth, cookie_authentication_handler}, {chttpd_auth, proxy_authentication_handler}, {chttpd_auth, default_authentication_handler}

#### Anonymous user

You can configure access to your database to anonymous users.
To achieve this you must provide the following option (and don't set
username and password to `CouchDbClient` constructor):

    [chttpd]
    require_valid_user = false

Otherwise, no requests will be allowed from anonymous users.

#### Client

If you wish you can communicate with the server directly via the client's
methods such as `get()` and `post()`, however, other classes provide functions
which can abstract away the particulars of the protocol. Therefore using
the client's methods directly is not the way you will typically use this library.

Every supported HTTP method: `HEAD`, `GET`, `POST`, `PUT`, and `COPY` has an `Accept`
header with a default value of `application/json`, and `POST` and `PUT` both have
a `Content-Type` header with a default value of `application/json`.
You can override this if you need.

Most of the client's methods return a `Future<ApiResponse>` object.
When the future completes normally, it will contain:
- an `ApiResponse.json` property (`Map` type) containing JSON that was sent by CouchDB,
- an `ApiResponse.raw` property (`String` type) for responses that are not
  a JSON object (numbers, lists, files,)
- an `ApiResponse.headers` property that contains headers of the HTTP response.

In case of failure, the exception payload `response` will be an `ErrorResponse` object.

Because of the sheet number of response information, the package has been organized
around categories, each providing a more specific `...Response` class.

You can find more information below and in the [package API](https://pub.dev/documentation/couchdb/latest/).

#### Categories

The API is divided into five categories, or areas, each representing a
different aspect of the database overall. These five categories are:

    1. Server
    2. Databases
    3. Documents
    4. Design documents
    5. Local documents

##### 1: Server

Represented by the `Server` class. This class provides server level interaction
with CouchDB, such as managing replication or obtaining basic information about
the server. It also includes info about authentication and current user
(methods in `CouchDbClient` class).

The `Server` class methods return a `Future<ServerResponse>`.

##### 2: Databases

A Database in CouchDB is a single document store located on the given database
server. This part of the API is represented by the `Databases` class. You use
this class for interacting with your data on a database level; for example
creating a new database or preforming a query to search for certain documents.

The `Databases` class methods return  a `Future<DatabasesResponse>`.

##### 3: Documents

You use the `Documents` class to interact with the data on a document level.
This would include functions such as fetching a specific document, adding a new
document, or attaching a file to a document. Note that this class does not
model the documents themselves, but rather your interactions with them.
The documents themselves are represented as `Map`s.

The `Documents` class methods return a `Future<DocumentsResponse>`.

##### 4: Design Documents

Design documents provide views of data in the database.
You interact with them with the `DesignDocuments` class.

The `DesignDocuments` class methods return a `Future<DesignDocumentsResponse>`.

##### 5: Local Documents

Local documents are no different than normal documents, with the exception that
they are not copied to other instances of CouchDB during replication.
You interact with them via the `LocalDocuments` class.

The `LocalDocuments` class methods return a `Future<LocalDocumentsResponse>`.

### CORS

CORS is a method of enabling a web app to talk to a server other than the server
hosting it. It is only necessary if the application is running in the browser.

#### CouchDB Server Configuration for CORS

If the application is not on the same origin with CouchDB instance (or you using
different ports on server), then the remote CouchDB must be configured with
the following options:

    [httpd]
    enable_cors = true
    [cors]
    origins = *
    credentials = true
    methods = GET, PUT, POST, HEAD, DELETE, COPY
    headers = accept, authorization, content-type, origin, referer, x-csrf-token

Change these settings either in Fauxton configuration utility or in the CouchDb
_local.ini_ file. For better security, specify specific domains instead
of * in the `origins` section.

#### Browser Client Configuration for CORS

Depending on the browser, you might also need to pass `cors=true` to the
`CouchDbClient` constructor. However, most of the time the browser will handle
this for you and this shouldn't be necessary.
In fact, it might cause an "Unsafe Header" message in the browser console.

## Usage

A simple usage example:

```dart
import 'package:couchdb/couchdb.dart';

Future<void> main() async {
  final client = CouchDbClient(username: 'name', password: 'password');
  final dbs = Databases(client);
  final docs = Documents(client);

  try {
    final DatabasesResponse response1 = await dbs.allDocs('some_db');

    for (var i in response1.rows) {
      // Some code here
    }

    final DocumentsResponse response2 = await docs.doc('another_db', 'some_id');

    var thing = response2.doc['some_attribute'];

  } on CouchDbException catch (e) {
    print('$e - error');
  }
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/YevhenKap/couchdb_dart/issues

**With ❤️ to CouchDB**
