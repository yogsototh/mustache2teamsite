#!/usr/bin/env ruby

require "yaml"

filename=ARGV[0]
dcrname=ARGV[1]

# DCR PART
prefix=%{<?xml version="1.0" encoding="utf-8" ?>
<!DOCTYPE record SYSTEM "dcr4.5.dtd">
<record name="#{dcrname}">
  <item name="langue">
    <value>fr</value>
  </item>}
suffix=%{</record>}

def boolDCR(name,value)
    if value then
        %{<item name="#{name}"><value>#{name}</value></item>}
    else
        %{<item name="#{name}"/>}
    end
end
def protect(str)
    str.gsub('&','&amp;').gsub('<','&lt;').gsub('>','&gt;')
end
def stringDCR(name,value)
    %{
    <item name="#{name}">
        <value>#{protect value}</value>
    </item>}
end
def hashDCR(name,content)
    %{
    <item name="#{name}">
        <value>#{
            content.gsub(/^/,'    ')}
        </value>
    </item>}
end
def arrayDCR(name,content)
    %{
    <item name="#{name}">#{
            content.gsub(/^/,'    ')}
    </item>}
end

def yamlObj2XML( obj, tab="" ) 
    res=""
    obj.each do |k,v|
        case v
        when TrueClass
            res <<= boolDCR(k,v)
        when String
            res <<= stringDCR(k,v)
        when Hash
            content=yamlObj2XML(v,"#{tab}  ")
            res <<= hashDCR(k,content)
        when Array
            content=""
            v.each do |o|
                content<<=%{
    <value>
        #{yamlObj2XML(o,"#{tab}  ")}
    </value>}
            end
            res <<= arrayDCR("#{k}", content)
        else
            puts "Else: #{v.class}"
        end
    end
    return res
end

puts prefix
puts yamlObj2XML(YAML::load_file(filename))
puts suffix
