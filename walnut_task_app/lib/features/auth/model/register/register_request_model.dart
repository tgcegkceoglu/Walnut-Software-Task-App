class RegisterRequestModel {
    RegisterRequestModel({
         this.username,
         this.email,
         this.password,
    });

     String? username;
     String? email;
     String? password;

    factory RegisterRequestModel.fromJson(Map<String, dynamic> json){ 
        return RegisterRequestModel(
            username: json["username"],
            email: json["email"],
            password: json["password"],
        );
    }

    Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
    };

}
