import 'package:flutter/material.dart';
import 'package:my_app/components/asset_image_widget.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int _count = 0;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  void _decrement() {
    if (_count > 0) {
      setState(() {
        _count--;
      });
    }
  }

  // String _cekGenap() {
  //   if (_count % 2 == 0) {
  //     return 'Genap';
  //   } else {
  //     return 'Ganjil';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Column(
            children: [
              AssetImageWidget(
                  imagePath: 'assets/image/icon_flutter.png',
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover),
            ],
          ),
          const Divider(),
          const SizedBox(height: 10), // Penambahan SizedBox untuk jarak
          const Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 10), // Menyesuaikan jarak kanan dan kiri
            child: Row(
              children: [
                Text('Lorem Ipsum is simply dummy text of the printing')
              ],
            ),
          ),
          const SizedBox(height: 10), // Penambahan SizedBox untuk jarak
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // ignore: prefer_const_constructors,
              IconButton(
                  onPressed: _increment, icon: const Icon(Icons.thumb_up)),
              IconButton(
                  onPressed: _decrement, icon: const Icon(Icons.thumb_down)),
              Text(
                '$_count Likes',
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
