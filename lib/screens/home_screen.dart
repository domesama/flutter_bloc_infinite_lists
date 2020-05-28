import 'package:crytocurrecy_with_bloc/blocs/crypto/crypto_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import '../repositories/crypto_repository.dart';
// import '../models/coin_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Coins'),
      ),
      body: BlocBuilder<CryptoBloc, CryptoState>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Theme.of(context).primaryColor, Colors.pinkAccent]),
            ),
            child: _buildBody(state),
          );
        },
      ),
    );
  }

  _buildBody(CryptoState state) {
    if (state is CryptoLoading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor),
        ),
      );
    } else if (state is CryptoLoaded) {
      return RefreshIndicator(
        color: Colors.teal,
        onRefresh: () async {
          context.bloc<CryptoBloc>().add(RefreshCoins());
        },
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) =>
              _onScrollNotification(notification, state),
          child: ListView.builder(
            controller: _scrollController,
            itemCount: state.coins.length,
            itemBuilder: (BuildContext context, int index) {
              //We can update the state via state.coins now
              final coin = state.coins[index];
              return ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('${++index}',
                        style: TextStyle(
                            color: Colors.tealAccent,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                title: Text(
                  coin.fullName,
                  style: TextStyle(color: Colors.tealAccent),
                ),
                subtitle: Text(
                  coin.name,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w300),
                ),
                trailing: Text(
                  '\$${coin.price.toStringAsFixed(4)}',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              );
            },
          ),
        ),
      );
    } else if (state is CryptoError) {
      return Center(
        child: Text(
          'Error loading dem coins!\n Pls check ur internet connection and ur potato PC',
          style: TextStyle(color: Colors.tealAccent),
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  bool _onScrollNotification(ScrollNotification noti, CryptoLoaded state) {
    //Make sure that we write CryptoLoaded to access state.coins and many other important properties in the future
    if (noti is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      context.bloc<CryptoBloc>().add(LoadMoreCoins(coins: state.coins));
    }
    return false;
  }
}

// FutureBuilder(
//         future: _cryptoRespository.getTopCoins(page: _page),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return Center(
//               child: CircularProgressIndicator(
//                 valueColor:
//                     AlwaysStoppedAnimation(Theme.of(context).accentColor),
//               ),
//             );
//           }
//           final List<Coin> coins = snapshot.data;
//           return RefreshIndicator(
//             color: Colors.teal,
//             onRefresh: (() async {
//               setState(() => _page = 0);
//             }),
//             child: ListView.builder(
//                 itemCount: coins.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   final coin = coins[index];
//                   return ListTile(
//                     leading: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Text('${++index}',
//                             style: TextStyle(
//                                 color: Colors.tealAccent,
//                                 fontWeight: FontWeight.bold)),
//                       ],
//                     ),
//                     title: Text(
//                       coin.fullName,
//                       style: TextStyle(color: Colors.tealAccent),
//                     ),
//                     subtitle: Text(
//                       coin.name,
//                       style: TextStyle(
//                           color: Colors.white, fontWeight: FontWeight.w300),
//                     ),
//                     trailing: Text(
//                       '\$${coin.price.toStringAsFixed(4)}',
//                       style: TextStyle(
//                           color: Colors.white, fontWeight: FontWeight.w600),
//                     ),
//                   );
//                 }),
//           );
