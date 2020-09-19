ENV["PYTHON"] = ""
ENV["JULIA_REVISE_INCLUDE"] = 1
atreplinit() do repl
    try
        @eval using OhMyREPL
        @eval using Revise
        @async Revise.wait_steal_repl_backend()
        @async begin
            sleep(2)
            OhMyREPL.Prompt.insert_keybindings()
        end
    catch e
        print(e)
    end
end
