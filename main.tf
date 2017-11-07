resource "ibm_network_vlan" "webapp_public_vlan" {
  name            = "public_network"
  datacenter      = "lon02"
  type            = "PUBLIC"
  subnet_size     = 8
}

resource "ibm_network_vlan" "webapp_private_vlan" {
  name            = "private_network"
  datacenter      = "lon02"
  type            = "PRIVATE"
  subnet_size     = 8
}

resource "ibm_network_vlan" "database_private_vlan" {
  name            = "private_network"
  datacenter      = "dal06"
  type            = "PRIVATE"
  subnet_size     = 8
}

resource "ibm_compute_ssh_key" "ssh_key" {
  label      = "${var.ssh_label}"
  notes      = "${var.ssh_notes}"
  public_key = "${var.ssh_key}"
}

resource "ibm_compute_vm_instance" "vm" {
  hostname             = "${var.hostname}"
  os_reference_code    = "${var.os_reference_code}"
  domain               = "${var.domain}"
  datacenter           = "${var.datacenter}"
  network_speed        = "${var.network_speed}"
  hourly_billing       = true
  private_network_only = false
  cores                = "${var.cores}"
  memory               = "${var.memory}"
  disks                = ["${var.disk_size}"]

  public_vlan_id  = "${ibm_network_vlan.webapp_public_vlan.id}"
  private_vlan_id = "${ibm_network_vlan.webapp_private_vlan.id}"

  local_disk  = false
  ssh_key_ids = ["${ibm_compute_ssh_key.ssh_key.id}"]
  tags        = ["${var.tags}"]

  user_metadata = "${file("install-apache-php.yml")}"
}

resource "ibm_compute_vm_instance" "database" {
  hostname             = "mydatabase"
  os_reference_code    = "${var.os_reference_code}"
  domain               = "internal.com"
  datacenter           = "dal06"
  network_speed        = "${var.network_speed}"
  hourly_billing       = true
  private_network_only = false
  cores                = "${var.cores}"
  memory               = "${var.memory}"
  disks                = ["${var.disk_size}"]
  private_vlan_id      = "${ibm_network_vlan.database_private_vlan.id}"

  local_disk  = false
  ssh_key_ids = ["${ibm_compute_ssh_key.ssh_key.id}"]
  tags        = ["${var.tags}"]

  user_metadata = "${file("install-database.yml")}"
}

resource "ibm_dns_domain" "domain" {
	name = "internal.com"
}

resource "ibm_dns_record" "recordA" {
    data = "${ibm_compute_vm_instance.database.ipv4_address}"
    domain_id = "${ibm_dns_domain.domain.id}"
    expire = 900
    minimum_ttl = 86400
    mx_priority = 1
    refresh = 1
    host = "mydatabase.internal.com"
    responsible_person = "hkantare@in.ibm.com"
    ttl = 900
    retry = 1
    type = "a"
}

