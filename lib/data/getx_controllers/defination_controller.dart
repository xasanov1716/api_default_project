import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/defination/defination_model.dart';
import '../models/universal_data.dart';
import '../network/api_service.dart';

class DefinitionController extends GetxController{
  final ApiService apiService;

  DefinitionController({required this.apiService});

  TextEditingController text = TextEditingController();


  RxList<DefinationModel> definition = <DefinationModel>[].obs;

  var errorText = ''.obs;

  var isLoading = false.obs;

  getDefinition({required String word}) async {
    isLoading.value = true;
    UniversalData universalData = await apiService.postDefination(word: word);
    isLoading.value = false;

    if (universalData.error.isEmpty) {
      definition.value = universalData.data as List<DefinationModel>;
      Get.dialog( const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Succes'),
        ],
      ));
    } else {
      errorText.value = universalData.error;
      Get.snackbar("Error", errorText.value);
    }
  }

}