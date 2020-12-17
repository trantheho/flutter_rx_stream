abstract class BaseResponse <T>{
  T data;

  BaseResponse(Map<String, dynamic> fullJson) {
    parsing(fullJson);
  }

  T jsonToData(Map<String, dynamic> fullJson);

  parsing(Map<String, dynamic> fullJson) {
    data = jsonToData(fullJson);
  }

}