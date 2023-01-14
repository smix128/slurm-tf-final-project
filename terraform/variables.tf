variable "az" {
  type = list(string)
}

variable "cidr_blocks" {
  type = list(list(string))
}

variable "yc_folder_id" {
  type = string
}

variable "yc_image_id" {
  type = string
}

variable "scale" {
  type = number
}