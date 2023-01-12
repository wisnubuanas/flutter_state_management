import 'package:flutter_state_management/color_shared_state.dart';
import 'package:flutter_state_management/keranjang_shared_state.dart';
import 'package:flutter_state_management/saldo_shared_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProviderExample(),
    );
  }
}

class MultiProviderExample extends StatefulWidget {
  const MultiProviderExample({super.key});

  @override
  State<MultiProviderExample> createState() => _MultiProviderExampleState();
}

class _MultiProviderExampleState extends State<MultiProviderExample> {
  TextStyle myTextStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w500);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ColorState(),
        ),
        ChangeNotifierProvider(create: (context) => SaldoState()),
        ChangeNotifierProvider(
          create: (context) => KeranjangState(),
        )
      ],
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.black,
            centerTitle: true,
            title: Consumer<ColorState>(
              builder: (context, colorstate, child) => Text(
                "Toko Sumber Rejeki",
                // style: TextStyle(color: colorstate.getColor),
              ),
            )),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Saldo"),
              SizedBox(
                height: 10,
              ),
              Consumer<ColorState>(
                  builder: (context, colorstate, child) => Consumer<SaldoState>(
                        builder: (context, saldostate, child) => Container(
                          height: 30,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: colorstate.getColor),
                          child: Center(
                            child: Text(
                              "${saldostate.getSaldo}",
                              style: myTextStyle,
                            ),
                          ),
                        ),
                      )),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Green"),
                  Consumer<ColorState>(
                    builder: (context, colorstate, child) => Switch(
                        value: colorstate.getIsOrange,
                        onChanged: ((value) {
                          colorstate.setColor = value;
                        })),
                  ),
                  Text("Maroon")
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Consumer<ColorState>(
                builder: (context, colorstate, child) =>
                    Consumer<KeranjangState>(
                  builder: (context, keranjangstate, child) => Card(
                    color: colorstate.getColor,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Permen (500) x ${keranjangstate.getQty}",
                            style: myTextStyle,
                          ),
                          Text(
                            "${keranjangstate.getQty * 500}",
                            style: myTextStyle,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    // margin: EdgeInsets.all(40),
                    // color: Colors.green,
                    padding: EdgeInsets.only(top: 230, left: 30),
                    child: Consumer3<ColorState, SaldoState, KeranjangState>(
                      builder: (context, colorstate, saldostate, keranjangstate,
                              child) =>
                          IconButton(
                              onPressed: () {
                                if (saldostate.getSaldo < 10000) {
                                  saldostate.tambahSaldo(500);
                                  keranjangstate.kurangkeranjang();
                                }
                              },
                              color: colorstate.getColor,
                              icon: Icon(Icons.undo)),
                    ),
                  )
                ],
              )
            ],
          ),
        ),

        floatingActionButton: Consumer3<ColorState, SaldoState, KeranjangState>(
          builder: (context, colorstate, saldostate, keranjangstate, child) =>
              FloatingActionButton(
            backgroundColor: colorstate.getColor,
            onPressed: () {
              if (saldostate.getSaldo > 0) {
                saldostate.kurangiSaldo(500);
                keranjangstate.tambahkeranjang();
              }
            },
            child: Icon(Icons.shopping_cart_outlined),
          ),
        ),

        // floatingActionButton: Consumer<ColorState>(
        //     builder: (context, colorstate, child) => Consumer<SaldoState>(
        //         builder: (context, saldostate, child) =>
        //             Consumer<KeranjangState>(
        //               builder: (context, keranjangstate, child) =>
        //                   FloatingActionButton(
        //                 backgroundColor: colorstate.getColor,
        //                 onPressed: () {
        //                   if (saldostate.getSaldo > 0) {
        //                     saldostate.kurangiSaldo(500);
        //                     keranjangstate.tambahkeranjang();
        //                   }
        //                 },
        //                 child: Icon(Icons.shopping_cart_outlined),
        //               ),
        //             ))),
      ),
    );
  }
}

// class ProviderExample extends StatefulWidget {
//   const ProviderExample({super.key});

//   @override
//   State<ProviderExample> createState() => _ProviderExampleState();
// }

// class _ProviderExampleState extends State<ProviderExample> {
//   TextStyle myTextStyle =
//       TextStyle(color: Colors.white, fontWeight: FontWeight.w500);
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<ColorState>(
//       create: (context) => ColorState(),
//       child: Scaffold(
//         appBar: AppBar(
//             elevation: 0,
//             backgroundColor: Colors.grey[900],
//             title: Consumer<ColorState>(
//               builder: (context, colorstate, child) => Text(
//                 "State Management",
//                 style: TextStyle(color: colorstate.getColor),
//               ),
//             )),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text("Belanja"),
//               SizedBox(
//                 height: 10,
//               ),
//               Consumer<ColorState>(
//                 builder: (context, colorstate, child) => Container(
//                   height: 150,
//                   width: 150,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       color: colorstate.getColor),
//                   child: Center(
//                     child: Text(
//                       "10000",
//                       style: myTextStyle,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("DeepPurple"),
//                   Consumer<ColorState>(
//                     builder: (context, colorstate, child) => Switch(
//                         value: colorstate.getIsOrange,
//                         onChanged: ((value) {
//                           colorstate.setColor = value;
//                         })),
//                   ),
//                   Text("DeepOrange")
//                 ],
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Consumer<ColorState>(
//                 builder: (context, colorstate, child) => Card(
//                   color: colorstate.getColor,
//                   child: Container(
//                     width: MediaQuery.of(context).size.width * 0.8,
//                     height: 50,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Text(
//                           "Telur (500) x 0",
//                           style: myTextStyle,
//                         ),
//                         Text(
//                           "0",
//                           style: myTextStyle,
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         floatingActionButton: Consumer<ColorState>(
//           builder: (context, colorstate, child) => FloatingActionButton(
//             backgroundColor: colorstate.getColor,
//             onPressed: () {},
//             child: Icon(Icons.shopping_cart_outlined),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_state_management/color_shared_state.dart';
// import 'package:provider/provider.dart';

// void main() {
//   runApp(StateExample());
// }

// class StateExample extends StatefulWidget {
//   const StateExample({super.key});

//   @override
//   State<StateExample> createState() => _StateExampleState();
// }

// class _StateExampleState extends State<StateExample> {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<ColorState>(
//       create: (context) => ColorState(),
//       child: MaterialApp(
//         home: Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.grey[900],
//             title: Consumer<ColorState>(
//               builder: (context, colorstate, child) => Text(
//                 "State Management",
//                 style: TextStyle(color: colorstate.getColor),
//               ),
//             ),
//           ),
//           body: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("Text Tidak Berganti"),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Consumer<ColorState>(
//                   builder: (context, colorstate, child) => Container(
//                     height: 150,
//                     width: 150,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         color: colorstate.getColor),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text("DeepPurple"),
//                     Consumer<ColorState>(
//                       builder: (context, colorstate, child) => Switch(
//                           value: colorstate.getIsOrange,
//                           onChanged: ((value) {
//                             colorstate.setColor = value;
//                           })),
//                     ),
//                     Text("DeepOrange")
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
