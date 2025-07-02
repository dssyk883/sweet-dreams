import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'api.g.dart';

// If you're using LOCALHOST for the node server and Android emulator, ONLY CHANGE PORT #.
// Android emulator uses the 10.0.2.2 address to connect to your computer's localhost.
// IOS Emulator/Physical and Android Physical will be different.
//@RestApi(baseUrl: "http://10.0.2.2:3000/")

@RestApi(baseUrl: "https://api.sixyoungpeople.com/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/getAll")
  Future<List<Collection>> getAll();

  @POST("/getAllDetails")
  Future<List<Collection>> getAllDetails(@Body() Map<String, String> userID);

  @POST("/getRecentDetails")
  Future<List<Collection>> getRecentDetails(@Body() Map<String, String> userID);

  @POST("/insertSleepDetails")
  Future<String> insertSleepDetails(@Body () Map<String, dynamic> object);

  @POST("/findDetailsOnDate")
  Future<List<Collection>> findDetailsOnDate(@Body () Map<String, String> object);

  @POST("/updateSleepDetails")
  Future<String> updateSleepDetails(@Body () Map<String, dynamic> object);
}

@JsonSerializable()
class Collection {
  @JsonKey(name: '_id')
  String userID;
  List<String> sleepNotes;
  List<String> dreamNotes;
  String sleepQuality;
  String sleepTime;
  String wakeupTime;

  Collection({required this.userID, required this.sleepTime, required this.wakeupTime, required this.sleepQuality,
    required this.sleepNotes, required this.dreamNotes});
  factory Collection.fromJson(Map<String, dynamic> json) => _$CollectionFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionToJson(this);
}