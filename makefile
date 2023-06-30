MAKEFLAGS += --jobs=$(shell getconf _NPROCESSORS_ONLN)

PANDOC_OPTIONS =
PANDOC_HTML_OPTIONS =
PANDOC_DOCX_OPTIONS =

BUILD_DIR := ./output

NODES := $(shell find docs -name 'README.md')
SRC_OBJS := $(shell find docs -type file ! -name 'README.md')
OBJS := $(SRC_OBJS:%=$(BUILD_DIR)/%)

DOCX := $(NODES:%.md=$(BUILD_DIR)/%.docx)

all: $(DOCX) $(OBJS)

HEADER = $(shell head -n 1 $< | cut -c 3- | sed 's/"/\\"/g')

$(BUILD_DIR)/%.docx: %.md
	mkdir -p $(dir $@)
	pandoc -s -f gfm -t docx --metadata title="$(HEADER)" --resource-path "$(dir $<)" -o $@ $<

$(OBJS): $(SRC_OBJS)
	mkdir -p $(dir $@)
	cp $< $@

$(DOCX) $(OBJS): | $(BUILD_DIR)

$(BUILD_DIR):
	mkdir -p $@

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)
