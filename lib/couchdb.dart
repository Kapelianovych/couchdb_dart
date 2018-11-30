/// A library for interacting with CouchDB via server applications or browser-based clients
///
/// It is making according to the CouchDB API.
/// > Requests are made using HTTP and requests are used to request information from the database,
/// > store new data, and perform views and formatting of the information stored within the documents.
///
/// More detailed information about API is [here](http://docs.couchdb.org/en/stable/index.html).
library couchdb;

export 'src/clients/base/couchdb_base_client.dart';

export 'src/entities/db_response.dart';
export 'src/exceptions/couchdb_exception.dart';

export 'src/models/base/base_model.dart';
export 'src/models/base/database_base_model.dart';
export 'src/models/base/design_document_base_model.dart';
export 'src/models/base/document_base_model.dart';
export 'src/models/base/local_document_base_model.dart';
export 'src/models/base/server_base_model.dart';

export 'src/models/database_model.dart';
export 'src/models/design_document_model.dart';
export 'src/models/document_model.dart';
export 'src/models/local_document_model.dart';
export 'src/models/server_model.dart';
