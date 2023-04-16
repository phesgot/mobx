import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

part 'list_store.g.dart';

class ListStore = _ListStore with _$ListStore;

abstract class _ListStore with Store {

  _ListStore(){
    autorun((_){
      print(newTodoTitle);
    });
  }

  @observable
  String newTodoTitle = "";

  @action
  void setNewTodoTitle(String value) => newTodoTitle = value;

  @computed
  bool get isFormValid => newTodoTitle.isNotEmpty;

  ObservableList<String> todoList = ObservableList<String>();

  @action
  void addTodo(){
    todoList.add(newTodoTitle);
  }

}