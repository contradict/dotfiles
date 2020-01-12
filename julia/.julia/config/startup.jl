ENV["PYTHON"] = ""
ENV["JULIA_REVISE_INCLUDE"] = 1

using Logging

macro install_and_use(pkgname)
    return quote
        local e
        try
            @eval using Pkg
            haskey(Pkg.installed(), $(string(pkgname))) || @eval Pkg.add($(string(pkgname)))
            @eval using $pkgname
        catch e
            @warn "Error at initial setup of " * $(string(pkgname)) * ": $(e.msg)"
        end
    end
end

atreplinit() do repl
    @install_and_use Revise
    try
        @async Revise.wait_steal_repl_backend()
    catch e
        @warn "Unable to initialize Revise: $(e.msg)"
    end
    @install_and_use OhMyREPL
end
