# Writing the standup to a Notion page

1. Fetch the page with the Notion fetch tool. The standup block is usually a callout whose heading is the block's name, with bold section labels such as **Updates** and **Blockers** followed by bullets.
2. Copy the current bullets exactly as fetched, including any odd spacing or half-edited text. That exact text is the `old_str`.
3. Call the Notion update-page tool with the `update_content` command. Make one search-and-replace that swaps the old bullets for the new ones. Keep the heading, the bold labels and the callout's indentation exactly as fetched. Never use `replace_content`, which rewrites the whole page.
4. If the update reports that nothing matched, fetch again and rebuild `old_str` from the fresh text. Don't guess at it.
5. Fetch the page again and confirm the block shows the new bullets and nothing else on the page changed.
