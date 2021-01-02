class Failure implements Exception {}

class EmptyList extends Failure {}

class GetFail extends Failure {}

class NoInternetConnection extends Failure {}

class DatasourceResultNull extends Failure {}

class FailureDatabase implements Exception {}

class DatasourceDbResultNull extends FailureDatabase {}

class EmptyListDb extends FailureDatabase {}

class InvalidSearchTextDb extends FailureDatabase {}

class InexistentItemDb extends FailureDatabase {}
