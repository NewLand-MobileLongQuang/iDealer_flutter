import 'base_controller.dart';

abstract class SimpleController extends BaseController<bool> {
  Future<void>? simpleLoadFuture;

  @override
  Future<bool> load(int loadLimit) async {
    simpleLoadFuture = simpleLoad();
    await simpleLoadFuture;
    return true;
  }

  Future<void> simpleLoad();
}
