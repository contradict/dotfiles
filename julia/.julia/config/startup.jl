ENV["PYTHON"] = ""
ENV["JULIA_REVISE_INCLUDE"] = 1
atreplinit() do repl
    try
        @eval using OhMyREPL
        @eval using Revise
        @async Revise.wait_steal_repl_backend()
    catch e
        print(e)
    end
end