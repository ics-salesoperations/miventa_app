import 'package:dio/dio.dart';

const accessToken =
    'pk.eyJ1Ijoiam9zdWVtbDI0IiwiYSI6ImNsMWk4Ym0xeDFzNWozYnM5ZzF4aWRldGoifQ.fLsGba35SNiBdJcseT39jw';

class PlacesInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters
        .addAll({'country': 'hn', 'access_token': accessToken});

    super.onRequest(options, handler);
  }
}
