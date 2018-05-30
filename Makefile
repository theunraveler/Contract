.PHONY: build clean
.DEFAULT_GOAL := build

FILESDIR := pages
HTMLDIR := html
COMPILED := contract.pdf
targets = $(patsubst $(FILESDIR)/%.md,$(HTMLDIR)/%.html,$(wildcard $(FILESDIR)/*.md))

$(targets): | $(HTMLDIR)

$(HTMLDIR):
	mkdir -p $(HTMLDIR)

$(HTMLDIR)/%.html : $(FILESDIR)/%.md
	$(MARKDOWN) "$<" > "$@"

build: $(targets)
	htmldoc --book --titlefile "$(firstword $(targets))" -f $(COMPILED) $(wordlist 2,$(words $(targets)),$(targets))

clean:
	-rm -rf $(HTMLDIR) $(COMPILED)
