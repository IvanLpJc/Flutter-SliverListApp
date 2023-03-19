import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliver_list_app/pages/pages.dart';

class NewListPage extends StatefulWidget {
  static const route = 'newList';
  const NewListPage({Key? key}) : super(key: key);

  @override
  State<NewListPage> createState() => _NewListPageState();
}

class _NewListPageState extends State<NewListPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return (await showDialog(
              context: context,
              builder: (context) => const _CustomAlertDialog(),
            )) ??
            false;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 238, 238, 234),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _AppBar(),
                _Title(),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: _ColorSelector(),
                ),
              ],
            ),
            const Positioned(bottom: 0, right: 0, child: _NewListButton())
          ],
        ),
      ),
    );
  }
}

class _ColorSelector extends StatefulWidget {
  const _ColorSelector();

  @override
  State<_ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<_ColorSelector> {
  // create some values
  Color pickerColor = const Color(0xff443a49);

  Color currentColor = const Color(0xff443a49);

  @override
  void initState() {
    super.initState();
  }

  // ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      height: 130,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: MaterialButton(
        color: pickerColor, // Cambiar el color del widget
        height: 130,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Pick a color!'),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: pickerColor,
                  onColorChanged: changeColor,
                ),
                // Use Material color picker:
                //
                // child: MaterialPicker(
                //   pickerColor: pickerColor,
                //   onColorChanged: changeColor,
                //   showLabel: true, // only on portrait mode
                // ),
                //
                // Use Block color picker:
                //
                // child: BlockPicker(
                //   pickerColor: currentColor,
                //   onColorChanged: changeColor,
                // ),
                //
                // child: MultipleChoiceBlockPicker(
                //   pickerColors: currentColors,
                //   onColorsChanged: changeColors,
                // ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('Got it'),
                  onPressed: () {
                    setState(() => currentColor = pickerColor);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Color',
              style: TextStyle(
                  color: pickerColor.computeLuminance() > 0.5
                      ? Colors.black
                      : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Click to select a color',
              style: TextStyle(
                color: pickerColor.computeLuminance() > 0.5
                    ? Colors.black
                    : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class _ColorPicker extends StatelessWidget {
//   // create some values
//   Color pickerColor = Color(0xff443a49);
//   Color currentColor = Color(0xff443a49);
//   final Function() onPressed;

//   _ColorPicker({required this.onPressed});
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Pick a color!'),
//       content: SingleChildScrollView(
//         child: ColorPicker(
//           pickerColor: pickerColor,
//           onColorChanged: changeColor,
//         ),
//         // Use Material color picker:
//         //
//         // child: MaterialPicker(
//         //   pickerColor: pickerColor,
//         //   onColorChanged: changeColor,
//         //   showLabel: true, // only on portrait mode
//         // ),
//         //
//         // Use Block color picker:
//         //
//         // child: BlockPicker(
//         //   pickerColor: currentColor,
//         //   onColorChanged: changeColor,
//         // ),
//         //
//         // child: MultipleChoiceBlockPicker(
//         //   pickerColors: currentColors,
//         //   onColorsChanged: changeColors,
//         // ),
//       ),
//       actions: <Widget>[
//         ElevatedButton(
//           child: const Text('Got it'),
//           onPressed: () {
//             onPressed();
//             Navigator.of(context).pop();
//           },
//         ),
//       ],
//     );
//   }
// }

class _CustomAlertDialog extends StatelessWidget {
  const _CustomAlertDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: const Color.fromARGB(197, 217, 59, 48),
      title: const Text(
        'Are you sure?',
        style: TextStyle(color: Colors.white),
      ),
      content: const Text(
        "Your changes won't be saved",
        style: TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false), //<-- SEE HERE
          child: const Text(
            'No',
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          onPressed: () =>
              Navigator.popAndPushNamed(context, SliverListPage.route),
          child: const Text(
            'Yes',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          height: 170,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: MaterialButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const _CustomAlertDialog(),
              );
              //;
            },
            child: const FaIcon(
              FontAwesomeIcons.x,
              color: Color(0xffED6762),
              size: 30,
            ),
          ),
        ),
        const Text(
          'Cancel',
          style: TextStyle(
              color: Color(0xffED6762),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: const Text(
            'New',
            style: TextStyle(color: Color(0xff532128), fontSize: 50),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Stack(
            children: [
              const SizedBox(
                width: 100,
              ),
              Positioned(
                bottom: 8,
                child: Container(
                  width: 150,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xffF7CDD5),
                  ),
                ),
              ),
              const Text(
                'List',
                style: TextStyle(
                    color: Color(0xffD93A30),
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NewListButton extends StatelessWidget {
  const _NewListButton();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ButtonTheme(
      minWidth: width * 0.9,
      height: 80,
      child: MaterialButton(
        color: const Color(0xffED6762),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
        onPressed: () {},
        child: const Text(
          'CREATE NEW LIST',
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 3),
        ),
      ),
    );
  }
}
