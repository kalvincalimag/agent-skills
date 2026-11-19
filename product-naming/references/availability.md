# Checking availability

Load this at step 5. Check after filtering, so availability does not steer the creative work, and before anyone gets attached to a name. Every status you report comes from a check run in this session, with the date. Never report availability from memory.

## Order of checks

Stop spending effort on a name as soon as it fails a step.

### 1. Competitors, by web search

Search `"[name]" [category]`, `"[name]" app`, and `"[name]" software`.

- A direct competitor with the same name in the same space kills the name. Do not check its domains.
- A large brand in another industry does not kill it, but you will fight that brand for search results for years. Weigh that in step 6.
- Read the encyclopedia entry for the word, if it has one, for associations you missed.

### 2. Platforms the brief requires

Run the script in this skill's `scripts/` folder for each survivor, passing only the platforms the brief named. Run several names in parallel.

```bash
bash scripts/check-availability.sh <name> domains github npm
TLDS="com" bash scripts/check-availability.sh get<name> domains
```

| Platform argument | What it checks |
| --- | --- |
| `domains` | .com .dev .app .io .co .sh by default, or the TLDs in `TLDS` |
| `github` | a GitHub user or organization with that name |
| `npm`, `pypi`, `crates`, `rubygems` | the package registry |
| `wp` | the WordPress plugin directory slug |
| `appstore` | US App Store apps whose name starts with the candidate |
| `telegram` | a public Telegram username |

Each line starts with AVAILABLE, TAKEN, or UNCLEAR. Treat UNCLEAR as unconfirmed, never as free. Domains whose registry has no RDAP service, such as .io, .co, and .sh, come back UNCLEAR when no name servers exist. That usually means free, but confirm at a registrar.

If the script cannot run, check by hand: a registrar's search page for domains, and the platform's own page for the rest.

### 3. What the script cannot check

Use web search for these:

- Google Play: `"[name]" site:play.google.com`
- Social handles: the profile URL on each network the brief names
- Trademarks: the USPTO trademark search, EUIPO TMview, and the WIPO Global Brand Database. Look for exact matches and sound-alikes in the same goods and services class.

A basic trademark search is enough for side projects and open source. For a product that will be sold at scale, tell the user to have a trademark attorney clear the name before spending on brand assets.

## Domains

In rough order of preference:

1. `.com` is still the default for trust, especially with non-technical audiences.
2. `.dev`, `.io`, and `.sh` carry no stigma for developer tools. `.io` faces some uncertainty from the planned change of sovereignty over the Chagos Islands.
3. `.app` and `.co` suit consumer apps and general products.
4. Novelty TLDs such as `.xyz`, `.ninja`, and `.guru` read as temporary for a serious product.

An unregistered domain is not always cheap. Registries price some names as premium, so check the price at a registrar before calling a domain a win.

Common dictionary words are taken on every major TLD. For those, skip the exact-match checks and go straight to the variants.

- Prefixes: `get[name].com`, `use[name].com`, `try[name].com`, `[name]hq.com`, `[name]app.com`
- Audience suffixes, which also say who the product is for: `[name]dev.com`, `[name]team.com`, `[name]studio.com`, `[name]kitchen.com`, `[name]for[audience].com`

## Package names and handles

- Single common words are taken on npm, PyPI, and GitHub. Plan for a scope or an owner prefix: `@org/name` on npm, `org/name` on GitHub.
- npm refuses a new name that differs from an existing package only by punctuation, so `my-tool` is blocked when `mytool` exists. PyPI treats `-`, `_`, `.`, and letter case as the same name.
- Handle fallbacks: `@get[name]`, `@[name]hq`, `@[name]app`. `@[name]_official` is a last resort and looks defensive.

## What must be free

| Product type | Must have | Nice to have | Ignore |
| --- | --- | --- | --- |
| SaaS | domain | GitHub, X, LinkedIn | Instagram, TikTok |
| Developer tool | GitHub, package registry | domain, X | Instagram, LinkedIn |
| Consumer app | domain, app store name | Instagram, TikTok, X | GitHub, npm |
| Open source | GitHub org or repo, package name | domain | social handles |
| Bot | the bot's handle on its platform | GitHub repo | domain |
| Content brand | social handles | domain | package registries |

The brief overrides this table.

## Compromise or pivot

Keep the name and work around the gap when:

- the exact `.com` is taken and a good prefix or suffix variant is free;
- one handle is taken and the rest are free;
- the package name is taken and a scoped name works;
- the metaphor, story, and sound are strong.

Drop the name when:

- a direct competitor uses it;
- several must-have platforms are taken;
- the domain owner wants more than the project can pay;
- a trademark conflicts in the same class;
- it is free everywhere only because nobody wanted it.

Specific names are free more often. Compounds, modified words, and deeper cultural references are more often available than single common words, buzzwords, or whatever is trending.

## Searchability

A name that is free everywhere but impossible to find is still broken.

1. Search `"[name]"`. If an encyclopedia entry, a famous brand, or a well-known concept owns the first page, the name will need a qualifier for years.
2. Search `"[name] [category]"`. How deep would a new product appear?
3. If the name only works with "app" or "tool" after it, it is weak.

Score searchability in step 6 with this scale:

- **5.** Unique or nearly unique. No encyclopedia collision.
- **4.** Some competition, but "[name] [category]" finds the product at once.
- **3.** Shares the name with entities in clearly different industries. Needs a consistent qualifier.
- **2.** Shares it with well-known brands or concepts. Needs several qualifiers.
- **1.** A common word owned by an encyclopedia, major brands, or a crowded category.
