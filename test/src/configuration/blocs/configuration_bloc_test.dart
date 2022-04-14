import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_queue/src/configuration/blocs/configuration_bloc.dart';
import 'package:flutter_queue/src/configuration/events/conf_event.dart';
import 'package:flutter_queue/src/configuration/states/conf_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';

void main() {
  final entity = QueueEntityMock();

  late IGetAllQueuesMock getAll;
  late IRemoveQueueMock remove;
  late IAddNewQueueMock addNew;
  late IRemoveAllOrdersMock removeAllOrders;
  late ConfigurationBloc bloc;

  setUp(() {
    getAll = IGetAllQueuesMock();
    remove = IRemoveQueueMock();
    addNew = IAddNewQueueMock();
    addNew = IAddNewQueueMock();
    removeAllOrders = IRemoveAllOrdersMock();
    bloc = ConfigurationBloc(getAll, addNew, remove, removeAllOrders);
  });

  blocTest<ConfigurationBloc, ConfigurationState>(
    'FetchQueues',
    build: () {
      when(() => getAll.call()).thenAnswer((_) => Stream.value([]));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchQueues()),
    expect: () => [
      isA<LoadingConfigurationState>(),
      isA<LoadedConfigurationState>(),
    ],
  );
  blocTest<ConfigurationBloc, ConfigurationState>(
    'FetchQueues with error',
    build: () {
      when(() => getAll.call()).thenAnswer((_) => Stream.error(Exception('Error')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchQueues()),
    expect: () => [
      isA<LoadingConfigurationState>(),
      isA<ExceptionConfigurationState>(),
    ],
  );
  blocTest<ConfigurationBloc, ConfigurationState>(
    'AddNewQueueEvent',
    build: () {
      when(() => addNew.call(entity)).thenAnswer((_) => Future.value());

      return bloc;
    },
    act: (bloc) => bloc.add(AddNewQueueEvent(entity)),
    expect: () => [],
  );
  blocTest<ConfigurationBloc, ConfigurationState>(
    'RemoveQueueEvent',
    build: () {
      when(() => remove.call(entity)).thenAnswer((_) => Future.value());

      return bloc;
    },
    act: (bloc) => bloc.add(RemoveQueueEvent(entity)),
    expect: () => [],
  );
}
