import 'package:clear_app/to_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ToDoBloc extends ChangeNotifier {

  List<ToDo> _defaultToDos = [
    ToDo('Swipe to the right to complete!'),
    ToDo('Swipe to the left to delete'),
    ToDo('Tap and hold to pick me up'),
    ToDo('Pull down to create an item'),
    ToDo('Try shaking to undo'),
    ToDo('Try pinching two rows apart'),
    ToDo('Try pinching vertically shut'),
    ToDo('Pull up to clear')
  ];

  List<ToDo> get defaultToDos => _defaultToDos;

  markItemComplete(ToDo item) {
    ToDo toDo = defaultToDos.elementAt(defaultToDos.indexOf(item));
    toDo.isComplete = true;
    defaultToDos.remove(toDo);
    defaultToDos.add(ToDo.copy(toDo));
    notifyListeners();
  }

  markItemDelete(ToDo item) {
    defaultToDos.removeAt(defaultToDos.indexOf(item));
    notifyListeners();
  }

  takeReOrderDecision(int oldIndex,int newIndex){
    if (newIndex != oldIndex) {
      ToDo todo = defaultToDos.removeAt(oldIndex);
      if(defaultToDos.elementAt(newIndex-2).isComplete)
        todo.isComplete = true;
      defaultToDos.insert(--newIndex,todo);
      notifyListeners();
    }
  }

  markDragState(item,PointerMoveEvent event){
    //print(event.localDelta.dx);
    /*if(event.localDelta.dx >= 1){
      defaultToDos.elementAt(defaultToDos.indexOf(item)).isDragged = true;
      notifyListeners();
    }else{
      defaultToDos.elementAt(defaultToDos.indexOf(item)).isDragged = false;
      notifyListeners();
    }*/
  }
}
