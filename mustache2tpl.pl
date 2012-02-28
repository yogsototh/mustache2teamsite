#!/usr/bin/perl -p

BEGIN{print '<?xml version="1.0" encoding="utf-8"?><iw_pt><iw_perl><![CDATA[ sub protect { s#&#&amp;#g ; s#<#&lt;#; s#>#&gt;#g ; } ]]></iw_perl><![CDATA[';
    my $i=0;
    $pref="dcr";
}
my $close=']]>';
my $open='<![CDATA[';
# directories
s#{{jsdir}}#/FR/common/common/js/metapage#g;
s#{{cssdir}}#/FR/common/common/css/metapage#g;
s#{{imgdir}}#/FR/common/common/img/metapage#g;
# general

# {{# iteration }}
if (m!{{\#([^}]*)}}\s*$!) {
    $old=$pref;
    $pref .= "L"; 
    s!{{\#([^}]*)}}\s*$!$close<iw_iterate var="$pref" list="$old.$1">$open!g;
}

# if must be on one line!
# {{# if }}
for (my $count=3; $count>0 ; $count--) {
    s!{{\#([^}]*)}}(.*?){{/\1}}!$close<iw_if expr="{iw_value name='$pref.$1' /}"><iw_then>$open$2$close</iw_then></iw_if>$open!g;
    s!{{\^([^}]*)}}(.*?){{/\1}}!$close<iw_if expr="\!{iw_value name='$pref.$1' /}"><iw_then>$open$2$close</iw_then></iw_if>$open!g;
}

# {{{...}}}
s#{{{([^\#\^\/][^}]*)}}}#$close<iw_value name="$pref.$1"/>$open#g;

# {{...}}
s#{{([^\#\^\/][^}]*)}}#$close<iw_ostream filter="protect()"><iw_value name="$pref.$1"/></iw_ostream>$open#g;

# {{/ iteration }}
if (m!{{\/([^}]*)}}\s*$!) {
    chop($pref);
    s!{{\/([^}]*)}}!$close</iw_iterate>$open!g;
}


END{print $close."</iw_pt>\n";}
