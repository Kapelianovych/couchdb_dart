/// Method for including only non-null parameter to path
String includeNonNullParam(String name, Object value) =>
    value != null ? '$name=$value' : '';
