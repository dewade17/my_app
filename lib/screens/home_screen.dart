import 'package:flutter/material.dart';
import 'package:my_app/components/asset_image_widget.dart';
import 'package:my_app/components/text_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [
        Row(
          children: [Text('Text1'), Text('Text2'), Text('Text 3')],
        ),
        Card(
          color: Colors.amber,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          borderOnForeground: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('test'), Text('test')],
          ),
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(children: [Text('Test 1'), Text('Test 2')]),
            Column(children: [Text('Test 1'), Text('Test 2')])
          ],
        ),
        Divider(),
        Card(
          // ... other card properties like child, margin, etc.
          child: Padding(
              padding: EdgeInsets.all(40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Test 1'), Text('Test 2')],
              )),
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('hello world'),
            Text('hello world 2'),
          ],
        ),
        Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Eka'), Text('Suwidia')],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextContainer(
              text: 'Column 1',
              color: Colors.red,
              key: ValueKey(1),
            ),
            TextContainer(
                text: 'Column 2', color: Colors.green, key: ValueKey(2)),
            TextContainer(
                text: 'Column 3', color: Colors.blue, key: ValueKey(3)),
          ],
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AssetImageWidget(
              imagePath: 'assets/image/icon_flutter.png',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            AssetImageWidget(
              imagePath: 'assets/image/icon_flutter.png',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ],
        )
      ],
    ));
  }
}
