import 'package:flutter_queue/src/queue/domain/usecases/add_new_queue.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mocks.dart';

void main() {
  test('deve adiciona uma nova queueEntity', () {
    final repository = QueueRepositoryMock();
    final queue = QueueEntityMock();

    when(() => repository.addQueue(queue)).thenAnswer((_) => Future.value());
    final usecase = AddNewQueue(repository);

    expect(usecase.call(queue), completes);
  });
}
