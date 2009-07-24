Integrity Yammer Notifier
===========================

Post a message to a Yammer feed after each build

Setup 
==================

Step 1. **Install Required Gems**

*oauth* (gem install oauth)  
*yammer4r* (gem install -s http://gems.github.com jstewart-yammer4r)  
*integrity-yammer* (gem install -s http://gems.github.com jstewart-integrity-yammer)


Step 2. **Add this to config.ru file:**

    require "rubygems"
    require "notifier/yammer"


Step 3. **Create a yammer oauth yml file with the following information (or use the yammer\_create\_oauth\_yml script in yammer4r):**

    consumer:
      key: YOUR_KEY_HERE
      secret: YOUR_KEY_HERE

    access:
      token: YOUR_KEY_HERE
      secret: YOUR_KEY_HERE


Step 4. **Edit your project and enter the location of your yammer oauth file.**
  

License
=======

(The MIT License)

Copyright (c) 2009 Jason Stewart

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
