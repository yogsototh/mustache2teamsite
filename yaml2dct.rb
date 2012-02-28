#!/usr/bin/env ruby

require "yaml"
require "deepmergecore"

module DeepMerge
  module DeepMergeHash
    # ko_hash_merge! will merge and knockout elements prefixed with DEFAULT_FIELD_KNOCKOUT_PREFIX
    def ko_deep_merge!(source, options = {})
      default_opts = {:knockout_prefix => "--", :preserve_unmergeables => false}
      DeepMerge::deep_merge!(source, self, default_opts.merge(options))
    end

    # deep_merge! will merge and overwrite any unmergeables in destination hash
    def deep_merge!(source, options = {})
      default_opts = {:preserve_unmergeables => false}
      DeepMerge::deep_merge!(source, self, default_opts.merge(options))
    end

    # deep_merge will merge and skip any unmergeables in destination hash
    def deep_merge(source, options = {})
      default_opts = {:preserve_unmergeables => true}
      DeepMerge::deep_merge!(source, self, default_opts.merge(options))
    end

  end # DeepMergeHashExt
end

class Hash
  include DeepMerge::DeepMergeHash
end

# DCT PART
prefix=%{<?xml version="1.0" encoding="utf-8" ?>
<data-capture-requirements type="content" name="standard">
    <ruleset name="standard">
    <description>ylabeltable(Metapage)</description>
    <item name="langue" pathid="langue">
        <label>Entry Language</label>
        <description>ylabelbold(The language in which the page is published)</description>
        <database deploy-column="f"/>
        <select required="t">
            <inline command="/IW/iw-home/iw-perl/bin/iwperl /IW/iw-home/local/config/b2c_dev/inline/af_langue.ipl"/>
        </select>
    </item>
    <!-- ######## START ######### -->}
suffix=%{
    <!-- ######### END ########## -->
    <script language="javascript" location="template-type" src="js/lockSelects.js"></script>
    <script language="Javascript">// <![CDATA[
        function collapseEverything() {
            IWDatacapture.getItem("/content").setCollapsed(true);
        }
        $(document).ready(function() {
            collapseEverything();
        });
    // ]]>
    </script>
    </ruleset>
</data-capture-requirements>
}


def boolDCT(name)
    %{
    <item name="#{name}" pathid="#{name}">
        <label>#{name}</label>
        <description></description>
        <checkbox required="f">
            <option value="#{name}" label="" selected="f"/>
        </checkbox>
    </item>}
end
def stringDCT(name)
    %{
    <item name="#{name}" pathid="#{name}">
        <label>#{name}</label>
        <description></description>
        <text required="#{name}" size="80"/>
    </item>}
end
def hashDCT(name,content)
    %{
    <container name="#{name}" pathid="#{name}">#{
        content.gsub(/^/,'    ')}
    </container>}
end
def arrayDCT(name,content)
    %{
    <container name="#{name}" pathid="#{name}" min="0" max="65535">#{
        content.gsub(/^/,'    ')}
    </container>}
end

def yamlObj2XML( obj, tab="" ) 
    res=""
    obj.each do |k,v|
        case v
        when TrueClass
            res <<= boolDCT(k)
        when String
            res <<= stringDCT(k)
        when Hash
            content=yamlObj2XML(v,"#{tab}  ")
            res <<= hashDCT(k,content)
        when Array
            case v[0]
            when Hash
                merged={}
                v.each do |h| 
                    merged=merged.deep_merge(h)
                end
                content=yamlObj2XML(merged,"#{tab}  ")
                res <<= arrayDCT("#{k}", content)
            else
                yamlObj2XML(v,"#{tab}  ")
            end
        else
            puts "Else: #{v.class}"
        end
    end
    return res
end

filename=ARGV[0]
puts prefix
puts yamlObj2XML(YAML::load_file(filename))
puts suffix
