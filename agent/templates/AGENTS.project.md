# AGENTS.md - <Project name>

Template de AGENTS.md de projeto. Neutro e factual (sem menção a IA/agentes): útil para humanos e agentes. Preencher os campos entre <>. Manter em ~50-70 linhas. Quando o repo não puder conter o arquivo, usar versão local gitignored com o mesmo conteúdo.

## Overview

<3-5 linhas factuais: propósito, stack com versões, package manager, restrições-chave.>

## Commands

- Install: `<comando exato>`
- Dev: `<comando exato>`
- Build: `<comando exato>`
- Lint/format: `<comando exato>`
- Typecheck: `<comando exato>`
- Test (suíte): `<comando exato>` | single file: `<comando exato com path>`

## Structure

<mapa de top-level; onde entra código novo; caminhos que nunca se edita (generated, vendored).>

## Code style

<regras verificáveis específicas deste repo + 1 arquivo de exemplo canônico a seguir. Deixar de fora o que linter/formatter já impõe.>

- Comments only for non-obvious "why"; all repo content in English.
- Types on signatures only (parameters and return type); follow the framework's market convention (<Django/FastAPI/Flask/Express/...>).
- One concept, one name: no synonyms for the same entity.
- <convenções específicas da stack/framework>

## Testing

<onde os testes vivem, padrão de nome, como rodar um subconjunto, fixtures/auth necessários.>

- TDD: failing test first for new non-trivial logic; regression test must fail before a bug fix. Never weaken existing tests.

## Boundaries

- Always: <lint + typecheck + teste direcionado antes de reportar; diff mínimo; remover o que ficou obsoleto>
- Ask first: <adicionar dependência, mudar schema/migração, mudar API pública>
- Never: <commitar secrets/.env, editar generated/, push para main>

## Backend/DB specifics (se aplicável)

- Migrations versionadas; nunca editar migration já aplicada.
- Revisar N+1 e query em loop; listas paginadas.

## Gotchas

<peculiaridades de ambiente, varáveis obrigatórias, armadilhas não óbvias.>
