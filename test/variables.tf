variable "rg-name" {
  type        = string
  description = "value of the resource group name"
}

variable "rg-location" {
  type        = string
  description = "value of the resource group location"
}

variable "sa-name" {
  type        = string
  description = "value of the storage account name"
}

variable "index-document" {
  type        = string
  description = "Index document for the static website"
  default     = "index.html"
}

variable "source-content" {
  type        = string
  description = "Source content for the static website"
  default     = "<h1>Hallo og velkommen til Modul 8</h1>"
}

