variable "hostname" {
  default = "hostname"
}
variable "domain" {
  default = "domain.dev"
}
variable "datacenter" {
  default = "lon02"
}
variable "os_reference_code" {
  default = "CENTOS_7"
}
variable "cores" {
  default = "1"
}
variable "memory" {
  default = "1024"
}
variable "disk_size" {
  default = "25"
}

variable "network_speed" {
  default = "100"
}
variable "tags" {
  default = ""
}

variable "ssh_label" {
  default = "public ssh key - Jenkins VM"
}
variable "ssh_notes" {
  default = ""
}
variable "ssh_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC64reMHg4D7RpuyOHxS3IFOwxMxmjHPfFcBW+ngeZK/4f+NBf0e3xaK89I+GIUlbjyOBLCooH/U9QtVP88YceBmfTMwS+iRSdRJ/9nPKyWL50GODuJoh3TFlCf+Cih0uiNIcJbtAB8f8nZVvpT+WUTSIinzEH7vaiAh0OE2j+vNA4ElTi51DTJFuD6sIGG3lrliwyc9bZAc5xBcUarisFVGD23rrq5tJcee1yC15sgliT9ab2vwwBL3zdf4tk0rZup0oOed0lTfgbQDjr3B+p3dUzT6Z33CDGoTuVzJMS7KXIaDabjwjrRS6s8SqLvTxMIgQ+24/iN/7PXg7Gr7BtD hkantare@Harinis-MacBook-Pro.local"
  description = "public SSH key to use in keypair"
}
