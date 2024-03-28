import Pkg

Pkg.Registry.add(Pkg.RegistrySpec(url="https://github.com/cossio/CossioJuliaRegistry.git"))
Pkg.Registry.add("General")

# add some packages to global env
Pkg.activate()
Pkg.add([
    "MyRegistrator",
    "Revise",
])

# instantiate project
Pkg.activate(pwd())
Pkg.update()
