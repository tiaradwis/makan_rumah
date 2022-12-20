import 'package:app_restaurant/data/model/detail_restaurant.dart';
import 'package:app_restaurant/data/model/restaurant.dart';
import 'package:app_restaurant/data/model/search_restaurant.dart';
import 'package:flutter_test/flutter_test.dart';

// class MockClient extends Mock with http.Client {}

void main() {
  test(
    'for parsing Restaurant List',
    () async {
      var json = {
        "message": "success",
        "count": 2,
        "restaurants": [
          {
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description":
                "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
            "pictureId": "14",
            "city": "Medan",
            "rating": 4.2
          },
          {
            "id": "s1knt6za9kkfw1e867",
            "name": "Kafe Kita",
            "description":
                "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
            "pictureId": "25",
            "city": "Gorontalo",
            "rating": 4
          }
        ]
      };

      var result = RestaurantsResult.fromJson(json);
      expect(result.message, "success");
      expect(result.restaurants.length, result.count);
      expect(result.restaurants[0].name, "Melting Pot");
    },
  );
  test(
    'for parsing Restaurant List from search',
    () async {
      var json = {
        "error": false,
        "founded": 1,
        "restaurants": [
          {
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description":
                "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
            "pictureId": "14",
            "city": "Medan",
            "rating": 4.2
          }
        ]
      };

      var result = RestaurantSearch.fromJson(json);
      expect(result.error, false);
      expect(result.restaurants.length, result.founded);
    },
  );
  test(
    'for parsing Restaurant Detail',
    () async {
      var json = {
        "error": false,
        "message": "success",
        "restaurant": {
          "id": "tiaradwis",
          "name": "Resto Enak",
          "description": "Enak banget di sini guys",
          "city": "Sumedang",
          "address": "Jalan Tahu",
          "pictureId": "inigambar",
          "categories": [
            {"name": "Italia"},
            {"name": "Modern"}
          ],
          "menus": {
            "foods": [
              {"name": "Paket rosemary"},
              {"name": "Toastie salmon"}
            ],
            "drinks": [
              {"name": "Es krim"},
              {"name": "Sirup"}
            ]
          },
          "rating": 1.0,
          "customerReviews": [
            {"name": "tes", "review": "oke", "date": "20 Desember 2022"},
            {
              "name": "andi",
              "review": "bagus ya tempatnya",
              "date": "20 Desember 2022"
            }
          ]
        }
      };

      var result = DetailRestaurant.fromJson(json);
      expect(result.error, false);
      expect(result.message, "success");
      expect(result.restaurant.name, "Resto Enak");
    },
  );
}
