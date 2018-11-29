// import 'dart:io';

// /// Class for opening Fauxton in browser.
// ///
// /// **Don't work from browser environment.**
// /// Created for individual or development use
// class BrowserRunner {
//   /// Creates instance of [BrowserRunner] with URI
//   BrowserRunner(this._uri);

//   String _uri;

//   /// Runs default browser on `MacOS`, `Linux` and `Windows`
//   Future<void> run() async {
//     if (Platform.isMacOS) {
//       await Process.run('open', <String>[_normalizeUri()]);
//     } else if (Platform.isLinux) {
//       await Process.run('xdg-open', <String>[_normalizeUri()]);
//     } else if (Platform.isWindows) {
//       await Process.run('explorer', <String>[_normalizeUri()]);
//     }
//   }

//   String _normalizeUri() {
//     if (_uri.startsWith(RegExp('https?://'))) {
//       return _uri;
//     } else {
//       return 'http://$_uri';
//     }
//   }
// }
