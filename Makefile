LIBDIR := lib
include $(LIBDIR)/main.mk

$(LIBDIR)/main.mk:
ifneq (,$(shell grep "path *= *$(LIBDIR)" .gitmodules 2>/dev/null))
	git submodule sync
	git submodule update --init
else
ifneq (,$(wildcard $(ID_TEMPLATE_HOME)))
	ln -s "$(ID_TEMPLATE_HOME)" $(LIBDIR)
else
	git clone -q --depth 10 -b main \
	    https://github.com/martinthomson/i-d-template $(LIBDIR)
endif
endif

include_sources := $(wildcard sections/*.md considerations/*.md appendix/*.md boilerplate/*.md examples/*/*)

.PHONY: lint-includes fix-lint-includes
lint-includes:
	@! grep -n ' \r*$$' $(include_sources) || ! echo "*** Trailing whitespace in included sources; run 'make fix-lint'" 1>&2
lint:: lint-includes

fix-lint-includes:
	perl -pi -e 's/ +$$//' $(include_sources)
fix-lint:: fix-lint-includes
