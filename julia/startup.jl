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
    @warn "Unable to enable Revise" e
end

try
    using ImageInTerminal
catch e
    @warn "Unable to enable ImageInTerminal" e
end

try
    # https://github.com/KristofferC/OhMyREPL.jl/issues/166
    using OhMyREPL
    @async begin
        while !isdefined(Base, :active_repl)
            sleep(0.1)
        end
        try
            OhMyREPL.Prompt.insert_keybindings()
        catch e
            @warn "Unable to insert keybindings: " (e, catch_backtrace())
        end
    end
catch e
    @warn "Unable to enable OhMyREPL" e
end

atreplinit() do repl
    try
        @eval begin
            using Logging: global_logger
            using TerminalLoggers: TerminalLogger
            global_logger(TerminalLogger())
        end
    catch e
        @warn "Unable to enable TerminalLogger: " (e, catch_backtrace())
    end
end
