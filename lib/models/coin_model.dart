import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Coin extends Equatable {
  final String name; //BTC
  final String fullName; //Bitcoin
  final double price;

  const Coin(
      {@required this.name, @required this.fullName, @required this.price});

  @override
  List<Object> get props => [
        name,
        fullName,
        price,
      ];
  //coin1 == coin2 , no need to coin1.name == coin2.name

  @override
  String toString() =>
      'Coun {name: $name, fullName: $fullName, price: $price }';

  factory Coin.formJson(Map<String, dynamic> json) {
    return Coin(
      name: json['CoinInfo']['Name'] as String,
      fullName: json['CoinInfo']['FullName'] as String,
      price: (json['RAW']['USD']['PRICE'] as num).toDouble(),
    );
    //These are from the BitCoin API JSON data object, pls refer to that...
  }
}
