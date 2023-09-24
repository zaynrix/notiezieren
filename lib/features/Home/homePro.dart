import 'package:flutter/material.dart';
import 'package:notienziert/interceptors/di.dart';
import 'package:notienziert/models/taskModel.dart';
import 'package:notienziert/repository/home_repo/task_repo.dart';
import 'package:notienziert/resources/color_manager.dart';
import 'package:notienziert/routing/navigation.dart';
import 'package:notienziert/shared/widgets/CustomeBottomSheet.dart';
import 'package:notienziert/utils/appConfig.dart';

class HomeProvider extends ChangeNotifier {
  //
  int? id = 0;
  bool? init;
  bool loading = false;

  //
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController noteTitle = TextEditingController();
  GlobalKey<ScaffoldState> ScaffoldKeySheet = GlobalKey();
  GlobalKey<ScaffoldState> ScaffoldKeySheet1 = GlobalKey();

  //
  List<Data>? tasks = [];

  // ------------------ change Loader ------------------

  changeLoader(value) {
    loading = value;
    notifyListeners();
  }

  // ------------------ change init ------------------

  changeInit(value) {
    init = value;
    notifyListeners();
  }

  // ------------------ Get Tasks ------------------

  Future getHome() async {
    init = false;
    TaskModel taskModel = await sl<HomeRepository>().getTasks();
    tasks = taskModel.data;
    notifyListeners();
    if (tasks!.isEmpty) {
      init = true;
    }
  }

  // ------------------ Add Task ------------------

  Future addTask() async {
    if (formKey.currentState!.validate()) {
      TaskModel taskModel = await sl<HomeRepository>().addTask(noteTitle.text);
      tasks!.add(taskModel.singleData!);
      notifyListeners();
      noteTitle.clear();
      // sl<NavigationService>().pop();
      sl<NavigationService>().pop();
      resetNote();
    }
  }

  // ------------------ Delete Task ------------------

  Future deleteTask() async {
    TaskModel taskModel = await sl<HomeRepository>().deleteTask(id!);
    if (taskModel.status!) {
      tasks!.removeWhere((i) => i.id == id);
      getHome();
      notifyListeners();
    } else {
      AppConfig.showSnakBar("${taskModel.message}", Success: false);
    }
    resetNote();
  }

  // ------------------ Update Task ------------------

  Future updateTask() async {
    TaskModel taskModel =
        await sl<HomeRepository>().updateTask(id!, noteTitle.text);
    if (taskModel.status == true) {
      getHome();
      notifyListeners();
      noteTitle.clear();
    }
    resetNote();
    init = false;
    sl<NavigationService>().pop();
    notifyListeners();
  }

  // ------------------ Refresh Task ------------------

  refresh() async {
    tasks!.clear();
    getHome();
    notifyListeners();
  }

  // ------------------ Reset Note ------------------

  resetNote() async {
    id = 0;
    noteTitle.clear();
    notifyListeners();
  }

  // ------------------ Initial Note ------------------

  initialNote() async {
    id;
    noteTitle;
    notifyListeners();
  }

  // ------------------ Show Language Sheet ------------------

  noteBottomSheet(GlobalKey ScaffoldKeySheet) {
    id == 0 ? resetNote() : initialNote();
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: ColorManager.darkGrey,
      context: ScaffoldKeySheet.currentContext!,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: BottomSheetNote(),
      ),
    );
  }
}
