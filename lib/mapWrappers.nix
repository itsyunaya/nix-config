# given adios modules and a list of wrapper names, this
# function will map them to `{wrappers}.{wrapper-name}.drv`. 
# exists because writing it out every time is super annoying
_: let
	mapWrappers = w: xs: map (x: w.${x}.drv) xs;
in
	mapWrappers
