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
require 'sinatra/base'
require 'haml'
require 'openssl'
require 'digest/sha1'
require 'uri'

require 'ews_access_handler'
require File.dirname(__FILE__) + '/../../lib/viewpoint'
require File.dirname(__FILE__) + '/../../lib/exchwebserv'
#require File.dirname(__FILE__) + '/../../lib/folder'
include Viewpoint


module Viewpoint::WEB
	DataMapper.setup(:default, (ENV["DATABASE_URL"] || "sqlite3:///#{Dir.pwd}/devel.db"))
	DataMapper.auto_upgrade!

	class WebClient < Sinatra::Base
		#$DEBUG = true
		set :app_file, __FILE__
		set :root, File.dirname(__FILE__)
		set :static, true
		set :environment, :development
		#set :sessions, true
		#use Rack::Session::Pool
		enable :sessions
		set :logging, true
		set :run, true


		before do
			puts "AUTHC?: #{session[:authenticated].class.to_s}"
			puts "PATH: #{request.path}"
			puts "PATHINFO: #{request.path_info}"
			puts "FULL-PATH: #{request.fullpath}"
			puts "REFERRER: #{request.referrer}"
			unless( session[:authenticated] or request.path =~ /^\/authenticate/)
				redirect "/authenticate?redirect=#{request.path}"
			end
		end

		get '/' do
			haml :welcome
		end

		get '/logout' do
			access_handler = EWSAccessHandler.first(:session_id => session[:id])
			access_handler.destroy! unless access_handler == nil
			session[:passkey] = nil
		end

		get '/mail' do
			ews = get_ews
			mail = MailFolder.new(ews.get_folder_by_name("Inbox"))
			msgs = mail.get_todays_messages
			haml :mail, :layout => false, :locals => {:msgs => msgs}
			#msgs.each do |msg|
			#	output += "#{msg.sender}		| #{msg.subject}		|#{msg.date_time_recieved}<br/>"
			#end
			#output
		end

		post '/msg' do
			ews = get_ews
			mail = MailFolder.new(ews.get_folder_by_name("Inbox"))
			puts "FETCHING2: #{params[:msg_id]}"
			msg = mail.get_item(params[:msg_id])
			puts "MSG: #{msg.class.to_s}"
			msg.body
		end

		get '/encrypt' do
			puts "SESS: #{session[:id]}"
			access_handler = EWSAccessHandler.new(:session_id => session[:id])
			encpass = encrypt_password(pass, session[:passkey])
			access_handler.pass = encpass
			access_handler.save
			"Encrypted #{pass} to #{encpass} with<br/>SESS: #{session[:id]}"
		end

		get '/decrypt' do
			puts "SESS: #{session[:id]}"
			access_handler = EWSAccessHandler.first(:session_id => session[:id])
			puts "ACC: #{access_handler.inspect.to_s}"
			pass = decrypt_password(access_handler.pass, session[:passkey])
			"Decrypted #{access_handler.pass} to #{pass}"
		end

		get '/authenticate' do
			# http://74.125.47.132/search?q=cache:Rhxa86QRnsAJ:paterni.org/wiki/Sinatra_temp_file_sessions+sintatra+session+id&cd=1&hl=en&ct=clnk&gl=us&client=firefox-a
			session[:id] ||= "#{Time.now.to_i.to_s}.#{rand(1000)}.#{ request.ip.gsub(/\./,".")}#{request.port}"
			session[:passkey] ||= gen_passkey

			begin
				user = "user"
				pass = "pass"
				endpoint = "endpoint.asmx"
				access_handler = EWSAccessHandler.new(:session_id => session[:id])
				access_handler.endpoint = endpoint
				access_handler.user = user
				encpass = encrypt_password(pass,session[:passkey])
				access_handler.pass = encpass
				access_handler.save

				ews = get_ews(access_handler)
				session[:authenticated] = true
				puts "REQ from AUTH: #{request.instance_variables.join(', ')}"
				redirect (params[:redirect] ? params[:redirect] : '/')
			rescue SOAP::HTTPStreamError => error
				"Could Not Authenticate user #{user} to #{endpoint} \n => #{error}"
			end
		end

		get '/demo' do
			#haml :welcome
			if( (folders = request.cookies["folders"]) == nil)
				vp = ExchWebServ.instance
				vp.find_folders
				mf = MailFolder.all
				output = mf.map do |m|
					m.display_name
				end
				response.set_cookie("folders", output)
				return "Fetched 'em"
			else
				folders = folders.scan('&')
				vp = ExchWebServ.instance
				mail = vp.get_folder("Inbox")
				msgs = mail.get_todays_messages
				str = ''
				msgs.each do |msg|
					str += "#{msg.sender}		| #{msg.subject}		|#{msg.date_time_recieved}</br>"
				end
				return str
			end

=begin
			user = User.get(session['userId'])

			if not user.nil?
				response.set_cookie("commentmonster_id", {
					:expires => (Time.new + 864000),  # 864000 = seconds in 10 days
					:value => user.uid})
				redirect '/home'
			else
				# This will run if the user has a userId that is no longer in the database
				puts "Forwarding to /welcome from '/'" if $DEBUG
				redirect '/welcome'
			end
=end
		end

		get '/welcome' do
			haml :welcome
		end


		# --------- Admin Routes --------- #
		get '/cookieInfo' do
			"#{request.cookies.entries.join('<br/>&nbsp;&nbsp;&nbsp;=&gt;')}"
		end

		get '/sessionInfo' do
			"#{(session.entries).join('<br/>&nbsp;&nbsp;&nbsp;=&gt;')}"
		end
		
		get '/deleteCookies' do
			deleteCookies(request,response)
			redirect '/cookieInfo'
		end
		
		get '/deleteSession' do
			deleteSession(response)
			redirect '/'
		end

		get '/migrate' do
			DataMapper.auto_migrate!
			"done"
		end


		# --------- Error Handling --------- #
		not_found do
			'Page Not Found'
		end
		
		error do
			#'Sorry there was a nasty error - ' + env['sinatra.error'].name
			'Sorry there was a nasty error.  Please report to the administrator. - '
				+ env['sinatra.error'].name
		end


		
		
		# --------- Helpers --------- #
		
		helpers do
			def partial(template, *args)
				options = args.last.is_a?(Hash) ? args.last : {}
				options.merge!(:layout => false)
				if collection = options.delete(:collection) then
					collection.inject([]) do |buffer, member|
						buffer << haml(template, options.merge(
							:layout => false,
							:locals => {template.to_sym => member}))
					end.join("\n")
				else
					haml(template, options)
				end
			end
		end
		
		def deleteCookie(response,key,value)
			response.set_cookie(key, {
				:expires => (Time.new - 86400),
				:value => value})
		end
		
		def deleteCookies(req,resp)
			req.cookies.keys.each do |key|
				puts "DELETING: #{key}" if $DEBUG
				deleteCookie(resp,key,req.cookies[key])
			end
		end
		
		def deleteSession(response)
			@env['rack.session.options'][:expire_after] = 0
		end

		# Thanks! : http://snippets.dzone.com/posts/show/491
		def gen_passkey
			len = 36
			chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
			newpass = ""
			1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
			return newpass
		end

		# This method encrypts the EWS password so we can store in in a server-side
		# DataMapper database.  The reasoning behind this is so the EWS password isn't
		# stored in plaintext on the client.
		def encrypt_password(pass, passkey)
			c = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
			c.encrypt
			# your pass is what is used to encrypt/decrypt
			c.key = Digest::SHA1.hexdigest(passkey)
			c.iv = session[:ssl_iv] = c.random_iv
			e = c.update(pass)  # encrypt this text
			e << c.final
			return e
		end

		def decrypt_password(encpass, passkey)
			c = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
			c.decrypt
			c.key = Digest::SHA1.hexdigest(passkey)
			c.iv = session[:ssl_iv]
			d = c.update(encpass)
			d << c.final
			return d
		end

		def get_ews(access_handler = nil)
			access_handler ||= EWSAccessHandler.first(:session_id => session[:id])
			pass = decrypt_password(access_handler.pass, session[:passkey])
			ews = ExchWebServ.instance
			ews.authenticate( access_handler.user, pass, access_handler.endpoint )
			return ews
		end
	end
end

#Viewpoint::WEB::WebClient.run!  # heroku won't run with this enabled
