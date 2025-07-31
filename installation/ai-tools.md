# AI Tools

## Claude

```sh
npm install -g @anthropic-ai/claude-code

```

## Gemini
```sh
# As of 2025-07-28 does not work
# npm install @google/gemini-cli gemini
# Instead, run:
npx @google/gemini-cli gemini
```

## Ollama

```sh
curl -fsSL https://ollama.com/install.sh | sh
```

Model library: https://ollama.com/library

More info on how to manage it: https://www.theregister.com/2024/03/17/ai_pc_local_llm/

## Open WebUI

```sh
docker run -d --network=host -v open-webui:/app/backend/data -e OLLAMA_BASE_URL=http://127.0.0.1:11434 --name open-webui --restart always ghcr.io/open-webui/open-webui:main
```
