class LoginRequestModel {
    LoginRequestModel({
         this.identifier,
         this.password,
    });

     String? identifier;
     String? password;

    factory LoginRequestModel.fromJson(Map<String, dynamic> json){ 
        return LoginRequestModel(
            identifier: json["identifier"],
            password: json["password"],
        );
    }

    Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "password": password,
    };

}
