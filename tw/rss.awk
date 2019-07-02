#!/usr/bin/awk -f
# list.awk -- make front-pages for weblogs.
#
# Generate a .txt file ready to be processed
# to produce a front-page for the weblog, i.e.
# a list of articles.
#
# See also: atom.awk for feeds.

# Split records on ^L, fields on newline.
BEGIN {
	RS="\xC";
	FS="\n";
	print "changequote([{],[}])";
}
{
	if(NR==1){
		split(FILENAME, filnams, ".");
		filnam = filnams[1];
		print "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
		print "<rss  version=\"2.0\">";
		print "<title>" $1 " :: __TITLE</title>";
		print "<link href=\"__TOPLEVELURL{/}" filnam ".html\" rel=\"self\" />"; 
		printf "<pubDate>";
		system("date +%Y-%m-%dT%T%z | sed 's/[0-9][0-9]$/:&/' | tr -d '\\n'");
		print "</pubDate>";
	}
	else if(NR==2) {}
	else {
		sub("^\n", "")	# Delete leading empty line.
		fil1 = $1;
		desc = $2;
		file = fil1 ".txt";
		link = fil1 ".html";
		getline < file ;
		# $2 is the title field from `file'.
		print "<item>";
		print "  <title>" $2 "</title>";
		print "  <link href=\"__TOPLEVELURL{/}" link "\"/>";
		print "  <guid isPermalink=\"true\">__TOPLEVELURL{/}" link "<guid/>";
		print "  {<description><![CDATA[<html><body><p>}";
		print "  changequote({[},{]})";
		print "  " $2;
		print "  changequote([{],[}])";
		print "  {</p></html></body>]]></description>}";
		print "</item>";
	}
}
END {
	print "</rss>" 
	print "changequote({[},{]}])";
}
