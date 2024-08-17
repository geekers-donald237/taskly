import 'package:taskly/data/models/task_model.dart';
import 'package:taskly/data/sources/local/data_provider.dart';
import 'package:taskly/domain/repositories/task_repository.dart';

class TaskRepositoryImpl extends TaskRepository {
  final TaskDataLocalStorageProvider taskDataProvider;

  TaskRepositoryImpl({required this.taskDataProvider});

  Future<List<TaskModel>> getTasks() async {
    return await taskDataProvider.getTasks();
  }

  Future<void> createNewTask(TaskModel taskModel) async {
    return await taskDataProvider.createTask(taskModel);
  }

  Future<List<TaskModel>> updateTask(TaskModel taskModel) async {
    return await taskDataProvider.updateTask(taskModel);
  }

  Future<List<TaskModel>> deleteTask(TaskModel taskModel) async {
    return await taskDataProvider.deleteTask(taskModel);
  }

  Future<List<TaskModel>> sortTasks(int sortOption) async {
    return await taskDataProvider.sortTasks(sortOption);
  }

  Future<List<TaskModel>> searchTasks(String search) async {
    return await taskDataProvider.searchTasks(search);
  }

}