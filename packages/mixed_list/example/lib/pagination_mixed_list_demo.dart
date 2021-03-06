import 'dart:async';
import 'dart:math';

import 'package:datalist/datalist.dart';
import 'package:example/item_builder.dart';
import 'package:example/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mixed_list/mixed_list.dart';

import 'items/post.dart';

/// Widget for demonstration Mixed List pagination.
class PaginationMixedListDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PaginationMixedListDemo();
}

class _PaginationMixedListDemo extends State<PaginationMixedListDemo> {
  StreamController<PaginationState> paginationController = StreamController();
  StreamController<OffsetDataList<Post>> itemsController = StreamController();

  var _dataList = OffsetDataList<Post>.empty();

  @override
  void initState() {
    paginationController.sink.add(PaginationState.none);

    super.initState();
  }

  void _loadNext() {
    paginationController.sink.add(PaginationState.loading);
    getPostList(_dataList.nextOffset, 10,
            emulateSlowConnect: Random().nextBool())
        .then((response) {
      if (response.isEmpty) {
        paginationController.sink.add(PaginationState.complete);
      } else {
        itemsController.sink.add(response);
        paginationController.sink.add(PaginationState.none);
      }
    }).catchError((error) {
      paginationController.sink.add(PaginationState.error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OffsetDataList<Post>>(
      stream: itemsController.stream,
      initialData: _dataList,
      builder: (ctx, postList) {
        _dataList.merge(postList.data);
        return PaginationMixedList(
          items: _dataList,
          supportedItemControllers: {
            Post: PostBuilder(),
          },
          listMode: ListMode.list,
          onLoadMore: _loadNext,
          paginationState: paginationController.stream,
          paginationFooterBuilder: (context, state) {
            if (state == PaginationState.loading) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state == PaginationState.error) {
              return Container(
                height: 50,
                color: Color(0xFFFF0000),
                child: Center(
                  child: FlatButton(
                    child: Text(
                      "Press to reload"
                    ),
                    onPressed: () {
                      _loadNext();
                    },
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    paginationController.close();
    itemsController.close();

    super.dispose();
  }
}
