import 'package:clear_app/add_to_do.dart';
import 'package:clear_app/base_state.dart';
import 'package:clear_app/util.dart';
import 'package:clear_app/to_do_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refreshable_reorderable_list/refreshable_reorderable_list.dart';

class ToDoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<ToDoBloc>(
        create: (_) => ToDoBloc(),
      )
    ], child: ToDoListPage());
  }
}

class ToDoListPage extends StatefulWidget {
  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends BaseState<ToDoListPage> {
  ToDoBloc _toDoBloc;
  ScrollController _controller;
  bool popFlag = false;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() async{
    if (_controller.offset <= _controller.position.minScrollExtent &&
        popFlag == false) {
      popFlag = true;
      String toDoData = await navigateNextTransparentScreen(context,AddToDoPage());
      popFlag = false;
    }
  }

  @override
  getAppbar() => AppBar(
        title: Text(
          ('ToDo').toUpperCase(),
          style: TextStyle(
            fontFamily: "roboto",
            fontWeight: FontWeight.w700,
            fontSize: 10.0,
          ),
        ),
      );

  @override
  List<Widget> mainLayout() {
    _toDoBloc = Provider.of<ToDoBloc>(context);
    return [
      RefreshableReorderableListView(
              scrollController: _controller,
              physics: AlwaysScrollableScrollPhysics(),
              onReorder: (oldIndex, newIndex) {
                _toDoBloc.takeReOrderDecision(oldIndex, newIndex);
              },
              children: [
                for (final item in _toDoBloc.defaultToDos)
                  item.isComplete
                      ? Container(
                          key: ValueKey(item),
                          color: Colors.black,
                          child: ListTile(
                            title: Text.rich(
                              TextSpan(
                                children: <TextSpan>[
                                  new TextSpan(
                                    text: item.toString(),
                                    style: new TextStyle(
                                      color: Colors.white,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Listener(
                          key: ValueKey(item),
                          child: Dismissible(
                            key: ValueKey(item),
                            resizeDuration: Duration(milliseconds: 200),
                            child: Container(
                              decoration: item.isDragging
                                  ? BoxDecoration(color: Colors.green)
                                  : BoxDecoration(
                                      gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Colors.blue,
                                        Colors.red,
                                      ],
                                    )),
                              child: ListTile(
                                title: Text.rich(
                                  TextSpan(
                                    children: <TextSpan>[
                                      new TextSpan(
                                        text: item.toString(),
                                        style: new TextStyle(
                                          color: Colors.white,
                                          decoration: item.isDragging
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            onDismissed: (DismissDirection direction) {
                              if (direction == DismissDirection.startToEnd) {
                                _toDoBloc.markItemComplete(item);
                              } else if (direction ==
                                  DismissDirection.endToStart) {
                                _toDoBloc.markItemDelete(item);
                              }
                            },
                            background: dragRightBg(),
                            secondaryBackground: dragLeftBg(),
                          ),
                          onPointerMove: (PointerMoveEvent event) =>
                              _toDoBloc.markDragState(item, event),
                        )
              ])
    ];
  }

  Widget dragRightBg() {
    return Container(
      color: Colors.black,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.assignment_turned_in_outlined,
              color: Colors.white,
            ),
            Text(
              "Done",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget dragLeftBg() {
    return Container(
      color: Colors.black,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }
}
