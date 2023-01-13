variable "az" {
  type = list(string)
  default = [
    "ru-central1-a",
    "ru-central1-b",
    "ru-central1-c"
  ]
}

variable "cidr_blocks" {
  type = list(list(string))
  default = [
    ["10.10.10.0/24"],
    ["10.10.20.0/24"],
    ["10.10.30.0/24"]
  ]
}

variable "ig_name" {
  type = string
}

variable "yc_folder_id" {
  type = string
}

variable "yc_image_id" {
  type = string
}