SpreeCatalogSolr
================

Introduction goes here.

Installation
------------

Add spree_catalog_solr to your Gemfile:

```ruby
gem 'spree_catalog_solr'
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g spree_catalog_solr:install
```

Adding Custom Fields
--------------------

To index a custom field just open a configuration block and add it to the extra_fields array:

```ruby
SpreeCatalogSolr::Config.setup do |config|
  config.extra_fields = [
    { name: 'brand', type: 'string' }
  ]
end
```

You will need to add the implementation for this brand method inside your model.

Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

```shell
bundle
bundle exec rake test_app
bundle exec rspec spec
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_catalog_solr/factories'
```

Copyright (c) 2014 [name of extension creator], released under the New BSD License
