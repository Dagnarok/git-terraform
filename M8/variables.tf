variable "rg_name" {    
    type = string
    description = "Resource Group Name"
    default = "rg-web-dk"
}

variable "sa_name" {
    type = string
    description = "Storage Account Name"
    default = "sawebdk"
}

variable "location" {
    type = string
    description = "Location for the resources"
    default = "westeurope"
}

variable "index_document" {
    type = string
    description = "Index document for the static website"
    default = "index.html"
}

variable "source_content" {
    type = string
    description = "Source content for the static website"
    default = "<h1>Hallo og velkommen til Modul 8</h1>"
}

