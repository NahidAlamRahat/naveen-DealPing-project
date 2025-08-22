Future<List<ChatMessageResponseModel>> getBusinessChatMessage({
  required int page,
  required String chatId,
  required String status,
}) async {
  List<ChatMessageResponseModel> chatMessageResponseModelList = [];

  try {
    // ✅ Build query parameters properly
    Map<String, dynamic> queryParameters = {
      "page": page,
      "limit": 20,
    };

    appLog('Current page: $page');
    appLog('Chat ID: $chatId');
    appLog('Status: $status');

    // ✅ Fixed URL construction
    String url = "${ApiUrls.baseUrl}/message/$chatId";

    appLog("getChatMessage URL: $url");
    appLog("Query params: $queryParameters");

    // ✅ Pass status as query parameter instead of URL parameter
    queryParameters['status'] = status;

    var response = await apiServices.apiGetServices(
      url,
      queryParameters: queryParameters,
    );

    appLog("Response: $response");

    if (response != null) {
      // ✅ Handle different response structures
      List<dynamic> messageData = [];

      if (response["data"] != null) {
        if (response["data"] is List) {
          // Direct array response
          messageData = response["data"];
        } else if (response["data"] is Map) {
          // Nested data structure
          var data = response["data"];
          if (data["data"] != null && data["data"] is List) {
            messageData = data["data"];
          }
        }
      }

      appLog("Found ${messageData.length} messages");

      for (var item in messageData) {
        if (item is Map<String, dynamic>) {
          try {
            chatMessageResponseModelList.add(
                ChatMessageResponseModel.fromJson(item)
            );
          } catch (e) {
            errorLog('Error parsing message item: $e');
            appLog('Problematic item: $item');
          }
        }
      }

      appLog("Successfully parsed ${chatMessageResponseModelList.length} messages");
    } else {
      errorLog('Response is null');
    }
  } catch (e) {
    errorLog('getChatMessage error: $e');
  }

  return chatMessageResponseModelList;
}