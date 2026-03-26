# FlareUp Dating App

## Current State
- App has 8 interactive screens: Home, Wallet, Live, Games, Profile, Chat, etc.
- Bottom nav has 5 tabs: Home, Wallet, Live, Games, Profile
- Login validates only that fields are non-empty; signup enforces 6-char alphanumeric password
- Live streaming shows streamer name and commenter names as plain non-clickable text
- No dedicated Messages tab in the bottom nav
- Mini-games have fixed bet amounts that users cannot change

## Requested Changes (Diff)

### Add
- New Messages tab in bottom nav with MessageCircle icon, navigating to a messages screen showing user conversations AND system messages (e.g. FlareUp system notifications)
- Messages screen should list conversations + a pinned system messages thread at the top

### Modify
- Login password validation: block login if password length < 4; require exactly 6 characters for login to succeed. Show clear error if < 4 chars entered.
- Live screen: make streamer name (in active stream top bar) and commenter names (in comment feed) clickable — tapping navigates to that user's profile screen
- Mini-games: replace fixed bet amounts with user-adjustable input (number input or +/- stepper) so players can set how many coins/diamonds to wager per play

### Remove
- Nothing removed

## Implementation Plan
1. Add `messages` to the Screen type and add a MessagesScreen component showing system messages thread + user conversations list
2. Add Messages tab (MessageCircle icon) to navItems in BottomNav
3. In handleSubmit login branch: add password length check — if < 4 show error "Password too short", if not exactly 6 show error "Password must be exactly 6 characters"
4. In LiveScreen active stream view: wrap streamer name span in a button that calls setScreen("profile")
5. In comment feed: wrap commenter name span in a button that calls setScreen("profile")
6. In GamesScreen: replace fixed coin/diamond bet display with a stepper (+/- buttons and value) allowing users to set their wager amount before playing
