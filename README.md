**ATTENTION:** If you want to fix a bug in the currently released gem please use the 0.1.x-support branch. The master is the current development branch and is not ready for prime-time just yet.

# Viewpoint for Exchange Web Services 1.0
http://github.com/zenchild/Viewpoint/wiki

Viewpoint for EWS provides a thin Ruby layer on top of Microsoft Exchange
Web Services(EWS). It also includes a bunch of model classes that add an
additional layer of abstraction on top of EWS for use in implementing
programs with Viewpoint.

BLOG:  http://distributed-frostbite.blogspot.com/

Add me in LinkedIn:  http://www.linkedin.com/in/danwanek

Find me on irc.freenode.net in #ruby-lang (zenChild)

# Features

## New in 1.0

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

## Enhanced in 1.0

* *Delegate access is supported*
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


# Using Viewpoint

The version 1.0 API is quite a departure from the 0.1.x code base. If you have
a lot of legacy code and aren't suffering from performance issues, think twice
about upgrading. That said, I hope you'll find the new API much clean and more
intuitive than previous versions.

Note the `cli` variable in the setup code directly below. I will use that variable throughout without the setup code.

## The Setup
```ruby
require 'viewpoint'
include Viewpoint::EWS

endpoint = 'https://example.com/ews/Exchange.asmx'
user = 'username'
pass = 'password'

cli = Viewpoint::EWSClient.new endpoint, user, pass
```

There are also various options you can pass to EWSClient.

If you are testing in an environment using a self-signed certificate you can pass a connection parameter to ignore SSL verification by passing `http_opts: {ssl_verify_mode: 0}`.

If you want to target a specific version of Exchange you can pass `server_version: SOAP::ExchangeWebService::VERSION_2010_SP1`. You really shouldn't have to use this unless you know why.

## Accessors

There are some basic accessors available on the Viewpoint::EWSClient instance. In prior versions these were typically class methods off of the models themselves (ex: Folder.get_folder(id)). Now all accessors are available through EWSClient.

### Folder Accessors

#### Listing Folders
```ruby
# Find all folders under :msgfolderroot
folders = cli.folders

# Find all folders under Inbox
inbox_folders = cli.folders root: :inbox

# Find all folders under :root and do a Deep search
all_folders = cli.folders root: :root, traversal: :deep
```

#### Finding single folders
```ruby
folder = cli.get_folder <folder_id>
folder = cli.get_folder_by




---
TO USE:

```ruby
require 'rubygems'
require 'viewpoint'
include Viewpoint::EWS

endpoint = 'https://example.com/ews/Exchange.asmx'
user = 'username'
pass = 'password'

cli = Viewpoint::EWSClient.new endpoint, user, pass

# Get all folders
folders = cli.find_folders

# Get a specific folder
inbox = cli.get_folder :inbox

# Get available EWS methods on an object
inbox.ews_methods

# Get items from an object (messages in this case)
msgs = inbox.items
```

## Thanks go out to...

* The National Association of REALTORS® for providing a testing account
  and much appreciated input and support.
* The Holmes Group Limited for providing Exchange 2013 test accounts.
* Harold Lee (https://github.com/haroldl) for working on the
  get_user_availability code.

---
DISCLAIMER:  If you see something that could be done better or would like
to help out in the development of this code please feel free to clone the
'git' repository and send me patches:
git clone git://github.com/zenchild/Viewpoint.git
or add an issue on GitHub:
http://github.com/zenchild/Viewpoint/issues

Cheers!
---
