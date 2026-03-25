# FlareUp – Light Up Your Love

## Current State
New project, no existing application files.

## Requested Changes (Diff)

### Add
- Full mobile dating app prototype with 5 main screens via bottom navigation
- Authentication screens: Login, Signup with email/phone
- Home screen: Swipe card match feed, profile previews, gift button
- Wallet screen: Coin/diamond balances, recharge via OPay/PayPal, conversion, level display, game history
- Live streaming screen: Stream view, real-time gift overlay, duration timer, floating gift button, doubling rules display
- Mini-games screen: Game cards with coin/diamond cost, reward display, game history
- Profile & Chat screen: View/edit profile, messaging UI, diamond gifts received
- Gifting system: Gift modal with animated notifications, send coins as gifts
- Subscription modal: $6/month premium prompt for male users
- Agencies & Families UI: Group management screens, member lists, add/remove
- Role system: user, host, agency roles displayed on profiles
- Level system: displayed on profiles and wallet

### Modify
- N/A (new project)

### Remove
- N/A (new project)

## Implementation Plan
1. Set up backend with authorization for user roles (user, host, agency)
2. Create Motoko backend with user profiles, wallet, gifts, subscriptions
3. Build frontend with React + Tailwind using red/hot-pink/orange/black/white palette
4. Implement bottom navigation with 5 tabs: Home, Wallet, Live, Mini-Games, Profile
5. Build Auth screens (login/signup)
6. Build Home swipe card feed
7. Build Wallet with coin/diamond balances and recharge modals
8. Build Live streaming UI with gift overlay
9. Build Mini-games grid
10. Build Profile/Chat screens
11. Add gift animation modals
12. Add subscription prompt modals
13. Add Agencies & Families management UI
