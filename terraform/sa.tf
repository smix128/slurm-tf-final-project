resource "yandex_iam_service_account" "this" {
   name = "nginx-sa"
 }

 resource "yandex_resourcemanager_folder_iam_binding" "this" {
  folder_id   = "${var.yc_folder_id}"
  role        = "editor"
  members     = [
    "serviceAccount:${yandex_iam_service_account.this.id}",
  ]
}