import 'package:dio/dio.dart';
import 'package:memories_app/src/models/base_response_header.dart';
import 'package:memories_app/src/models/memories_request.dart';
import 'package:memories_app/src/models/memories_response.dart';
import 'package:memories_app/src/models/memory.dart';

class MemoriesApiProvider {
  Future<MemoriesResponse> fetchMemoriesAround(
      MemoriesRequest memoriesRequest) async {
    return MemoriesResponse(
        responseHeader: BaseResponseHeader(
            type: "Fetch_memories_around_me",
            message: "Successfully found lanterns",
            status: "200"),
        memoriesAround: [
          Memory(
              title: "cityName",
              distance: "12 km",
              penName:
                  "lat: ${memoriesRequest.lanternsAround.latitude}, lon: ${memoriesRequest.lanternsAround.longitude}",
              description: "Test test"),
          Memory(
              title: "cityName",
              distance: "3 km",
              penName:
                  "lat: ${memoriesRequest.lanternsAround.latitude}, lon: ${memoriesRequest.lanternsAround.longitude}",
              description: "Test test"),
          Memory(
              title: "cityName",
              distance: "10 km",
              penName:
                  "lat: ${memoriesRequest.lanternsAround.latitude}, lon: ${memoriesRequest.lanternsAround.longitude}",
              description: "Test test"),
          Memory(
              title: "cityName",
              distance: "2 km",
              penName:
                  "lat: ${memoriesRequest.lanternsAround.latitude}, lon: ${memoriesRequest.lanternsAround.longitude}",
              description: "Test test"),
        ]);
  }
}
