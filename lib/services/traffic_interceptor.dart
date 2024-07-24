import 'package:dio/dio.dart';

const _accessToken =
    'pk.eyJ1Ijoiam9zdWVtbDI0IiwiYSI6ImNsMWk4Ym0xeDFzNWozYnM5ZzF4aWRldGoifQ.fLsGba35SNiBdJcseT39jw';

class TrafficInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline6',
      'overview': 'simplified',
      'steps': false,
      'access_token': _accessToken
    });

    super.onRequest(options, handler);
  }
}
