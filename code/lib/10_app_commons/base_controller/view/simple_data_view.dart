import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idealer/10_app_commons/base_controller/base_controller.dart';
import 'package:idealer/10_app_commons/base_controller/simple_controller.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SimpleDataView extends StatefulWidget {
  const SimpleDataView({
    Key? key,
    required this.controller,
    required this.builder,
    this.useLoading = true,
    this.loadingEmptyWidget,
    this.showDataOnLoading = true,
    this.errorEmptyWidget,
    this.showDataOnError = true,
    this.errorDataBuilder,
    this.successEmptyWidget,
  }) : super(key: key);

  final Widget Function(SimpleController controller) builder;
  final bool useLoading;

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
  final Widget Function(BuildContext context)? errorDataBuilder;

  //success empty: sử dụng nếu muốn thay thế màn hình success empty
  final Widget? successEmptyWidget;

  final SimpleController controller;

  @override
  _SimpleDataViewState createState() => _SimpleDataViewState();
}

class _SimpleDataViewState extends State<SimpleDataView> {
  late SimpleController controller;

  @override
  void initState() {
    controller = widget.controller;
    super.initState();
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
          return buildLoadingData();
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
          return buildErrorData();
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
      return buildSuccessData();
    });
  }

  Widget buildLoadingEmpty(BuildContext context) {
    return LoadingOverlay(
        isLoading: widget.useLoading,
        child: widget.loadingEmptyWidget ??
            const Center(child: Text("Đang tải dữ liệu.")));
  }

  Widget buildLoadingData() {
    return LoadingOverlay(
        isLoading: widget.useLoading, child: buildSuccessData());
  }

  Widget buildErrorEmpty() {
    if (controller.error.value != null && controller.error.value is String) {
      var child = widget.errorEmptyWidget ??
          Center(child: Text("${controller.error.value}"));
      return child;
    }
    var child = widget.errorEmptyWidget ??
        const Center(child: Text("Có lỗi tải dữ liệu."));
    return child;
  }

  Widget buildErrorData() {
    Widget child;
    if (widget.errorDataBuilder != null) {
      //gọi hàm build hiển thị error data
      child = widget.errorDataBuilder!.call(context);
    } else {
      //hiển thị dữ liệu bình thường, không hiện lỗi
      return buildSuccessData();
    }
    return child;
  }

  Widget buildSuccessEmpty() {
    var child = widget.successEmptyWidget ??
        const Center(child: Text("Không có dữ liệu."));
    return child;
  }

  Widget buildSuccessData() {
    var child = widget.builder.call(controller);
    return child;
  }
}
