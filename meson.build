project('JustEnoughModCore', 'cpp',
  version : '0.0.1',
  default_options : ['cpp_std=c++20'])

add_project_arguments('-DVERSION="@0@"'.format(meson.project_version()), language : 'cpp')

jem_proj = subproject('JustEnoughMod')
jem_dep = jem_proj.get_variable('jem_dep')

library('JustEnoughModCore', 'src/CorePlugin.cpp',
  dependencies: [
    jem_dep
  ])
