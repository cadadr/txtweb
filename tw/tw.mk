# makefile -- Build the website.

include config.mk

# Common templates for each output file.
MACROES=$(TWDIR)/html.m4 config.m4
# ‘-’ is for stdin.
TMPL=header.html.m4 $(MACROES) $(TWDIR)/meta.m4 - footer.html.m4
PAGES+=$(LISTS)
FEEDS=$(LISTS:=.xml)
OUT= $(PAGES:=.html) $(FEEDS) $(LISTS:=.page)

all: $(OUT)

%.page: %.list
	$(AWK) -f $(TWDIR)/list.awk $+ > $@

%.xml: %.list
	$(AWK) -f $(TWDIR)/rss.awk $+ | $(M4) $(MACROES) - | $(SED) '1,2d' > $@

%.html: %.page
	$(AWK) -f $(TWDIR)/page.awk $+ | $(M4) -D__FILE__=$@ $(TMPL) - > $@

clean:
	rm -f $(OUT)

.PHONY: build all clean

include make.local
