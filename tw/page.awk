#!/usr/bin/awk -f
# page.awk -- transform .page to .html
BEGIN{
	RS="\xC"
}
{
	if(NR==1) {
		FS="\n"
		print "divert(-1)"
		print "divert"
		print "__begin([" $1 "],[__TITLE])"
		print "__title([" $1 "])"
		print "__crumb([" $1 "])"
	} else if(NR==2) {
		FS="\n\n"
		for(i=1;i<=NF;i++) {
			if ($i ~ /^[< ]/) { print $i }
			else if ($i ~ /^[:space:]+$/) { continue }
			else { print "<p>" $i "</p>" }
		}
	} else if(NR==3) {
		FS="\n";
		for(i=1;i<=NF;i++) {
			if($i ~ /^fn/) {
				split($i,fn,":")
				print ""
				print "define([__FNLSTTITLE],["\
					fn[3] "])"
				print "define([__FNLSTHLVL],[h"\
					fn[2] "])"
				print "__fnlst"
			}
		}
		
	}
}
