#############################################################################
# Copyright © 2009 Dan Wanek <dan.wanek@gmail.com>
#
#
# This file is part of Viewpoint.
# 
# Viewpoint is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as published
# by the Free Software Foundation, either version 3 of the License, or (at
# your option) any later version.
# 
# Viewpoint is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
# Public License for more details.
# 
# You should have received a copy of the GNU General Public License along
# with Viewpoint.  If not, see <http://www.gnu.org/licenses/>.
#############################################################################
require 'rubygems'
gem 'soap4r'
require 'soap/header/simplehandler'


# Some functionality of EWS depends on setting the "RequestServerVersion"
# element with a specified "Version" attribute.  That is all this class
# is doing.
# It is used during the initial connection process by setting the
# headerhandler in the serivce binding.
# *<tt>@exchange.headerhandler << ExchangeHeaders.new</tt>
class Viewpoint::ExchangeHeaders < SOAP::Header::SimpleHandler
	NAMESPACE = 'http://schemas.microsoft.com/exchange/services/2006/types'

	def initialize
		@qname = XSD::QName.new(NAMESPACE,"RequestServerVersion")
		super(@qname)
	end

	def on_simple_outbound
		{
		"xmlattr_Version" => "Exchange2007_SP1"
		}
	end

	def on_outbound
    	h = on_simple_outbound
    	h ? SOAP::SOAPElement.from_obj(h, nil) : nil
  	end
end
