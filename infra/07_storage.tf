# ./infra/06_storage.tf

resource "yandex_storage_bucket" "picture_bucket" {
  bucket        = "${var.flow}-bucket"
  folder_id     = var.folder_id
  force_destroy = true

  anonymous_access_flags {
    read        = true
    list        = false
    config_read = false
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.bucket_key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "yandex_storage_object" "picture" {
  bucket       = yandex_storage_bucket.picture_bucket.id
  key          = "picture.jpg"
  source       = var.image_path
  acl          = "public-read"
  content_type = "image/jpeg"
}