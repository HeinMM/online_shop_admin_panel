

import 'package:one_two_one_admin/models/api_message.dart';
import 'package:one_two_one_admin/models/current_user.dart';
import 'package:one_two_one_admin/models/post_data.dart';
import 'package:one_two_one_admin/models/sale_data.dart';

import 'package:one_two_one_admin/models/staff_for_login.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'api_staff.g.dart';

@RestApi(baseUrl: "http://192.168.219.103:80/api/")
abstract class ApiStaff {
  factory ApiStaff(Dio dio, {String baseUrl}) = _ApiStaff;

  @POST("/login")
  Future<ApiMessage> login(@Body() StaffForLogin staffData);

  @POST("/logout")
  Future<ApiMessage> logout(@Body() CurrentUser currentUser);
  ///////////////////////////////////////////////////////////////////////////////////for Post
  @POST("/post")
  Future<ApiMessage> uploadPost(@Header('Authorization') String authApi,
      @Body() PostData data); //for token

  @GET("/posts")
  Stream<List<PostData>> getAllPost(@Header('Authorization') String authApi);

  @GET("/posts")
  Stream<List<PostData>> getSearchPost(@Header('Authorization') String authApi,
      @Query('search') String searchData);

  @GET("/posts")
  Stream<List<PostData>> getSearchPostByCategory(
      @Header('Authorization') String authApi,
      @Query('category') String categoryData);

  @POST("/posts/{id}")
  Future<ApiMessage> editPost(@Header('Authorization') String authApi,
      @Body() PostData data, @Path() int id);

  @GET("post/{id}")
  Future<PostData> getPostById(
      @Header('Authorization') String authApi, @Path() int id);

  @GET("posts/{id}/delete")
  Future<PostData> deletePost(
      @Header('Authorization') String authApi, @Path() int id);
///////////////////////////////////////////////////////////////////////////////////////////////for Sale
  @GET("/sales")
  Stream<List<SaleData>> getAllSalePost(
      @Header('Authorization') String authApi);
  
  @MultiPart()
  @POST("/sale")
  Future<ApiMessage> uploadSalePost(@Header('Authorization') String authApi,
      @Body() SaleData data,@Part() FormData  image);
  
  @GET("sales/{id}/delete")
  Future<SaleData> deleteSalePost(
      @Header('Authorization') String authApi, @Path() int id);

      
}
