Mission Control
===============

What?
-----

I'm a freelance web developer, I hate administrave tasks and a wise friend once told me, "Any given task I have to repeat 3 times is worth automating." Mission Control is my response to the problem, my own administrative robot so to say.

In a perfect world it would tell me if I'm loosing money with a certain client, if my code quality drops, if I don't work enough, and soo many other metrics I worry over. Right now it keeps track of the days or hours I worked for my clients.

Disclaimer
----------

Feel free to use this application if you like but it's tailored to my way of working and may or may not fit your workflow. It's not intended to be distributed but writing open source applications forces me to write better code, I hope.

Installing
----------

Make sure you have Ruby 1.9.3 and Bundler installed and clone this repository.

    $ cp config/database.yml.example config/database.yml
    $ bundle install
    $ rake db:create; rake db:schema:load
    $ rails server

Optionally you can run the tests:

    $ RAILS_ENV=test rake db:schema:load
    $ cucumber
    $ rspec spec

Thanks
------

Thank you [Ruby](http://www.ruby-lang.org/) community for building and maintaining such an awesome language and for fostering an innovative community. Thank you Twitter for your [Bootstrap](http://twitter.github.com/bootstrap/) CSS toolkit.

Copyright and License
---------------------

Copyright 2011 Nimbly

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this work except in compliance with the License.
You may obtain a copy of the License in the LICENSE file, or at:

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
