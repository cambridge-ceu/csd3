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

## Anthropic API via Ollama

This section offers a flavour of Anthropic API from Ollama/0.15.2 onwards, whose local/cloud models can be used for free. From

```bash
module load ceuadmin/ollama/0.15.2
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
export ANTHROPIC_BASE_URL="http://localhost:11434"
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

As expected, this is very slow and we resort to the second model above,

```
$ claude --model qwen3-coder:480b-cloud --allow-dangerously-skip-permissions

>  create a kanban style app that allows the user to create/update tasks and move them between the TODO, In Progress and Completed
   sections. The app should be contained in a single HTML file with CSS and
   javascript that I can open in my browser

● I'll create a Kanban-style task management app in a single HTML file. Let me think through the structure and implementation.

● Write(kanban-app.html)
  ⎿  Wrote 461 lines to kanban-app.html
     <!DOCTYPE html>
     <html lang="en">
     <head>
         <meta charset="UTF-8">
         <meta name="viewport" content="width=device-width, initial-scale=1.0">
         <title>Kanban Board</title>
         <style>
             * {
                 box-sizing: border-box;
                 margin: 0;
     … +451 lines (ctrl+o to expand)

✽ Fiddle-faddling… (9m 29s · ↓ 389 tokens)

● I've created a complete Kanban-style task management app in a single HTML file. Here's what the app includes:
  Features:
  1. Three Columns: To Do, In Progress, and Completed
    - Add new tasks with title and description
    - Edit existing tasks
    - Delete tasks
    - Move tasks between columns
  3. Drag and Drop: Move tasks between columns by dragging
  4. Persistent Storage: Tasks are saved in your browser's localStorage
  5. Responsive Design: Works on both desktop and mobile devices

  How to Use:

  1. Add a Task:
    - Fill in the task title and description
    - Select the column where you want to add the task
    - Click "Add Task"
  2. Edit a Task:
    - Click the pencil icon on any task
    - Modify the details in the form
    - Click "Update Task"
  3. Move Tasks:
    - Drag and drop tasks between columns
    - Or edit a task and change its column in the form
  4. Delete a Task:
    - Click the trash can icon on any task

  The app automatically saves your tasks, so they'll still be there when you reopen the file. You can open this HTML file directly in any
  modern browser to start using your Kanban board.

✻ Cooked for 9m 29s

❯ 
```

From the working directory, one see [kanban-app.html](files/kanban-app.html).

See also <https://towardsdatascience.com/run-claude-code-for-free-with-local-and-cloud-models-from-ollama/>, which gives [kanban.html](files/kanban.html).

On the first attempt is also gives,

```
 Overview

 Features

 1. Create new tasks with titles
 2. Move tasks between columns by dragging
 3. Update task titles by clicking to edit
 4. Delete tasks
 5. Responsive design that works in any modern browser

 Technical Approach

 - Single HTML file containing HTML, CSS, and JavaScript
 - Drag and drop functionality using HTML5 Drag and Drop API
 - Local storage for persistence
 - Clean, modern UI with CSS Grid/Flexbox
 - Event delegation for efficient event handling

 Detailed Implementation

 HTML Structure

 - Main container div
 - Header with title and task creation form
 - Three column containers (TODO, In Progress, Completed)
 - Each column has:
   - Column header
   - Task list container
   - Add task button/form

 CSS Styling

 - CSS variables for consistent colors
 - Flexbox for main layout
 - Card-style design for tasks
 - Visual feedback for drag operations
 - Responsive design with media queries

 JavaScript Functionality

 - Task data model with id, title, status
 - DOM manipulation functions
 - Drag and drop event handlers
 - Local storage save/load functions
 - Event listeners for user interactions

 File Structure

 - Single file: kanban.html (contains all HTML, CSS, and JavaScript)

 Implementation Steps

 1. Create basic HTML structure with three columns
 2. Add CSS styling for layout and appearance
 3. Implement JavaScript functionality:
   - Task creation
   - Drag and drop between columns
   - Task editing
   - Task deletion
   - Local storage persistence
 4. Add responsive design considerations
 5. Test functionality in browser

 Verification

 1. Open file in browser
 2. Create several tasks
 3. Drag tasks between columns
 4. Edit task titles
 5. Delete tasks
 6. Refresh page to verify persistence
╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌

 Claude has written up a plan and is ready to execute. Would you like to proceed?

 ❯ 1. Yes, clear context and bypass permissions
   2. Yes, and bypass permissions
   3. Yes, manually approve edits
   4. Type here to tell Claude what to change

 ctrl-g to edit in Pico · ~/.claude/plans/snoopy-coalescing-lemon.md
```
