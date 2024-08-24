import 'package:get/get.dart';

enum ControllerState {
  loading,
  error,
  success,
}

abstract class BaseController<T> extends GetxController {
  static const int DEFAULT_PAGE_SIZE = 10;
  int pageSize = DEFAULT_PAGE_SIZE;
  int loadLimit = DEFAULT_PAGE_SIZE;

  var state = ControllerState.success.obs;

  var data = Rx<T?>(null);
  var error = Rx<Object?>(null);

  Future<T>? _currentFuture;
  Future<T> load(int loadLimit);

  Future<bool> reload() async {
    var future = load(loadLimit);
    _currentFuture = future;
    setLoading();

    return future.then((value) {
      if (_currentFuture == future) {
        data.value = value;
        setSuccess();
        return true;
      }
      return false;
    }).onError((errorObj, stackTrace) {
      if (_currentFuture == future) {
        setError(errorObj);
      }
      return false;
    });
  }

  Future<bool> silentReload() async {
    if (state.value == ControllerState.loading) return false;
    var future = load(loadLimit);
    _currentFuture = future;
    return future.then((value) {
      if (_currentFuture == future) {
        data.value = value;
        setSuccess();
        return true;
      }
      return false;
    }).onError((error, stackTrace) {
      return false;
    });
  }

  Future<bool> loadMore({bool isSilent = true}) async {
    if (state.value == ControllerState.loading) return false;
    loadLimit += pageSize;
    if (isSilent) {
      return silentReload();
    }
    return reload();
  }

  Future<T>? get future {
    return _currentFuture;
  }

  void setSuccess() {
    state.value = ControllerState.success;
    error.value = null;
  }

  void setLoading() {
    state.value = ControllerState.loading;
    error.value = null;
  }

  void setError(Object? errorObj) {
    state.value = ControllerState.error;
    error.value = errorObj;
  }
}
