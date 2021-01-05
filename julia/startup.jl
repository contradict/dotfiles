ENV["PYTHON"] = ""
ENV["JULIA_REVISE_INCLUDE"] = 1

let history_file="./.repl_history.jl"
    if isfile(history_file) || islink(history_file)
        ENV["JULIA_HISTORY"] = history_file
    end
end

atreplinit() do repl
    try
        @eval using OhMyREPL
        @eval using Revise
        @async Revise.wait_steal_repl_backend()
        # https://github.com/KristofferC/OhMyREPL.jl/issues/166
        @async begin
            sleep(2)
            OhMyREPL.Prompt.insert_keybindings()
        end
    catch e
        print(e)
    end
end
