import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_queue/src/configuration/blocs/configuration_bloc.dart';
import 'package:flutter_queue/src/configuration/events/conf_event.dart';
import 'package:flutter_queue/src/configuration/states/conf_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';

void main() {
  blocTest<ConfigurationBloc, ConfigurationState>(
    'conf bloc ...',
    build: () {
      final usecase = IGetAllQueuesMock();
      when(() => usecase.call()).thenAnswer((_) => Stream.value([]));
      return ConfigurationBloc(usecase);
    },
    act: (bloc) => bloc.add(FetchQueues()),
    expect: () => [
      isA<LoadingConfigurationState>(),
      isA<LoadedConfigurationState>(),
    ],
  );
}
