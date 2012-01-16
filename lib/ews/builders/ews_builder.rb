=begin
  This file is part of Viewpoint; the Ruby library for Microsoft Exchange Web Services.

  Copyright © 2011 Dan Wanek <dan.wanek@gmail.com>

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
=end
module Viewpoint::EWS::SOAP

  # This module includes the element builders. The idea is that each element should
  # know how to build themselves so each parent element can delegate creation of
  # subelements to a method of the same name with a '!' after it.
  module XmlBuilder

    # Build XML from a passed in Hash or Array in a specified format.
    # @param [Nokogiri::XML::Builder] builder The builder we are using to construct the XML
    # @param [Array,Hash] elems The elements to add to the Builder. They must be specified
    #   like so:
    #   {:top =>
    #     { :xmlns => 'http://stonesthrow/soap',
    #       :sub_elements => [
    #         {:elem1 => {:text => 'inside'}},
    #         {:elem2 => {:text => 'inside2'}}
    #       ],
    #       :id => '3232', :tx_dd => 23, :asdf => 'turkey'
    #     }
    #   }
    #   or
    #   [ {:first => {:text => 'hello'}},
    #     {:second => {:text => 'world'}}
    #   ]
    #
    #   NOTE: there are specialized keys for text (:text), child elements (:sub_elements) and
    #   namespaces (:xmlns).
    def build_xml!(builder, elems)
      case elems.class.name
      when 'Hash'
        keys = elems.keys
        vals = elems.values
        if(keys.length > 1 && !vals.is_a?(Hash))
          raise "invalid input: #{elems}"
        end
        vals = vals.first.clone
        se = vals.delete(:sub_elements)
        txt = vals.delete(:text)
        ns = vals.delete(:xmlns)

        builder.send(keys.first.to_s.camel_case, txt, vals) {
          builder.parent.default_namespace = ns if ns
          build_xml!(builder, se) if se
        }
      when 'Array'
        elems.each do |e|
          build_xml!(builder, e)
        end
      else
        raise "Unsupported type: #{elems.class.name}"
      end
    end

    # Build the FolderShape element
    # @see http://msdn.microsoft.com/en-us/library/aa494311.aspx
    # @param [Nokogiri::XML::Builder] node The XML builder object
    # @param [Hash] folder_shape The folder shape structure to build from
    # @TODO This only supports the FieldURI extended property right now
    def folder_shape!(node, folder_shape)
      node.FolderShape {
        node.parent.default_namespace = @default_ns
        base_shape!(node, folder_shape[:base_shape])
        additional_properties!(node,folder_shape[:additional_properties]) if(folder_shape[:additional_properties])
      }
    end

    # Build the ItemShape element
    # @see http://msdn.microsoft.com/en-us/library/aa565261.aspx
    # @param [Nokogiri::XML::Builder] node The XML builder object
    # @param [Hash] item_shape The item shape structure to build from
    def item_shape!(node, item_shape)
      node[NS_EWS_MESSAGES].ItemShape {
        base_shape!(node, item_shape[:base_shape])
        additional_properties!(node,item_shape[:additional_properties]) if(item_shape[:additional_properties])
      }
    end

    # Build the BaseShape element
    # @see http://msdn.microsoft.com/en-us/library/aa580545.aspx
    def base_shape!(node, base_shape)
      node[NS_EWS_TYPES].BaseShape(base_shape)
    end

    # Build the ParentFolderIds element
    # @see http://msdn.microsoft.com/en-us/library/aa565998.aspx
    def parent_folder_ids!(node, pfids)
      node[NS_EWS_MESSAGES].ParentFolderIds {
        pfids.each do |pfid|
          dispatch_folder_id!(node, pfid)
        end
      }
    end

    # Build the ParentFolderId element
    # @see http://msdn.microsoft.com/en-us/library/aa563268.aspx
    def parent_folder_id!(node, pfid)
      node.ParentFolderId {
        dispatch_folder_id!(node, pfid)
      }
    end

    # Build the FolderIds element
    # @see http://msdn.microsoft.com/en-us/library/aa580509.aspx
    def folder_ids!(node, fids, act_as=nil)
      node.FolderIds {
        node.parent.default_namespace = @default_ns
        fids.each do |fid|
          dispatch_folder_id!(node, fid)
        end
      }
    end

    # Build the DistinguishedFolderId element
    # @see http://msdn.microsoft.com/en-us/library/aa580808.aspx
    # @TODO add support for the Mailbox child object
    def distinguished_folder_id!(node, dfid, change_key = nil, act_as = nil)
      attribs = {'Id' => dfid.to_s}
      attribs['ChangeKey'] = change_key if change_key
      node[NS_EWS_TYPES].DistinguishedFolderId(attribs) {
        mailbox!(node, {:email_address => {:text => act_as}}, NS_EWS_TYPES) unless act_as.nil?
      }
    end

    # Build the FolderId element
    # @see http://msdn.microsoft.com/en-us/library/aa579461.aspx
    def folder_id!(node, fid, change_key = nil)
      attribs = {'Id' => fid}
      attribs['ChangeKey'] = change_key if change_key
      node[NS_EWS_TYPES].FolderId(attribs)
    end

    def to_folder_id!(node, to_fid)
      node[NS_EWS_MESSAGES].ToFolderId {
        dispatch_folder_id!(node, to_fid)
      }
    end

        # Build the Folders element
    # @see http://msdn.microsoft.com/en-us/library/aa564009.aspx
    def folders!(node, folders)
      node[NS_EWS_TYPES].Folders {
        build_xml!(node, folders)
      }
    end

    # Build the AdditionalProperties element
    # @see http://msdn.microsoft.com/en-us/library/aa563810.aspx
    def additional_properties!(node, addprops)
      node[NS_EWS_TYPES].AdditionalProperties {
        if(folder_shape[:additional_properties][:FieldURI])
          folder_shape[:additional_properties][:FieldURI].each do |uri|
            node[NS_EWS_TYPES].FieldURI('FieldURI' => uri)
          end
        end
      }
    end

    # Build the Mailbox element.
    # This element is commonly used for delegation. Typically passing an email_address is sufficient
    # @see http://msdn.microsoft.com/en-us/library/aa565036.aspx
    # @param [Hash] mailbox A well-formated hash that can be passed to build_xml!
    #   For example: {:email_address => {:text => 'test@test.com'}, :name => {:text => 'Test User'}}
    # @TODO support the rest of the child elements
    def mailbox!(node, mbox)
      node[NS_EWS_MESSAGES].Mailbox {
        build_xml!(node, mbox)
      }
    end

    # Build the Restriction element
    # @see http://msdn.microsoft.com/en-us/library/aa563791.aspx
    # @param [Nokogiri::XML::Builder] node
    # @param [Hash] restriction a well-formatted Hash that can be fed to #build_xml!
    def restriction!(node, restriction)
      bhash = {:Restriction =>
        { :xmlns => NAMESPACES[NS_EWS_TYPES],
          :sub_elements => [restriction]}
      }
      build_xml!(node, restriction)
    end

    # Build the CalendarView element
    def calendar_view!(node, cal_view)
      attribs = {}
      cal_view.each_pair {|k,v| attribs[k.to_s.camel_case] = v.to_s}
      node[NS_EWS_MESSAGES].CalendarView(attribs)
    end

    # Build the ContactsView element
    def contacts_view!(node, con_view)
      attribs = {}
      con_view.each_pair {|k,v| attribs[k.to_s.camel_case] = v.to_s}
      node[NS_EWS_MESSAGES].ContactsView(attribs)
    end



    # ---------------------- Helpers -------------------- #


    # A helper method to dispatch to a FolderId or DistinguishedFolderId correctly
    # @param [Hash] fid {:id => myid, :change_key => ck}
    def dispatch_folder_id!(node, fid)
      if(fid[:id].is_a?(String))
        folder_id!(node, fid[:id], fid[:change_key])
      elsif(fid[:id].is_a?(Symbol))
        distinguished_folder_id!(node, fid[:id], fid[:change_key], fid[:act_as])
      else
        raise EwsBadArgumentError, "Bad argument given for a FolderId. #{fid[:id].class}"
      end
    end

  end # XmlBuilder
end # Viewpoint::EWS::SOAP
