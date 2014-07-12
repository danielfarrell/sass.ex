#include <string.h>
#include "../libsass_src/sass_interface.h"
#include "erl_nif.h"

static inline ERL_NIF_TERM make_atom(ErlNifEnv* env, const char* name)
{
  ERL_NIF_TERM ret;
  if(enif_make_existing_atom(env, name, &ret, ERL_NIF_LATIN1)) {
    return ret;
  }
  return enif_make_atom(env, name);
}

static inline ERL_NIF_TERM make_tuple(ErlNifEnv* env, const char* mesg, const char* atom_string)
{
      int output_len = sizeof(char) * strlen(mesg);
      ErlNifBinary output_binary;
      enif_alloc_binary(output_len, &output_binary);
      strncpy((char*)output_binary.data, mesg, output_len);
      ERL_NIF_TERM atom = make_atom(env, atom_string);
      ERL_NIF_TERM str = enif_make_binary(env, &output_binary);
      return enif_make_tuple2(env, atom, str);
}

static ERL_NIF_TERM sass_compile_nif(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    ErlNifBinary input_binary;
    ERL_NIF_TERM ret;

    if (argc != 1) {
      return enif_make_badarg(env);
    }

    if(!enif_inspect_binary(env, argv[0], &input_binary)){
      return enif_make_badarg(env);
    }

    struct sass_context* ctx = sass_new_context();
    ctx->options.include_paths = "";
    ctx->options.output_style = SASS_STYLE_NESTED;
    ctx->source_string = (char*)input_binary.data;

    sass_compile(ctx);

    if (ctx->error_status) {
      if (ctx->error_message) {
        ret = make_tuple(env, ctx->error_message, "error");
      } else {
        ret = make_tuple(env, "An error occured; no error message available.", "error");
      }
    } else if (ctx->output_string) {
      ret = make_tuple(env, ctx->output_string, "ok");
    } else {
      ret = make_tuple(env, "Unknown internal error.", "error");
    }

    sass_free_context(ctx);

    return ret;
}

static ERL_NIF_TERM sass_compile_file_nif(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    ErlNifBinary input_path;
    ERL_NIF_TERM ret;

    if (argc != 1) {
      return enif_make_badarg(env);
    }

    if(!enif_inspect_binary(env, argv[0], &input_path)){
      return enif_make_badarg(env);
    }

    struct sass_file_context* ctx = sass_new_file_context();
    ctx->options.include_paths = "";
    ctx->options.output_style = SASS_STYLE_NESTED;
    ctx->input_path = (char*)input_path.data;

    sass_compile_file(ctx);

    if (ctx->error_status) {
      if (ctx->error_message) {
        ret = make_tuple(env, ctx->error_message, "error");
      } else {
        ret = make_tuple(env, "An error occured; no error message available.", "error");
      }
    } else if (ctx->output_string) {
      ret = make_tuple(env, ctx->output_string, "ok");
    } else {
      ret = make_tuple(env, "Unknown internal error.", "error");
    }

    sass_free_file_context(ctx);

    return ret;
}

static int on_load(ErlNifEnv* env, void** priv_data, ERL_NIF_TERM load_info)
{
    return 0;
}

static ErlNifFunc nif_funcs[] = {
  { "compile", 1, sass_compile_nif },
  { "compile_file", 1, sass_compile_file_nif },
};

ERL_NIF_INIT(Elixir.Sass.Compiler, nif_funcs, NULL, NULL, NULL, NULL);
