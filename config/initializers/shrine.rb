require "shrine"
require "shrine/storage/file_system"

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"), # temporary
  store: Shrine::Storage::FileSystem.new("public", prefix: "uploads") # permanent
}

Shrine.plugin :activerecord
Shrine.plugin :upload_endpoint
Shrine.plugin :pretty_location
Shrine.plugin :validation_helpers
Shrine.plugin :determine_mime_type

Shrine::Attacher.validate do
  validate_mime_type_inclusion %w[application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document]
end
