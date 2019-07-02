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
	RS="\xC"
	FS="\n"
}
{
	# First record is for the header.
	if(NR==1){
		print $1 "\n" $2; # $0 adds trailing newline.
		print "\xC";
		split(FILENAME, filnams, ".");
		filnam = filnams[1];
		print "<div style='text-align: center;'>"\
			"Syndication: __link([ATOM],["   \
			filnam ".atom.xml])</div>";
		print "<ul id='articles'>"
	}
	# Directly include into target `.txt' page.
	else if(NR==2) {
		print;
	}
	else {
		sub("^\n", "")	# Delete leading empty line.
		fil1 = $1;
		desc = $2;
		file = fil1 ".txt";
		link = fil1 ".html";
		getline < file ;
		close(file);
		print "<li><h3>"
		# $3 is the date field from `file'.
		if($3!="") {
			print "<span class='date'>["\
				$3 "]</span>";
		}
		# $2 is the title field from `file'.
		print " __link([" $2 "],[" link "])</h3>";
		if(desc!="") {
			print "<p>" desc "</p>";
		}
		print "</li><hr/>";
	}
}
END { print "</ul>" }
