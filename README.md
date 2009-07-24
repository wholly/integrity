What is Integrity?
==================

[Integrity][website] is your friendly automated Continuous Integration server.

                  
What is this repository all about?
==================================
  There has been various issues of regarding thin, sinatra, rack version dependancy which makes integrity setup painful, Wholly Team has tried to simplify the process



How simple is it?
-----------------
  
    $ git clone git://github.com/wholly/integrity.git  
    $ gem install sinatra-sinatra -s http://gems.github.com 
    $ gem install thin do_sqlite3                           
    $ gem install oauth
	$ gem install -s http://gems.github.com jstewart-yammer4r  
	$ cp config/config.sample.ru config/config.ru  
	$ cp config/config.sample.yml config/config.yml      (Change contents to suite your needs) 
    $ thin -C config/config.yml -R config/config.ru start
    $ open http://0.0.0.0:3000/







[website]: http://integrityapp.com
[demo]: http://builder.integrityapp.com
[repo]: http://github.com/integrity/integrity
[lighthouse]: http://integrity.lighthouseapp.com/projects/14308-integrity
[irc-channel]: irc://irc.freenode.net/integrity
[rubygems]: http://gist.github.com/54177
[rtomayko]: http://tomayko.com/about
[Rip]: http://hellorip.com
