test_regress_sources = files('scanner/regress.c')
test_regress_headers = files('scanner/regress.h')
test_marshalling_sources = files('gimarshallingtests.c')
test_marshalling_headers = files('gimarshallingtests.h')

install_data(
  test_regress_sources,
  test_regress_headers,
  test_marshalling_sources,
  test_marshalling_headers,
  'gitestmacros.h',
  install_dir : join_paths (gidatadir, 'tests'))

test_regress_incdirs = include_directories(['.', 'scanner'])

### TODO: actually test
