resource "yandex_iam_service_account" "this" {
   name = "nginx-sa"
 }

 resource "yandex_resourcemanager_folder_iam_binding" "this" {
  folder_id   = "b1g9uka7gvk8bkh2s9ae"
  role        = "editor"
  members     = [
    "serviceAccount:${yandex_iam_service_account.this.id}",
  ]
}