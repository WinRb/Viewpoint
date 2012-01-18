h1. Viewpoint for Exchange Web Services 1.0
http://github.com/zenchild/Viewpoint/wiki

Viewpoint for EWS provides a thin Ruby layer on top of Microsoft Exchange
Web Services(EWS). It also includes a bunch of model classes that add an
additional layer of abstraction on top of EWS for use in implementing
programs with Viewpoint.

BLOG:  http://distributed-frostbite.blogspot.com/

Add me in LinkedIn:  http://www.linkedin.com/in/danwanek

Find me on irc.freenode.net in #ruby-lang (zenChild)

h2. Features

h3. New in 1.0

* SOAP backend is now only dependant on Nokogiri. Before version 1.0 Viewpoint
went through a number of iterations in backends including SOAP4r and Handsoap.
Each of these approaches had major issues so in the end I decided it was
easiest to just build the SOAP messages with Nokogiri since I was using it as
the parser for response messages already.

* Viewpoint is no longer built on a Singleton pattern. The reason it was
previously is because of the Handsoap backend. Handsoap itself uses a
Singleton pattern for connection to the SOAP endpoint so with authentication
I was forced to implement Viewpoint as a Singleton as well. Now with Handsoap
out of the picture this is no longer required. Go crazy ;)

h3. Enhanced in 1.0

* Delegate access is supported
  One thing that was often asked for, but missing from the previous version
  was delegate access to mailboxes and calendars.  This is now supported via
  the 'act_as' parameter to the GenericFolder::get_folder method. For example:
  ofolder = Folder.get_folder(:inbox,'otheruser@test.com')
  If your user has delegate access to the Inbox for otheruser@test.com this
  operation will retrieve their inbox and allow you to manipulate it as you
  would with your own Inbox.

* There is also some support for manipulation of delegate access itself via
  the methods MailboxUser#add_delegate!, MailboxUser#update_delegate!, and 
  MailboxUser#get_delegate_info.

--------------------------------------------------------------------------
TO USE:
```ruby
require 'rubygems'
require 'viewpoint'
```
# See REQUIRED GEMS below

REQUIRED GEMS:

# NTLM Library
`gem install -r rubyntlm`

--------------------------------------------------------------------------
DESIGN GOALS/GUIDELINES:

  1. The SOAP back-end should not know about the Model.
    I went around and around on this one for awhile.  There are some
    simplicity advantages to creating Model objects within the SOAP
    responses, but I ultimately decided against it so that one could use
    the SOAP back-end without the Model.  Essentially the SOAP classes
    pass back a Hash that the Model uses to create its own objects.

  2. The use of Hashes is not a crime.
    While some people decidedly do not like Hashes and believe complex
    hashing should be in the form of objects, there are some instances
    where hashing is just plain simpler and flexible.  To that end, I use
    hashes pretty extensively in Viewpoint, both for objects being passed
    to the SOAP back-end and returned from it.

  3. Follow EWS naming conventions where it makes sense.
    I try and follow the naming conventions of the Exchange Web Service
    operations as much as it makes sense.  There are some things howerver
    where they do not and I have deviated somewhat.  For example,
    an instance method named delete_folder doesn't make much sense, but
    an instance method named delete! is pretty clear what it deletes.
--------------------------------------------------------------------------
!!!SHOUTS OUT!!!
--------------------------------------------------------------------------
* Thanks to Harold Lee (https://github.com/haroldl) for working on the
  get_user_availability code.
--------------------------------------------------------------------------
DISCLAIMER:  If you see something that could be done better or would like
to help out in the development of this code please feel free to clone the
'git' repository and send me patches:
git clone git://github.com/zenchild/Viewpoint.git
or add an issue on GitHub:
http://github.com/zenchild/Viewpoint/issues

Cheers!
--------------------------------------------------------------------------
