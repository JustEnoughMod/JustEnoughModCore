project('JustEnoughModCore', 'cpp',
  version : '0.1',
  default_options : ['warning_level=3',
                     'cpp_std=c++20',
                     'optimization=3'])

add_project_arguments('-D_GLIBCXX_USE_CXX11_ABI=0', language : 'cpp')

jem_proj = subproject('JustEnoughMod')
jem_dep = jem_proj.get_variable('jem_dep')

library('JustEnoughModCore', 'src/CorePlugin.cpp',
  dependencies: [
    jem_dep
  ])
