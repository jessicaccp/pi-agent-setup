# Provider credentials per machine

Pi reads provider API keys from `~/.pi/agent/auth.json` or from environment variables. Never put a real key in this repo.

On each machine, pick one:

1. Environment variable, in your shell profile (`~/.bashrc`, `~/.zshrc`):

   ```bash
   export DEEPSEEK_API_KEY=sk-...
   ```

   Start pi from a new shell so the variable is present.

2. Manual copy of `~/.pi/agent/auth.json` from a password manager or an encrypted store. File format:

   ```json
   {
     "deepseek": { "type": "api_key", "key": "sk-..." }
   }
   ```

   Keep it readable only by you (`chmod 600`).

`auth.json` is git-ignored here, and `apply.sh` never writes to it.
