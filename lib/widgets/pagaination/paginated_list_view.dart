import 'dart:developer';

import 'package:flutter/material.dart';

class PaginatedListView extends StatefulWidget {
  final ScrollController scrollController;
  final Function(int offset) onPaginate;
  final int totalSize;
  final int pageSize;
  final int offset;
  final Widget productView;

  const PaginatedListView({
    Key? key,
    required this.scrollController,
    required this.onPaginate,
    required this.totalSize,
    required this.pageSize,
    required this.offset,
    required this.productView,
  }) : super(key: key);

  @override
  State<PaginatedListView> createState() => _PaginatedListViewState();
}

class _PaginatedListViewState extends State<PaginatedListView> {
  late int _offset;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _offset = widget.offset;
    widget.scrollController.addListener(_onEndScroll);
  }

  void _onEndScroll() {
    double maxScroll = widget.scrollController.position.maxScrollExtent;
    double currentScroll = widget.scrollController.position.pixels;
    double screenHeight = mounted ? MediaQuery.sizeOf(context).height : 850;
    double threshold = 0.9 * screenHeight;

    double breakpoint = maxScroll - threshold;
    int numberOfPages = (widget.totalSize / widget.pageSize).ceil();

    if (currentScroll >= breakpoint &&
        _offset <= numberOfPages &&
        !_isLoading) {
      log('Start Pagination: [$_offset || $numberOfPages]');

      if (mounted) {
        _paginate();
      }
    }
  }

  void _paginate() async {
    int pageSize = widget.pageSize;
    int numberOfPages = (widget.totalSize / widget.pageSize).ceil();
    log('pageSize: $pageSize');
    log('_offset: $_offset');
    if (_offset <= numberOfPages) {
      setState(() {
        _offset = _offset + 1;
        _isLoading = true;
      });
      await widget.onPaginate(_offset);
      setState(() {
        _isLoading = false;
      });
    } else {
      if (_isLoading) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: widget.productView,
        ),
        if (_isLoading)
          const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
      ],
    );
  }
}
