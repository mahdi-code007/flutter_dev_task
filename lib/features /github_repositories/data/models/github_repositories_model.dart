/// id : 36665193
/// name : "Aardvark"
/// owner : {"login":"square","id":82592,"html_url":"https://github.com/square"}
/// html_url : "https://github.com/square/Aardvark"
/// description : "Aardvark is a library that makes it dead simple to create actionable bug reports."
/// fork : false

class GithubRepositoriesModel {
  GithubRepositoriesModel({
      dynamic id, 
      dynamic name, 
      Owner? owner,
    dynamic htmlUrl,
    dynamic description, 
      bool? fork,}){
    _id = id;
    _name = name;
    _owner = owner;
    _htmlUrl = htmlUrl;
    _description = description;
    _fork = fork;
}


  @override
  String toString() {
    return 'GithubRepositoriesModel{_id: $_id, _name: $_name, _owner: $_owner, _htmlUrl: $_htmlUrl, _description: $_description, _fork: $_fork}';
  }

  GithubRepositoriesModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    _htmlUrl = json['html_url'];
    _description = json['description'];
    _fork = json['fork'];
  }
  dynamic _id;
  dynamic _name;
  Owner? _owner;
  dynamic _htmlUrl;
  dynamic _description;
  bool? _fork;
GithubRepositoriesModel copyWith({  dynamic id,
  dynamic name,
  Owner? owner,
  dynamic htmlUrl,
  dynamic description,
  bool? fork,
}) => GithubRepositoriesModel(  id: id ?? _id,
  name: name ?? _name,
  owner: owner ?? _owner,
  htmlUrl: htmlUrl ?? _htmlUrl,
  description: description ?? _description,
  fork: fork ?? _fork,
);
  dynamic get id => _id;
  dynamic get name => _name;
  Owner? get owner => _owner;
  dynamic get htmlUrl => _htmlUrl;
  dynamic get description => _description;
  bool? get fork => _fork;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    if (_owner != null) {
      map['owner'] = _owner?.toJson();
    }
    map['html_url'] = _htmlUrl;
    map['description'] = _description;
    map['fork'] = _fork;
    return map;
  }

}

/// login : "square"
/// id : 82592
/// html_url : "https://github.com/square"

class Owner {
  Owner({
      dynamic login, 
      dynamic id, 
      dynamic htmlUrl,}){
    _login = login;
    _id = id;
    _htmlUrl = htmlUrl;
}

  Owner.fromJson(dynamic json) {
    _login = json['login'];
    _id = json['id'];
    _htmlUrl = json['html_url'];
  }
  dynamic _login;
  dynamic _id;
  dynamic _htmlUrl;
Owner copyWith({  dynamic login,
  dynamic id,
  dynamic htmlUrl,
}) => Owner(  login: login ?? _login,
  id: id ?? _id,
  htmlUrl: htmlUrl ?? _htmlUrl,
);
  dynamic get login => _login;
  dynamic get id => _id;
  dynamic get htmlUrl => _htmlUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['login'] = _login;
    map['id'] = _id;
    map['html_url'] = _htmlUrl;
    return map;
  }

}