const nomad_archive = joinpath(@__DIR__, "downloads", "NOMAD.zip")

builddir = @__DIR__

nomad_path = joinpath(builddir,"nomad.3.9.1")

if ispath(nomad_path)
	error("NOMAD.jl building error : nomad folder already exists, first remove it before building anew")
end

run(`unzip $nomad_archive -d $builddir`)

nomad_path = joinpath(builddir,"nomad.3.9.1")

ENV["NOMAD_HOME"] = nomad_path

cd(nomad_path)

cp(joinpath(builddir,"downloads","patches","Extended_Poll.cpp"),joinpath(nomad_path,"src","Extended_Poll.cpp"),force=true)
cp(joinpath(builddir,"downloads","patches","NelderMead_Search.cpp"),joinpath(nomad_path,"src","NelderMead_Search.cpp"),force=true)

run(`./configure`)

cp(joinpath(builddir,"downloads","patches","Makefile"),joinpath(nomad_path,"src","Makefile"),force=true)

run(`make`)

#cd(joinpath(nomad_path,"src"))

#run(`make all`)
