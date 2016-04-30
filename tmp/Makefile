#
#
RUBY=ruby
TARGETS=$(wildcard *_[0-9][0-9][0-9].pic)
PS_TARGETS=$(TARGETS:.pic=.ps)
EPS_TARGETS=$(TARGETS:.pic=.epsi)
FINAL_TARGETS=$(TARGETS:.pic=.png)
TROFF=groff -p
CAT=cat
PSTOEPS=ps2epsi
CONVERT=convert -density 300x300
RUBY_SCRIPT=test.rb

all: do_the_pics $(FINAL_TARGETS)
	
do_the_pics:
	$(RUBY) $(RUBY_SCRIPT)

clean:
	$(RM) $(TARGETS) $(FINAL_TARGETS)

.PHONY: do_the_pics clean

.SUFFIXES: .png .pic

%.png: %.pic
	$(CAT) $< | $(TROFF) > $*.ps
	$(PSTOEPS) $*.ps
	$(CONVERT) $*.epsi $@
	$(RM) $*.ps $*.epsi
