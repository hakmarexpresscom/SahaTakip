import 'dart:math';
import 'package:vector_math/vector_math.dart';

double getDistance(double targetLat, double targetLong, double currentLat, double currentLong){
  var dLat = radians(targetLat - currentLat);
  var dLng = radians(targetLong - currentLong);
  var a = sin(dLat/2) * sin(dLat/2) + cos(radians(currentLat))
      * cos(radians(targetLat)) * sin(dLng/2) * sin(dLng/2);
  var c = 2 * atan2(sqrt(a), sqrt(1-a));
  var d = 6371000 * c;
  return d; //d is the distance in meters
}
