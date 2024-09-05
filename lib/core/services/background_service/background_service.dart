import 'package:background_fetch/background_fetch.dart';
import 'package:unicode/modules/categories/repositories/categories_repository.dart';
import 'package:unicode/modules/todos/repositories/todos_repository.dart';

class BackgroundService {
  final CategoriesRepository _categoriesRepository;
  final TodosRepository _todosRepository;

  BackgroundService(this._categoriesRepository, this._todosRepository);

  void configure() async {
    await BackgroundFetch.configure(
      BackgroundFetchConfig(
        minimumFetchInterval: 360,
        stopOnTerminate: false,
        enableHeadless: true,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresStorageNotLow: false,
        requiresDeviceIdle: false,
        requiredNetworkType: NetworkType.NONE,
      ),
      (taskId) async {
        await _categoriesRepository.synchronizeCategories();
        await _todosRepository.synchronizeTodos();
        BackgroundFetch.finish(taskId);
      },
      backgroundFetchHeadlessTask,
    );
  }

  void backgroundFetchHeadlessTask(HeadlessTask task) async {
    String taskId = task.taskId;
    bool isTimeout = task.timeout;
    if (!isTimeout) {
      await _categoriesRepository.synchronizeCategories();
      await _todosRepository.synchronizeTodos();
    }
    BackgroundFetch.finish(taskId);
  }
}
