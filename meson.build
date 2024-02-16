project('JustEnoughModCore', 'cpp',
  version : '0.1',
  default_options : ['warning_level=3',
                     'cpp_std=c++20',
                     'optimization=g'])

jem_proj = subproject('JustEnoughMod')
jem_dep = jem_proj.get_variable('jem_dep')

library('JustEnoughModCore', 
  dependencies: [
    jem_dep
  ])
