# ./terraform/06_storage.tf

resource "yandex_storage_bucket" "picture_bucket" {
  bucket        = var.bucket_name
  folder_id     = var.folder_id
  force_destroy = true

  anonymous_access_flags {
    read        = true
    list        = false
    config_read = false
  }
}

resource "yandex_storage_object" "picture" {
  bucket       = yandex_storage_bucket.picture_bucket.id
  key          = "picture.jpg"
  source       = var.image_path
  acl          = "public-read"
  content_type = "image/jpeg"
}