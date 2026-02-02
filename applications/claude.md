---
sort: 16
---

# claude

Official page: <https://claude.ai/install.sh>

## 2.1.29

```bash
curl -fsSL https://claude.ai/install.sh | env HOME="$CEUADMIN/claude/2.1.29" bash -s -- latest
claude --help
```

with screen output

```

Setting up Claude Code...

✔ Claude Code successfully installed!

  Version: 2.1.29

  Location: ~/.local/bin/claude


  Next: Run claude --help to get started

⚠ Setup notes:
  • Native installation exists but ~/.local/bin is not in your PATH. Run:

  echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc && source ~/.bashrc

$ claude --help
Usage: claude [options] [command] [prompt]

Claude Code - starts an interactive session by default, use -p/--print for non-interactive output

Arguments:
  prompt                                            Your prompt

Options:
  --add-dir <directories...>                        Additional directories to allow tool access to
  --agent <agent>                                   Agent for the current session. Overrides the 'agent' setting.
  --agents <json>                                   JSON object defining custom agents (e.g. '{"reviewer": {"description": "Reviews code",
                                                    "prompt": "You are a code reviewer"}}')
  --allow-dangerously-skip-permissions              Enable bypassing all permission checks as an option, without it being enabled by default.
                                                    Recommended only for sandboxes with no internet access.
  --allowedTools, --allowed-tools <tools...>        Comma or space-separated list of tool names to allow (e.g. "Bash(git:*) Edit")
  --append-system-prompt <prompt>                   Append a system prompt to the default system prompt
  --betas <betas...>                                Beta headers to include in API requests (API key users only)
  --chrome                                          Enable Claude in Chrome integration
  -c, --continue                                    Continue the most recent conversation in the current directory
  --dangerously-skip-permissions                    Bypass all permission checks. Recommended only for sandboxes with no internet access.
  -d, --debug [filter]                              Enable debug mode with optional category filtering (e.g., "api,hooks" or
                                                    "!statsig,!file")
  --debug-file <path>                               Write debug logs to a specific file path (implicitly enables debug mode)
  --disable-slash-commands                          Disable all skills
  --disallowedTools, --disallowed-tools <tools...>  Comma or space-separated list of tool names to deny (e.g. "Bash(git:*) Edit")
  --fallback-model <model>                          Enable automatic fallback to specified model when default model is overloaded (only works
                                                    with --print)
  --file <specs...>                                 File resources to download at startup. Format: file_id:relative_path (e.g., --file
                                                    file_abc:doc.txt file_def:img.png)
  --fork-session                                    When resuming, create a new session ID instead of reusing the original (use with --resume
                                                    or --continue)
  --from-pr [value]                                 Resume a session linked to a PR by PR number/URL, or open interactive picker with
                                                    optional search term
  -h, --help                                        Display help for command
  --ide                                             Automatically connect to IDE on startup if exactly one valid IDE is available
  --include-partial-messages                        Include partial message chunks as they arrive (only works with --print and
                                                    --output-format=stream-json)
  --input-format <format>                           Input format (only works with --print): "text" (default), or "stream-json" (realtime
                                                    streaming input) (choices: "text", "stream-json")
  --json-schema <schema>                            JSON Schema for structured output validation. Example:
                                                    {"type":"object","properties":{"name":{"type":"string"}},"required":["name"]}
  --max-budget-usd <amount>                         Maximum dollar amount to spend on API calls (only works with --print)
  --mcp-config <configs...>                         Load MCP servers from JSON files or strings (space-separated)
  --mcp-debug                                       [DEPRECATED. Use --debug instead] Enable MCP debug mode (shows MCP server errors)
  --model <model>                                   Model for the current session. Provide an alias for the latest model (e.g. 'sonnet' or
                                                    'opus') or a model's full name (e.g. 'claude-sonnet-4-5-20250929').
  --no-chrome                                       Disable Claude in Chrome integration
  --no-session-persistence                          Disable session persistence - sessions will not be saved to disk and cannot be resumed
                                                    (only works with --print)
  --output-format <format>                          Output format (only works with --print): "text" (default), "json" (single result), or
                                                    "stream-json" (realtime streaming) (choices: "text", "json", "stream-json")
  --permission-mode <mode>                          Permission mode to use for the session (choices: "acceptEdits", "bypassPermissions",
                                                    "default", "delegate", "dontAsk", "plan")
  --plugin-dir <paths...>                           Load plugins from directories for this session only (repeatable)
  -p, --print                                       Print response and exit (useful for pipes). Note: The workspace trust dialog is skipped
                                                    when Claude is run with the -p mode. Only use this flag in directories you trust.
  --replay-user-messages                            Re-emit user messages from stdin back on stdout for acknowledgment (only works with
                                                    --input-format=stream-json and --output-format=stream-json)
  -r, --resume [value]                              Resume a conversation by session ID, or open interactive picker with optional search term
  --session-id <uuid>                               Use a specific session ID for the conversation (must be a valid UUID)
  --setting-sources <sources>                       Comma-separated list of setting sources to load (user, project, local).
  --settings <file-or-json>                         Path to a settings JSON file or a JSON string to load additional settings from
  --strict-mcp-config                               Only use MCP servers from --mcp-config, ignoring all other MCP configurations
  --system-prompt <prompt>                          System prompt to use for the session
  --tools <tools...>                                Specify the list of available tools from the built-in set. Use "" to disable all tools,
                                                    "default" to use all tools, or specify tool names (e.g. "Bash,Edit,Read").
  --verbose                                         Override verbose mode setting from config
  -v, --version                                     Output the version number

Commands:
  doctor                                            Check the health of your Claude Code auto-updater
  install [options] [target]                        Install Claude Code native build. Use [target] to specify version (stable, latest, or
                                                    specific version)
  mcp                                               Configure and manage MCP servers
  plugin                                            Manage Claude Code plugins
  setup-token                                       Set up a long-lived authentication token (requires Claude subscription)
  update                                            Check for updates and install if available
```

Note that the installer syntax is `bash install.sh [stable|latest|VERSION]`.

## Run for Free with Ollama

From

```bash
module load ceuadmin/ollama
ollama serve &
ollama list
```

We see

```
NAME                        ID              SIZE      MODIFIED
qwen3-coder:480b-cloud      e30e45586389    -         3 months ago
deepseek-v3.1:671b-cloud    d3749919e45f    -         4 months ago
gpt-oss:20b                 aa4295ac10c3    13 GB     4 months ago
llava:7b                    8dd30f6b0cb1    4.7 GB    8 months ago
phi4:latest                 ac896e5b8b34    9.1 GB    9 months ago
gemma3:latest               c0494fe00251    3.3 GB    10 months ago
qwen:latest                 d53d04290064    2.3 GB    10 months ago
mistral:latest              f974a74358d6    4.1 GB    10 months ago
vicuna:latest               370739dc897b    3.8 GB    11 months ago
```

```bash
export ANTHROPIC_AUTH_TOKEN=ollama
export ANTHROPIC_API_KEY=
export NTHROPIC_BASE_URL="http://localhost:11434"
claude --model gpt-oss:20b --allow-dangerously-skip-permissions
claude --model qwen3-coder:480b-cloud --allow-dangerously-skip-permissions
```

The first of which gives,

```
$ claude --model gpt-oss:20b --allow-dangerously-skip-permissions

╭─── Claude Code v2.1.29 ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│                                     │ Tips for getting started                                                                             │
│            Welcome back!            │ Run /init to create a CLAUDE.md file with instructions for Claude                                    │
│                                     │ ─────────────────────────────────────────────────────────────────                                    │
│                                     │ Recent activity                                                                                      │
│               ▐▛███▜▌               │ No recent activity                                                                                   │
│              ▝▜█████▛▘              │                                                                                                      │
│                ▘▘ ▝▝                │                                                                                                      │
│   gpt-oss:20b · API Usage Billing   │                                                                                                      │
│             ~/Downloads             │                                                                                                      │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯

  /model to try Opus 4.5

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
❯ Try "edit <filepath> to..."
❯ write a Python program which outputs "Hello, world!"

· Reticulating…
```
