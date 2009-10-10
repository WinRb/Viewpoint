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

require File.dirname(__FILE__) + '/../../lib/viewpoint'
require File.dirname(__FILE__) + '/../../lib/exchwebserv'
#require File.dirname(__FILE__) + '/../../lib/folder'
include Viewpoint


module Viewpoint::WEB
	class WebClient < Sinatra::Base
		set :app_file, __FILE__
		set :root, File.dirname(__FILE__)
		set :static, true
		set :environment, :development
		#set :sessions, true
		#use Rack::Session::Pool
		enable :sessions
		set :logging, true
		set :run, true


=begin
		before do
			puts "**** Running initialization" if $DEBUG
			if(not session.key?('userId')) then
				puts "**** Session key 'userId' not found" if $DEBUG
				if(request.cookies.key?('commentmonster_id')) then
					puts "**** Session session userId from commentmonster_id cookie" if $DEBUG
					session['userId'] = request.cookies['commentmonster_id']
				elsif(request.get? and request.path_info != '/welcome')
					puts "Forwarding to /welcome from 'before'" if $DEBUG
					redirect '/welcome'
				else
					puts "Doing nothing in before" if $DEBUG
				end
			end
		end
=end

		get '/' do
			haml :welcome
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

	end
end

#Viewpoint::WEB::WebClient.run!  # heroku won't run with this enabled
