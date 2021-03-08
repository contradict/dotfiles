ENV["PYTHON"] = ""
ENV["JULIA_REVISE_INCLUDE"] = 1

let history_file=".repl_history.jl"
    project_path=dirname(Base.active_project())
    history_path=joinpath(project_path, history_file)
    if isfile(history_path) || islink(history_path)
        ENV["JULIA_HISTORY"] = history_path
    end
end

try
    using Revise
catch e
    print(e)
end

try
    using ImageInTerminal
catch e
    print(e)
end

try
    using OhMyREPL
catch e
    print(e)
end

try
    # https://github.com/KristofferC/OhMyREPL.jl/issues/166
    @async begin
        sleep(2)
        OhMyREPL.Prompt.insert_keybindings()
    end
catch e
    print(e)
end
