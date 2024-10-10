// To parse this JSON data, do
//
//     final authModel = authModelFromJson(jsonString);

import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  Result? result;
  AuthModel({
       this.result,
  });
  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(        
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
      );
  Map<String, dynamic> toJson() => {
              "result": result?.toJson(),
      };
}

class Result {

  UserContext? userContext;
  String? name;
  String? username;
  String? partnerDisplayName;
  int? partnerId;


 

  UserCompanies? userCompanies;
  

  Result({
    this.userContext,
    this.name,
    this.username,
    this.partnerDisplayName,
    this.partnerId,  
 
    this.userCompanies,
   
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(       
        userContext: json["user_context"] == null
            ? null
            : UserContext.fromJson(json["user_context"]),
        name: json["name"],
        username: json["username"],
        partnerDisplayName: json["partner_display_name"],
        partnerId: json["partner_id"],            
       
        userCompanies: json["user_companies"] == null
            ? null
            : UserCompanies.fromJson(json["user_companies"]),
       
      );

  Map<String, dynamic> toJson() => {
      
      
        "name": name,
        "username": username,
        "partner_display_name": partnerDisplayName,
        "partner_id": partnerId,    
        "user_companies": userCompanies?.toJson(),
        
      };
}





class UserCompanies {
  int? currentCompany;


  UserCompanies({
    this.currentCompany,

  });

  factory UserCompanies.fromJson(Map<String, dynamic> json) => UserCompanies(
        currentCompany: json["current_company"],
       
      );

  Map<String, dynamic> toJson() => {
        "current_company": currentCompany,
      };
}

class UserContext {

  int? uid;

  UserContext({  
    this.uid,
  });

  factory UserContext.fromJson(Map<String, dynamic> json) => UserContext(
     
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
      
        "uid": uid,
      };
}

class UserId {
  int? id;

  UserId({
    this.id,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
