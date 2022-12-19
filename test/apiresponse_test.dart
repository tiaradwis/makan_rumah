// import 'package:app_restaurant/data/model/detail_restaurant.dart';
// import 'package:app_restaurant/provider/restaurantDetail_provider.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:app_restaurant/data/api/api_service.dart';
// import 'package:http/http.dart' as http;

// class MockClient extends Mock with http.Client {}

// void Main() {
//   test(
//     'for Restaurant Detail when restaurant id is found',
//     () async {
//       final client = MockClient(
//         (request) async {
//           final response = {
//             "error": false,
//             "message": "success",
//             "restaurant": {
//               "id": "",
//               "name": "",
//               "description": "",
//               "city": "",
//               "address": "",
//               "pictureId": "",
//               "categories": [],
//               "menus": {"foods": [], "drinks": []},
//               "rating": 1.0,
//               "customerReviews": []
//             }
//           };
//           return Response(json.encode(response), 200);
//         },
//       );

//       expect(
//           await ApiService().detailRestaurant('Restaurant Id Example', client),
//           isA<DetailRestaurant>());
//     },
//   );
// }
