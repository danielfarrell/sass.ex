ERLANG_PATH:=$(shell erl -eval 'io:format("~s~n", [lists:concat([code:root_dir(), "/erts-", erlang:system_info(version), "/include"])])' -s init stop -noshell)
CFLAGS_SASS=-g -fPIC -O3
CFLAGS=$(CFLAGS_SASS) -Ilibsass_src
ERLANG_FLAGS=-I$(ERLANG_PATH)
CC?=clang
EBIN_DIR=ebin

ifeq ($(shell uname),Darwin)
	OPTIONS=-dynamiclib -undefined dynamic_lookup
endif

NIF_SRC=\
	src/sass_nif.c

SASS_OBJS=\
	libsass_src/ast.o \
	libsass_src/base64vlq.o \
	libsass_src/bind.o \
	libsass_src/constants.o \
	libsass_src/context.o \
	libsass_src/contextualize.o \
	libsass_src/copy_c_str.o \
	libsass_src/emscripten_wrapper.o \
	libsass_src/error_handling.o \
	libsass_src/eval.o \
	libsass_src/expand.o \
	libsass_src/extend.o \
	libsass_src/file.o \
	libsass_src/functions.o \
	libsass_src/inspect.o \
	libsass_src/output_compressed.o \
	libsass_src/output_nested.o \
	libsass_src/parser.o \
	libsass_src/prelexer.o \
	libsass_src/sass.o \
	libsass_src/sass_interface.o \
	libsass_src/sass2scss/sass2scss.o \
	libsass_src/source_map.o \
	libsass_src/to_c.o \
	libsass_src/to_string.o \
	libsass_src/units.o \
	libsass_src/utf8_string.o \
	libsass_src/util.o

SASS_LIB=libsass_src/libsass.a

all: sass_ex

priv/sass.so: ${SASS_LIB} ${NIF_SRC}
	mkdir -p priv && \
	$(CC) $(CFLAGS) $(ERLANG_FLAGS) -shared $(OPTIONS) \
		$(SASS_OBJS) \
		$(NIF_SRC) \
		-o $@ 2>&1 >/dev/null

sass_ex:
	mix compile

$(SASS_LIB):
	cd libsass_src && \
	CFLAGS="$(CFLAGS_SASS)" $(MAKE) 2>&1 >/dev/null

libsass_src/configure.sh:
	git submodule update --init

libsass_src-clean:
	test ! -f $(SASS_LIB) || \
	  (cd libsass_src && $(MAKE) clean)

sass_ex-clean:
	rm -rf $(EBIN_DIR) test/tmp share/* _build

sass_nif-clean:
	rm -rf priv/sass.*

docs:
	MIX_ENV=docs mix do clean, deps.get, compile, docs

docs-clean:
	rm -rf docs

test:
	MIX_ENV=test mix do clean, deps.get, compile, test

clean: libsass_src-clean sass_ex-clean sass_nif-clean docs-clean

.PHONY: all sass_ex clean distclean libsass_src-clean libsass_src-distclean test
