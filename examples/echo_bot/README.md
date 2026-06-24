# Echo Bot

A minimal CLI bot that subscribes to inbound messages and echoes them back.

## Run

```bash
cd examples/echo_bot
mix deps.get
mix run --no-halt echo_bot.exs
```

On first run, the bot prints a QR code to the terminal — scan it with the WhatsApp mobile app under "Linked Devices". The pairing handshake stores credentials in the local Postgres so subsequent runs reconnect automatically.

## Files

- `echo_bot.exs` — entry point. Starts a `Whatsmeow.Session`, subscribes to PubSub, and pattern-matches on the `Whatsmeow.Types.Events.Message` events.
- `config/config.exs` — DB and PubSub config.
