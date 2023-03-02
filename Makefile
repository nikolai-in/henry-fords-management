BASE_NAME = henry-fords-management
SRC_DIR = src
OUTPUT_DIR = output

HTML = $(OUTPUT_DIR)/$(BASE_NAME).html
XML = $(OUTPUT_DIR)/$(BASE_NAME).xml
PDF = $(OUTPUT_DIR)/$(BASE_NAME).pdf
DOCX = $(OUTPUT_DIR)/$(BASE_NAME).docx
EPUB = $(OUTPUT_DIR)/$(BASE_NAME).epub
MD = $(OUTPUT_DIR)/$(BASE_NAME).md

ASCIIDOCTOR = asciidoctor
ASCIIDOCTOR_PDF = asciidoctor-pdf
ASCIIDOCTOR_EPUB3 = asciidoctor-epub3
PANDOC = pandoc

.PHONY: all clean prepare

all: $(HTML) $(XML) $(PDF) $(DOCX) $(EPUB) $(MD)

$(HTML): $(SRC_DIR)/$(BASE_NAME).adoc | prepare
	$(ASCIIDOCTOR) -o $@ -r asciidoctor-diagram -a docinfo1 $<

$(PDF): $(SRC_DIR)/$(BASE_NAME).adoc | prepare
	$(ASCIIDOCTOR_PDF) -o $@ -r asciidoctor-diagram -a docinfo1 $<

$(EPUB): $(SRC_DIR)/$(BASE_NAME).adoc | prepare
	$(ASCIIDOCTOR_EPUB3) -o $@ -r asciidoctor-diagram -a docinfo1 $<

$(XML): $(SRC_DIR)/$(BASE_NAME).adoc | prepare
	$(ASCIIDOCTOR) -b docbook5 -d article -o $@  $<

$(DOCX): $(XML) | prepare
	$(PANDOC) -f docbook -t docx -o $@ $<

$(MD): $(XML) | prepare
	$(PANDOC) -f docbook -t gfm -s --toc -o $@ $<

prepare:
	mkdir -p $(OUTPUT_DIR)

clean:
	rm -rf $(OUTPUT_DIR)
