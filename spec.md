# FlareUp Dating App

## Current State
App has bottom nav: Home (swipe cards), Wallet, Live (stream list), Mini-Games, Profile. Chat inbox exists. Agency/family management done. Profile/cover editable.

## Requested Changes (Diff)

### Add
- Home screen now shows live streams (what was the Live screen content) as the landing screen
- Swipe + Messages combined on same screen: a "Discover" screen with a top tab/button switcher between "Swipe" (match cards) and "Messages" (chat inbox). This replaces the old Home tab.
- Message icon on swipe profile cards is now clickable (opens that person's chat thread)
- All messages in chat threads are clickable to reply (tap a received message → quote-reply input appears)
- Reply functionality: tapping a message shows a reply-to preview bar above the input field; sending creates a message with a quoted reference
- When user runs out of coins while gifting (in GiftModal or live stream), instead of just a toast error, automatically navigate to wallet screen (setScreen("wallet")) AND open the recharge/payment options modal immediately

### Modify
- Bottom nav: Home tab = Live streams, second tab = Discover (Swipe + Messages), Wallet, Games, Profile
- LiveScreen content moves to HomeScreen
- Chat thread: all received messages are tappable to initiate a reply
- GiftModal: on insufficient coins, call setScreen("wallet") to redirect user to wallet

### Remove
- Separate Live tab (its content moves to Home)

## Implementation Plan
1. Rename/repurpose HomeScreen to show the live streams grid (move LiveScreen content there)
2. Create DiscoverScreen with two modes toggled by a top button: Swipe (existing swipe card UI) and Messages (existing chat inbox)
3. Update bottom nav: Home (live), Discover (swipe+messages), Wallet, Games, Profile
4. In swipe card UI, make the message icon button navigate to that profile's conversation
5. In chat thread, received messages tappable → reply-to quote bar above input
6. GiftModal + stream gift: when coins insufficient, setScreen("wallet") and open recharge options
