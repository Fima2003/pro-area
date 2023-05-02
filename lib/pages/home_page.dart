import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../api/cat_facts_api.dart';
import '../logic/bloc/cat_fact_bloc.dart';
import 'history_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Facts'),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HistoryPage(),
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<CatFactBloc, CatFactState>(
        builder: (context, state) {
          if (state is CatFactInitial) {
            context.read<CatFactBloc>().add(LoadRandomCatFact());
            return _buildLoading();
          } else if (state is CatFactLoading) {
            return _buildLoading();
          } else if (state is CatFactLoaded) {
            return _buildContent(state.catFact, context);
          } else if (state is CatFactError) {
            return _buildError(state.message);
          } else {
            return _buildError('Unexpected error');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<CatFactBloc>().add(LoadRandomCatFact()),
        child: Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: SpinKitDoubleBounce(color: Colors.blue),
    );
  }

  Widget _buildContent(CatFact catFact, BuildContext context) {
    DateFormat dateFormat =
        DateFormat.yMMMMd(Localizations.localeOf(context).toString());
    String formattedDate = dateFormat.format(DateTime.parse(catFact.createdAt));
    String imageUrl =
        'https://cataas.com/cat?timestamp=${DateTime.now().millisecondsSinceEpoch}';

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                catFact.text,
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Fact created on: $formattedDate',
                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Text(
        message,
        style: TextStyle(color: Colors.red, fontSize: 18),
      ),
    );
  }
}
