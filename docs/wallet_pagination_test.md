# Wallet history — pagination QA checklist

Manual tests for **My Wallet → Wallet History** (All / Add Money / Spend). Client behavior is defined in `MyWalletController`: `walletListPageLimit` items per request, page increments after a full page, scroll near bottom loads the next page, per-tab lists and cursors are independent.

## Preconditions

- Logged-in user with wallet access.
- Optional: account with **more than 9** wallet transactions in “All”, and enough filtered rows in Deposit / Spend to require a second page (to exercise pagination).

## Shared rules (all tabs)

| Rule | Expected |
|------|----------|
| Page size | `MyWalletController.walletListPageLimit` (9) rows per API call. |
| First load | Page `1`; list replaces with first response. |
| Load more | Triggers when scrolling near the bottom (~120px); requests the next page until API returns fewer than `limit` rows or an empty list. |
| Duplicates | App skips append when the same transaction `_id` already exists in the list. |
| End of list | Footer shows “End” when there are no more pages for that tab. |

## Tab-specific behavior

| # | Step | Expected |
|---|------|----------|
| T1 | Open **My Wallet** | **All** tab loads first; shimmer while loading; then rows or “No data found”. |
| T2 | Switch to **Add Money** | First visit: load starts; shimmer then deposit-only rows or empty state. |
| T3 | Switch to **Spend** | Same as T2 for spend rows. |
| T4 | Switch **All → Add Money → All** | **All** list and scroll position are **preserved** (not cleared) when returning; no duplicate refetch unless you pull to refresh. |
| T5 | Pull to refresh on each tab | That tab resets to page 1 and reloads; other tabs’ cached lists unchanged until visited again. |

## Pagination (per tab)

| # | Step | Expected |
|---|------|----------|
| P1 | On a tab with **≥ 10** items (after loading), scroll to bottom | A loading indicator appears at the bottom, then **new** rows append (no repeated `_id`). |
| P2 | Continue until API returns **&lt; 9** items | “End” appears; further scroll does not trigger more requests. |
| P3 | With **≤ 9** total items for a tab | First response fills the list; “End” shows (or no extra loader loop); **no** duplicate rows. |
| P4 | Rapid scroll at bottom | At most one load-more in flight; no duplicate pages from repeated triggers. |

## Regression (previous bug)

| # | Step | Expected |
|---|------|----------|
| R1 | Scroll to bottom on **All**, then change tab and back | No duplicate block of the same transactions as before the fix (shared scroll controller issue). |

## API (sanity)

- GET `/walletTransactions` is called with query: `page`, `limit` (and `type` for Add Money / Spend).
- Page increments on the client only after a **full** page (`length == limit`).

## After “Add Money” flow

- From **Add Money** screen, after a successful add initiation that refreshes the list, the **currently selected** wallet tab reloads from page 1.

---

**Reference:** `lib/feature/wallet/presentation/controller/my_wallet_controller.dart`, `lib/feature/wallet/presentation/ui/my_wallet_screen.dart`.
