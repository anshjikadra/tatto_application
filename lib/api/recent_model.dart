class recent_data {
  String? status;
  int? count;
  String? countTotal;
  int? pages;
  List<recent_Posts>? posts;

  recent_data(
      {this.status, this.count, this.countTotal, this.pages, this.posts});

  recent_data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    count = json['count'];
    countTotal = json['count_total'];
    pages = json['pages'];
    if (json['posts'] != null) {
      posts = <recent_Posts>[];
      json['posts'].forEach((v) {
        posts!.add(new recent_Posts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['count'] = this.count;
    data['count_total'] = this.countTotal;
    data['pages'] = this.pages;
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class recent_Posts {
  String? imageId;
  String? imageName;
  String? imageUpload;
  String? imageThumb;
  String? imageUrl;
  String? type;
  String? resolution;
  String? size;
  String? mime;
  String? views;
  String? downloads;
  String? featured;
  String? tags;
  String? categoryId;
  String? categoryName;
  String? lastUpdate;

  recent_Posts(
      {this.imageId,
        this.imageName,
        this.imageUpload,
        this.imageThumb,
        this.imageUrl,
        this.type,
        this.resolution,
        this.size,
        this.mime,
        this.views,
        this.downloads,
        this.featured,
        this.tags,
        this.categoryId,
        this.categoryName,
        this.lastUpdate});

  recent_Posts.fromJson(Map<String, dynamic> json) {
    imageId = json['image_id'];
    imageName = json['image_name'];
    imageUpload = json['image_upload'];
    imageThumb = json['image_thumb'];
    imageUrl = json['image_url'];
    type = json['type'];
    resolution = json['resolution'];
    size = json['size'];
    mime = json['mime'];
    views = json['views'];
    downloads = json['downloads'];
    featured = json['featured'];
    tags = json['tags'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    lastUpdate = json['last_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_id'] = this.imageId;
    data['image_name'] = this.imageName;
    data['image_upload'] = this.imageUpload;
    data['image_thumb'] = this.imageThumb;
    data['image_url'] = this.imageUrl;
    data['type'] = this.type;
    data['resolution'] = this.resolution;
    data['size'] = this.size;
    data['mime'] = this.mime;
    data['views'] = this.views;
    data['downloads'] = this.downloads;
    data['featured'] = this.featured;
    data['tags'] = this.tags;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['last_update'] = this.lastUpdate;
    return data;
  }
}