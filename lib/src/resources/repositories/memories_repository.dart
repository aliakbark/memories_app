import 'dart:math';

import 'package:memories_app/src/models/base_request_header.dart';
import 'package:memories_app/src/models/base_response_header.dart';
import 'package:memories_app/src/models/memories_request.dart';
import 'package:memories_app/src/models/memories_response.dart';
import 'package:memories_app/src/models/memory.dart';
import 'package:memories_app/src/resources/remote/memories_api_provider.dart';

abstract class MemoriesRepository {
  Future<MemoriesResponse> fetchMemoriesAround(
      {required String latitude, required String longitude});
}

class FakeMemoryRepository implements MemoriesRepository {
  final _memoriesApiProvider = MemoriesApiProvider();

  @override
  Future<MemoriesResponse> fetchMemoriesAround(
      {required String latitude, required String longitude}) {
    // Simulate network delay
    return Future.delayed(
      const Duration(seconds: 1),
      () {
        final random = Random();

        // Simulate some network exception
        // if (random.nextBool()) {
        //   throw NetworkException();
        // }

        return _memoriesApiProvider
            .fetchMemoriesAround(MemoriesRequest(
                requestHeader:
                    BaseRequestHeader(type: "Fetch_memories_around_me"),
                lanternsAround:
                    LanternsAround(latitude: latitude, longitude: longitude)))
            .then((res) {
          if (res.responseHeader?.status != "200") {
            throw NetworkException();
          }
          return res;
        });
      },
    );
  }
}

class NetworkException implements Exception {}
