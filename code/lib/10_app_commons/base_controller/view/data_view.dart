import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/10_app_commons/base_controller/base_controller.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DataView<T> extends StatefulWidget {
  const DataView({
    Key? key,
    required this.controller,
    required this.builder,
    this.useLoading = true,
    this.usePullDown = false,
    this.overrideOnPullDown,
    this.usePullUp = false,
    this.overrideOnPullUp,
    this.reverse = false,
    this.loadingEmptyWidget,
    this.showDataOnLoading = true,
    this.errorEmptyWidget,
    this.showDataOnError = true,
    this.errorDataBuilder,
    this.successEmptyWidget,
  }) : super(key: key);

  final Widget Function(BaseController<T> controller, T data) builder;
  final bool useLoading;
  final bool usePullDown;
  final void Function(RefreshController refreshController)? overrideOnPullDown;
  final bool usePullUp;
  final void Function(RefreshController refreshController)? overrideOnPullUp;
  final bool reverse;

  //loading empty: sử dụng nếu muốn thay thế màn hình loading empty
  final Widget? loadingEmptyWidget;

  //showDataOnLoading: có hiển thị dữ liệu cũ khi đang tải lại không
  //Có hiện thị (true) khi dữ liệu cũ vẫn còn ý nghĩa sau khi loading
  final bool showDataOnLoading;

  //error empty: sử dụng nếu muốn thay thế màn hình error empty
  final Widget? errorEmptyWidget;

  //showDataOnError: có hiển thị dữ liệu cũ khi có lỗi không
  //Có hiện thị (true) khi dữ liệu cũ vẫn còn ý nghĩa khi error
  final bool showDataOnError;

  //tạo hiển thị error data
  final Widget Function(BuildContext context, T data)? errorDataBuilder;

  //success empty: sử dụng nếu muốn thay thế màn hình success empty
  final Widget? successEmptyWidget;

  final BaseController<T> controller;

  @override
  State<DataView<T>> createState() => _DataViewState<T>();
}

class _DataViewState<T> extends State<DataView<T>> {
  late RefreshController refreshController;
  var refreshKey = GlobalKey();
  late BaseController<T> controller;

  @override
  void initState() {
    controller = widget.controller;
    if (widget.usePullDown || widget.usePullUp || widget.reverse) {
      refreshController = RefreshController(initialRefresh: false);
    }
    super.initState();
  }

  void onChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    controller.removeListener(onChanged);
    super.dispose();
  }

  void onPullDown() async {
    refreshController.refreshCompleted();
    if (widget.overrideOnPullDown != null) {
      widget.overrideOnPullDown?.call(refreshController);
    } else {
      await controller.reload();
    }
  }

  void onPullUp() async {
    if (widget.overrideOnPullUp != null) {
      widget.overrideOnPullUp?.call(refreshController);
    } else {
      var result = await controller.loadMore();
      if (result) {
        refreshController.loadComplete();
      } else {
        refreshController.loadFailed();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.state.value == ControllerState.loading) {
        if (controller.data.value == null ||
            (controller.data.value is List &&
                (controller.data.value as List).isEmpty)) {
          //dữ liệu rỗng
          return buildLoadingEmpty(context);
        }
        if (widget.showDataOnLoading == false) {
          //có dữ liệu nhưng không show on loading
          return buildLoadingEmpty(context);
        } else {
          //có dữ liệu và có show on loading
          return buildLoadingData(controller.data.value!);
        }
      }
      if (controller.state.value == ControllerState.error) {
        if (controller.data.value == null ||
            (controller.data.value is List &&
                (controller.data.value as List).isEmpty)) {
          //loading empty
          return buildErrorEmpty();
        }
        if (widget.showDataOnError == false) {
          //nếu không hiển thị data on error => show error empty
          return buildErrorEmpty();
        } else {
          //có hiển thị dữ liệu khi có lỗi
          return buildErrorData(controller.data.value!);
        }
      }
      if (controller.data.value == null) {
        //dữ liệu trả về rỗng
        return buildSuccessEmpty();
      }
      if (controller.data.value == null ||
          (controller.data.value is List &&
              (controller.data.value as List).isEmpty)) {
        //dữ liệu trả về không rỗng
        return buildSuccessEmpty();
      }
      return buildSuccessData(controller.data.value!);
    });
  }

  Widget buildLoadingEmpty(BuildContext context) {
    return LoadingOverlay(
        isLoading: widget.useLoading,
        child: widget.loadingEmptyWidget ??
            const Center(child: Text("Đang tải dữ liệu.")));
  }

  Widget buildLoadingData(T data) {
    return LoadingOverlay(
        isLoading: widget.useLoading, child: buildSuccessData(data));
  }

  Widget buildErrorEmpty() {
    var child = widget.errorEmptyWidget ??
        const Center(child: Text("Có lỗi tải dữ liệu."));
    if (widget.usePullDown || widget.usePullUp || widget.reverse) {
      return getSmartRefresher(child);
    }
    return child;
  }

  Widget buildErrorData(T data) {
    Widget child;
    if (widget.errorDataBuilder != null) {
      //gọi hàm build hiển thị error data
      child = widget.errorDataBuilder!.call(context, data);
    } else {
      //hiển thị dữ liệu bình thường, không hiện lỗi
      return buildSuccessData(data);
    }
    if (widget.usePullDown || widget.usePullUp || widget.reverse) {
      return getSmartRefresher(child);
    }
    return child;
  }

  Widget buildSuccessEmpty() {
    var child = widget.successEmptyWidget ??
        const Center(child: Text("Không có dữ liệu."));
    if (widget.usePullDown || widget.usePullUp || widget.reverse) {
      return getSmartRefresher(child);
    }
    return child;
  }

  Widget buildSuccessData(T data) {
    var child = widget.builder.call(controller, data);
    if (widget.usePullDown || widget.usePullUp || widget.reverse) {
      return getSmartRefresher(child);
    }
    return child;
  }

  SmartRefresher getSmartRefresher(Widget child) {
    return SmartRefresher(
      key: refreshKey,
      controller: refreshController,
      header: const MaterialClassicHeader(),
      enablePullDown: widget.usePullDown,
      enablePullUp: widget.usePullUp,
      child: child,
      onRefresh: onPullDown,
      onLoading: onPullUp,
      reverse: widget.reverse,
    );
  }
}
