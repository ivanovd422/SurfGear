// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// To parse this JSON data, do
//
//     final nameGeneratorResponse = nameGeneratorResponseFromJson(jsonString);

import 'dart:convert';

import 'package:name_generator/domain/User.dart';

class NameGeneratorResponse {
  String name;
  String surname;
  String gender;
  String region;
  int age;
  String title;
  String phone;
  String email;
  String password;
  String photo;

  NameGeneratorResponse({
    this.name,
    this.surname,
    this.gender,
    this.region,
    this.age,
    this.title,
    this.phone,
    this.email,
    this.password,
    this.photo,
  });

  factory NameGeneratorResponse.fromRawJson(String str) =>
      NameGeneratorResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NameGeneratorResponse.fromJson(Map<String, dynamic> json) =>
      new NameGeneratorResponse(
        name: json["name"] == null ? null : json["name"],
        surname: json["surname"] == null ? null : json["surname"],
        gender: json["gender"] == null ? null : json["gender"],
        region: json["region"] == null ? null : json["region"],
        age: json["age"] == null ? null : json["age"],
        title: json["title"] == null ? null : json["title"],
        phone: json["phone"] == null ? null : json["phone"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        photo: json["photo"] == null ? null : json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "surname": surname == null ? null : surname,
        "gender": gender == null ? null : gender,
        "region": region == null ? null : region,
        "age": age == null ? null : age,
        "title": title == null ? null : title,
        "phone": phone == null ? null : phone,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "photo": photo == null ? null : photo,
      };

  User transform() => User(
        name: '${this.name} ${this.surname}',
        phone: this.phone,
        email: this.email,
        region: this.region,
      );
}
