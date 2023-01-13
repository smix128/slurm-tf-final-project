
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