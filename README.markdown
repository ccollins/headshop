Headshop
==========

Meta tag management to DRY up your views and SEO the crap out of your site.

Installation
------------

To get started with headshop add it to your gemfile:

    gem 'headshop'
    
Usage
-----

Headshop relies on a yml file to determine the meta tags to display.  Create an initializer file (config/intializers/headshop.rb) and tell headshop where your yml file is located.

    Headshop.setup do |config|
      config.config_file = File.join(Rails.root, 'config', 'headshop.yml')
    end
    
Headshop will search the yml file with the controller name/action name to find the correct tags.  To populate the meta tags for the index action on the landing controller:

    landing:
      index:
        title: Landing Page
        description: Landing Page
        keywords: landing, page
        
Headshop will also look for default meta tags if they are defined.  If headshop cannot locate the tags for a controller/action pair, the default tags will be displayed.

    default_meta:
      title: Default Page
      description: Default Page
      keywords: default, page
      
You can also apply base tags to each matching tag:

    base_meta:
      title: Headshop |
      description: Headshop |
      keywords: headshop
      
This will output (given the default_meta above):

    <title>Headshop | Default Page</title>
    <meta name='title' content='Headshop | Default Page' />
    <meta name='description' content='Headshop | Default Page' />
    <meta name='keywords' content='headshop, default, page' />
    
Meta tags aren't limited to title, description and keywords.  Headshop will apply any meta tag found in the yml file to your view.

Display the meta tag in your view with the meta_tag helper:

    = meta_tag


Contributing to providence
--------------------------
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

Copyright
---------

Copyright (c) 2011 Chuck Collins

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

