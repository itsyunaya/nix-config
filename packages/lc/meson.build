project(
  'lc',
  'c',
  meson_version : '>= 1.3.0',
  version : '0.1',
)

dependencies = [
  dependency('libcurl'),
]

c_args = [
  '-g',
  '-O2',
  '-U_FORTIFY_SOURCE',
  '-Wno-unused-function',
  '-Wno-unused-parameter',
  '-Wno-unused-result',
]

sources = [
  'src/main.c',
]

exe = executable(
  'lc',
  sources,
  dependencies : dependencies,
  install : true,
  c_args : c_args,
)
