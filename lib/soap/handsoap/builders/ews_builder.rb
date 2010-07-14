#############################################################################
# Copyright © 2010 Dan Wanek <dan.wanek@gmail.com>
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
module Viewpoint
  module EWS
    module SOAP
      class EwsBuilder
        def initialize(node, opts, &block)
          @node, @opts = node, opts
          instance_eval(&block) if block_given?
        end

        def page_url!(url)
          @node.add('spsoap:pageUrl',url)
        end

        def checkout_to_local!(writeable)
          @node.add('spsoap:checkoutToLocal', writeable)
        end

        def description!(description)
          @node.add('spsoap:description', description)
        end

        def list_item_id!(id)
          @node.add('spsoap:listItemID',id)
        end

        def list_name!(title)
          @node.add('spsoap:listName',title)
        end

        def since!(date)
          @node.add('spsoap:since',date)
        end

        def template_id!(template_id)
          @node.add('spsoap:templateID',template_id)
        end

        def updates!(batch)
          @node.add('spsoap:updates') do |updates|
            Batch.build(updates,batch)
          end
        end

        def batch!(batch)
          @node.add('Batch') do |b|
            batch.each_pair do |k,v|
              b.add('Method') do |meth|
                meth.set_attr('ID', k)
                meth.set_attr('Cmd',v[:Cmd])
                v[:fields].each_pair do |fk,fv|
                  meth.add('Field',fv) do |field|
                    field.set_attr('Name',fk.to_s)
                  end
                end
              end
              #     meth_id1 => {:Cmd => 'New', :fields => {:Title => 'My test title'}}
            end
          end
        end
      end # EwsBuilder
    end # SOAP
  end # SPWS
end # Viewpoint
