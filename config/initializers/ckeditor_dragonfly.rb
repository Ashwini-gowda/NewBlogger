# frozen_string_literal: true

# Load Dragonfly if it isn't loaded already.
require 'dragonfly'

Dragonfly.app(:ckeditor).configure do
  plugin :imagemagick
  secret "23b3f287ab5c86de0923a963c387d950e3096561e8f5d831466855f4401e0fe8"

  # Store files in public/uploads/ckeditor. This is not
  # mandatory and the files don't even have to be stored under
  # public. See http://markevans.github.io/dragonfly/data-stores
  datastore :file, root_path: Rails.root.join('public/uploads/ckeditor', Rails.env).to_s,
                   server_root: 'public'

  # Accept asset requests on /ckeditor_assets. Again, this path is
  # not mandatory. Just be sure to include :job somewhere.
  url_format '/uploads/ckeditor/:job/:basename.:format'
end

Rails.application.middleware.use Dragonfly::Middleware, :ckeditor
