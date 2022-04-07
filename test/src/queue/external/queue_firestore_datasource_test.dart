import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_queue/src/queue/external/queue_firestore_datasource.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('queue firestore datasource getAllQueues', () async {
    final firestore = FakeFirebaseFirestore();
    await firestore.collection('queue').add(
      {
        'id': 'dfsdfsd',
        'title': 'title',
        'priority': 1,
        'abbr': 'sd',
        'orders': [
          {
            'id': 'dfsdfsd',
            'position': 1,
            'status': 'attending',
            'timestamp': '2022-03-31 18:37:30',
          },
        ],
      },
    );

    final datasource = QueueFirestoreDatasource(firestore);

    final result = datasource.getAllQueues();

    expect(result, emits(isA<List<Map>>()));
  });

  test('deve adicionar um novo item a collection queue', () async {
    final firestore = FakeFirebaseFirestore();
    final datasource = QueueFirestoreDatasource(firestore);

    await datasource.addQueue({
      'id': 'fdfsfs',
      'title': 'novo titulo',
      'abbr': 'nt',
      'priority': 2,
    });

    final ref = firestore.collection('queue');
    final queries = await ref.get();
    expect(queries.docs.length, 1);
    expect(queries.docs.first['title'], 'novo titulo');
    expect(queries.docs.first.data().containsKey('id'), false);
  });
}
