# 0.0.5

- Implement `CouchDbWebClient` for interacting with CouchDB.
- Moving all examples to `example/README.md`.

## 0.0.4

- Implements `attachmentInfo()`, `getAttachment()`, `insertAttachment()` and `deleteAttachment()` methods of `DocumentModel`.
- Implement `setRevsLimit()` method of `DatabaseModel`.
- Method `put()` now accept any body type.
- Non-json response body now available in `rawBody` field of `DbRespone` class.

## 0.0.3

- Implements `insertDoc()`, `deleteDoc()` and `copyDoc()` methods of `DocumentModel`.
- All methods of `CouchDb(Server/Web)Client` can set custom headers.

## 0.0.2

- Implementats `docInfo()` and `getDoc()` methods of `DocumentModel`.
- Add documentation to `DatabaseModel` methods.
- Add opportunity to add headers to `head()` method of `CouchDb(Server/Web)Client`.

## 0.0.1

- Initial version.
- Implement `CouchDbServerClient` for interacting with CouchDB.
- Implements `DatabaseBaseModel` methods.