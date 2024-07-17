class ProfileModel {
    String? id;
    String? employeeId;
    String? firstName;
    String? lastName;
    String? email;
    String? mobile;
    Role? role;
    String? imageUrl;

    ProfileModel({
        this.id,
        this.employeeId,
        this.firstName,
        this.lastName,
        this.email,
        this.mobile,
        this.role,
        this.imageUrl,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["_id"],
        employeeId: json["employeeId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        mobile: json["mobile"],
        role: json["role"] == null ? null : Role.fromJson(json["role"]),
        imageUrl: json["imageUrl"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "employeeId": employeeId,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "mobile": mobile,
        "role": role?.toJson(),
        "imageUrl": imageUrl,
    };
}

class Role {
    String? id;
    String? name;
    Template? template;

    Role({
        this.id,
        this.name,
        this.template,
    });

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["_id"],
        name: json["name"],
        template: json["template"] == null ? null : Template.fromJson(json["template"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "template": template?.toJson(),
    };
}

class Template {
    String? id;
    String? name;

    Template({
        this.id,
        this.name,
    });

    factory Template.fromJson(Map<String, dynamic> json) => Template(
        id: json["_id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
    };
}
