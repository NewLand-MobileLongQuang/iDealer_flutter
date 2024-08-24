import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    Key? key,
    this.onSearch,
    this.onTap,
    this.onSearchMicro,
    this.isEnable = true,
    this.autoFocus = false,
  }) : super(key: key);

  final VoidCallback? onTap;
  final void Function(String)? onSearch;
  final void Function(String)? onSearchMicro;
  final bool isEnable;
  final bool autoFocus;

  @override
  State<StatefulWidget> createState() {
    return SearchFieldState();
  }
}

class SearchFieldState extends State<SearchField> {
  final searchController = TextEditingController();

  @override
  void initState() {
    searchController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isEnable == false) {
          widget.onTap?.call();
        }
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(100),
            color: Colors.white),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                autofocus: widget.autoFocus,
                enabled: widget.isEnable,
                style: const TextStyle(fontSize: 15),
                controller: searchController,
                onChanged: (value) {
                  widget.onSearch!.call(value);
                },
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                  ),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            searchController.clear();
                            widget.onSearch!.call("");
                          },
                        )
                      : null,
                  hintText: 'Tìm kiếm',
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
