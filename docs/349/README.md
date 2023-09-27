# Example for how to build a KEG for use with google docs

Converting all the KEG nodes to google document files is a hacky way to get a
KEG on google drive. Some know problems with this approach is that the docx
files cannot really be save in git.

One use case that I found to be super slick with this is that I can share my
private notes. I can find the node that I want to share, get the link, and then
give the link to who ever.

Here is an example make file that I have that build the whole tree in the
directory **output**.

```makefile
MAKEFLAGS += --jobs=$(shell getconf _NPROCESSORS_ONLN)

PANDOC_OPTIONS =
PANDOC_HTML_OPTIONS =
PANDOC_DOCX_OPTIONS =

BUILD_DIR := ./output

NODES := $(shell find . -name '*.md')
SRC_OBJS := $(shell find docs -type f ! -name '*.md')
OBJS := $(SRC_OBJS:%=$(BUILD_DIR)/%)

DOCX := $(NODES:%.md=$(BUILD_DIR)/%.docx)
HTML := $(NODES:%.md=$(BUILD_DIR)/%.html)

all: $(DOCX) $(OBJS)

HEADER = $(shell head -n 1 $< | cut -c 3- | sed 's/"/\\"/g')
NODE = $(shell echo "$<" | awk -F'/' '{print $(NF-1)}')

$(BUILD_DIR)/%.docx: %.md
	mkdir -p $(dir $@)
	pandoc -s -f gfm -t docx --metadata title="$<" --resource-path "$(dir $<)" -o $@ $<

$(BUILD_DIR)/%.html: %.md
	mkdir -p $(dir $@)
	pandoc -s -f gfm -t docx --metadata title="$<" --resource-path "$(dir $<)" -o $@ $<

$(OBJS): $(BUILD_DIR)/%: %
	mkdir -p $(dir $@)
	cp $< $@

$(DOCX) $(OBJS): | $(BUILD_DIR)

$(BUILD_DIR):
	mkdir -p $@

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)
```
