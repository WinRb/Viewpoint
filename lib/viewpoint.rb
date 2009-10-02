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
$:.unshift(File.dirname(__FILE__))
require 'rubygems'
require 'highline/import'
require 'singleton'
require 'wsdl/exchangeServiceBinding'
require 'exchange_headers'

# This class will act as the controller for a client connection to the
# Exchange web service.
class Viewpoint
	include Singleton

	attr_reader :ews, :user, :authenticated

	def initialize
		@authenticated = false
		# Exchange webservice URL (probably ends in /exchange.asmx)
		@ews_endpoint  = ""
		@user = ""
		@pass = ""
		# Connection to Exchange web services.  You can get fetch this from an accessor later
		@ews  = nil

		# Do initial authentication
		do_auth
	end

	def get_folders
		ff = FindFolderType.new()
		ff.xmlattr_Traversal = FolderQueryTraversalType::Deep
		ff.folderShape = FolderResponseShapeType.new( DefaultShapeNamesType.new("Default") )
		#NN
		fid = NonEmptyArrayOfBaseFolderIdsType.new()
		fidt = DistinguishedFolderIdType.new
		fidt.xmlattr_Id = DistinguishedFolderIdNameType::Root
		fid.distinguishedFolderId = fidt
		ff.parentFolderIds = fid

		# FindFolderResponseType
		resp = @ews.findFolder(ff)

		# ArrayOfResponseMessagesType
		msgs = resp.responseMessages

		# Array of FindFolderResponseMessageType
=begin
		msgs.findFolderResponseMessage.each do |elem|
			elem.rootFolder.folders.folder.each do |folder|
			end
			#CalendarFolderType
			elem.rootFolder.folders.calendarFolder.each do |folder|
				f_name = folder.displayName
				f_id   = folder.folderId.xmlattr_Id
				f_pid   = folder.parentFolderId.xmlattr_Id
			end
			#elem.rootFolder.folders.contactsFolder.each do |folder|
			#end
			#elem.rootFolder.folders.searchFolder.each do |folder|
			#end
			elem.rootFolder.folders.tasksFolder.each do |folder|
			end
		end
=end
	end

	private
	def do_auth
		retry_count = 0
		begin
			#@ews_endpoint  = ask("Exchange EWS Endpoint:  ") { |q| q.echo = true }
			#@ews_endpoint  = "https://webmail.state.nd.us/ews/exchange.asmx"
			#@user = ask("User:  ") { |q| q.echo = true }
			#@pass = ask("Pass:  ") { |q| q.echo = "*"}
			props = SOAP::Property.load(File.new("#{File.dirname(__FILE__)}/soap/property"))
			@user = props['exchange.ews.user']
			@pass = props['exchange.ews.pass']
			@ews_endpoint = props['exchange.ews.endpoint']

			@ews = ExchangeServiceBinding.new(@ews_endpoint)
			@ews.options["protocol.http.auth.ntlm"] = [@ews_endpoint.sub(/\/[^\/]+$/,'/'),@user,@pass]
			@ews.headerhandler << ExchangeHeaders.new

			# Log SOAP request and response for debugging.  Run ruby with the '-d' option.
			if($DEBUG) then
				@ews.wiredump_file_base = "viewpoint-soaplog"
			end

			# Do a ResolveNames operation to make sure that authentication works.
			# If you don't do an operation, you won't find out that bad credentials
			# were entered until later.  The ResolveNames operation is completely
			# arbitrary and could be any EWS call.
			# http://msdn.microsoft.com/en-us/library/bb409286.aspx
			rnt = ResolveNamesType.new(nil,@user)
			rnt.xmlattr_ReturnFullContactData = false
			ews.resolveNames(rnt)

		rescue SOAP::HTTPStreamError
			puts "Bad Login!  Try Again."
			if( retry_count < 2)
				retry_count += 1
				retry
			else
				puts "-----------------------------------------------------------"
				puts "Could not log into Exchange Web Services.  Make sure your information is correct"
				puts "End Point: #{@ews_endpoint}"
				puts "User: #{@user}"
				puts "-----------------------------------------------------------"
				return
			end
		end
		@authenticated = true
	end
end
