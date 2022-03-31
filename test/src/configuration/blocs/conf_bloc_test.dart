import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_queue/src/configuration/blocs/conf_bloc.dart';
import 'package:flutter_queue/src/configuration/states/conf_state.dart';
import 'package:flutter_queue/src/queue/domain/entities/queue_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';

void main() {
  blocTest('conf bloc ...',
      build: () {
        final usecase = IGetAllQueuesMock();
        when(() => usecase.call()).thenAnswer((_) => Stream.value([]));
        return ConfBloc(usecase);
      },
      expect: () => [isA<LoadedConfState>()]);
}
