import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListScreen extends StatelessWidget {
  final String apiUrl =
      'https://mockjson-co.herokuapp.com/bin/623d6c2c25314e00260c31f9';

  Future<List<dynamic>> fetchHotels() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }

  String _name(dynamic user) {
    return user['name'];
  }

  String _address(dynamic user) {
    return user['address'];
  }

  String _imgPath(dynamic user) {
    return user['imageUrl'];
  }

  int _rate(dynamic user) {
    return user['reviews'][0]['rate'];
  }

  int _price(dynamic user) {
    return user['price'];
  }

  const ListScreen({Key? key}) : super(key: key);

  static const String path = '/list';
  static const String name = 'list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Page"),
      ),
      body: SizedBox(
        width: 500.0,
        height: 800.0,
        child: FutureBuilder<List<dynamic>>(
          future: fetchHotels(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListItemBox(
                    name: _name(snapshot.data[index]),
                    imgPath: _imgPath(snapshot.data[index]),
                    address: _address(snapshot.data[index]),
                    rating: _rate(snapshot.data[index]),
                    price: _price(snapshot.data[index]),
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class ListItemBox extends StatelessWidget {
  const ListItemBox({
    required this.name,
    required this.imgPath,
    required this.address,
    required this.rating,
    required this.price,
    Key? key,
  }) : super(key: key);

  final String name;
  final String imgPath;
  final String address;
  final int rating;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
      child: Container(
        width: 400.0,
        height: 150.0,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ItemImage(imgPath: imgPath),
            const SizedBox(width: 4.0),
            ItemDetails(
              name: name,
              address: address,
              rating: rating,
              price: price,
            )
          ],
        ),
      ),
    );
  }
}

class ItemDetails extends StatelessWidget {
  const ItemDetails({
    Key? key,
    required this.name,
    required this.address,
    required this.rating,
    required this.price,
  }) : super(key: key);

  final String name;
  final String address;
  final int rating;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        ItemName(name: name, address: address),
        RatingStars(rating: rating),
        PriceDetails(price: price)
      ],
    );
  }
}

class ItemImage extends StatelessWidget {
  const ItemImage({
    Key? key,
    required this.imgPath,
  }) : super(key: key);

  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      height: 150.0,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          image:
              DecorationImage(image: NetworkImage(imgPath), fit: BoxFit.cover)),
    );
  }
}

class ItemName extends StatelessWidget {
  const ItemName({
    Key? key,
    required this.name,
    required this.address,
  }) : super(key: key);

  final String name;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
              fontSize: 17.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5.0),
        ItemAddress(address: address),
      ],
    );
  }
}

class ItemAddress extends StatelessWidget {
  const ItemAddress({
    Key? key,
    required this.address,
  }) : super(key: key);

  final String address;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 175.0,
      child: Text(
        address,
        textAlign: TextAlign.left,
        style: const TextStyle(color: Colors.grey, fontSize: 12.0),
      ),
    );
  }
}

class RatingStars extends StatelessWidget {
  const RatingStars({
    Key? key,
    required this.rating,
  }) : super(key: key);

  final int rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 10,
          width: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: rating,
            itemBuilder: (_, __) => Icon(
              Icons.star,
              color: Colors.orange[100],
              size: 15,
            ),
          ),
        ),
      ],
    );
  }
}

class PriceDetails extends StatelessWidget {
  const PriceDetails({
    Key? key,
    required this.price,
  }) : super(key: key);

  final int price;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          height: 20.0,
          width: 60.0,
          child: Center(
            child: Text(
              'Rs $price',
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(width: 35.0),
        const DetailButton()
      ],
    );
  }
}

class DetailButton extends StatelessWidget {
  const DetailButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: () {
          context.push('/list/detail');
        },
        child: const Text(
          'DETAILS',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
