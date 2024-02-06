import 'package:dictionary_flutter/app/modules/login/controllers/auth_controller.dart';
import 'package:dictionary_flutter/app/network/api.dart';
import 'package:dictionary_flutter/app/routes/app_routes.dart';
import 'package:dictionary_flutter/app/routes/router_delegate.dart';
import 'package:dictionary_flutter/common/values/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/response_model.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool _inProgress = false;
  DictionaryResponseModel? responseModel;
  String noDataText = DictionaryStrings.welcomeStartSearching;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchWidget(),
              const SizedBox(height: 12),
              if (_inProgress)
                const LinearProgressIndicator()
              else if (responseModel != null)
                Expanded(child: _buildResponseWidget())
              else
                _noDataWidget(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Text('Logout'),
          onPressed: () {
            ref.read(authProvider.notifier).logout();
            FDRouterDelegate.instance.push(FlutterDicRoutePath.splash());
          },
        ),
      )),
    );
  }

  Widget _buildResponseWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          responseModel!.word!,
          style: TextStyle(
            color: Colors.purple.shade600,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        Text(responseModel!.phonetic ?? ""),
        const SizedBox(height: 16),
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) {
            return _buildMeaningWidget(responseModel!.meanings![index]);
          },
          itemCount: responseModel!.meanings!.length,
        ))
      ],
    );
  }

  Widget _buildMeaningWidget(Meanings meanings) {
    String definitionList = "";
    meanings.definitions?.forEach(
      (element) {
        int index = meanings.definitions!.indexOf(element);
        definitionList += "\n${index + 1}. ${element.definition}\n";
      },
    );

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              meanings.partOfSpeech!,
              style: TextStyle(
                color: Colors.orange.shade600,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Definitions : ",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(definitionList),
            _buildSet("Synonyms", meanings.synonyms),
            _buildSet("Antonyms", meanings.antonyms),
          ],
        ),
      ),
    );
  }

  Widget _buildSet(String title, List<String>? setList) {
    if (setList?.isNotEmpty ?? false) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title : ",
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(setList!.toSet().toString().replaceAll("{", "").replaceAll("}", "")),
          const SizedBox(height: 10),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _noDataWidget() {
    double deviveHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: deviveHeight * 1 / 3,
      child: Center(
        child: Text(
          noDataText,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget _buildSearchWidget() {
    return SearchBar(
      hintText: "Please enter the word to look up",
      onSubmitted: (value) {
        _getMeaningFromApi(value);
      },
    );
  }

  _getMeaningFromApi(String word) async {
    setState(() {
      _inProgress = true;
    });
    try {
      responseModel = await API.fetchMeaning(word);
      setState(() {});
    } catch (e) {
      responseModel = null;
      noDataText = DictionaryStrings.meaningCanNotBeFetched;
    } finally {
      setState(() {
        _inProgress = false;
      });
    }
  }
}
