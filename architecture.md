# Arabic Voice Chat App Architecture

## Overview
A luxurious 3D-style Arabic voice chat application with dark theme, RTL layout, and rich social features inspired by Yalla, StarChat, and Tiya.

## Design Approach
- **Style**: Vibrant & Energetic with dark luxurious theme
- **Color Palette**: Navy/Black backgrounds with Gold, Neon Blue, and Purple accents
- **Typography**: Arabic fonts (Cairo/Tajawal) with RTL support
- **UI/UX**: 3D effects, smooth animations, rounded corners, glowing highlights

## Core Features

### 1. Authentication System
- Google Sign-In (Firebase Auth)
- Facebook Login
- Phone Number with OTP
- Email & Password
- Persistent sessions with auto-login
- No guest mode - registration required

### 2. Main Navigation (Bottom Tab Bar)
- **الرئيسية (Home)**: Discovery, events, trending rooms
- **غرف (Rooms)**: All active voice chat rooms
- **الرسائل (Messages)**: Private chats
- **الملف الشخصي (Profile)**: User profile and wallet

### 3. Voice Room System
- 10 mic seats per room
- Host controls: lock/unlock seats, invite/remove users, assign admins
- Room themes: Galaxy, Dark Neon, Night Sky, Arabic Lounge
- Mini-player mode for background audio
- Gift animations with Arabic messages
- Real-time voice chat (simulated for MVP)

### 4. Private Messaging
- One-on-one text chat
- Voice notes support
- Image sharing
- User status: متصل / غير متصل / يكتب الآن
- Private voice calls option

### 5. User Profile System
- Username, User ID, Avatar, Country Flag
- Followers, Following, Friends, Visitors counters
- Balance: Gold Coins (الذهب) and Diamonds (الماس)
- VIP/SVIP levels (1-6)
- User levels (1-100)
- Arabic achievements system
- Animated account frames

### 6. Economy System
- Gold Coins and Diamonds currency
- Recharge system (simulated payment)
- Exchange between currencies
- Daily/Weekly rewards
- Gift sending system
- Top senders/receivers leaderboard

### 7. Additional Features
- Arabic mini-games in rooms
- Ranking system (hosts, givers, rooms)
- Events section with competitions
- Daily login streaks
- Task system

## Data Models

### User Model
- id, email, username, displayName
- avatarUrl, countryCode, countryFlag
- goldCoins, diamonds
- level, experience, vipLevel, svipLevel
- followers, following, friendsCount, visitorsCount
- achievements, dailyLoginStreak
- isOnline, lastSeen, currentStatus
- createdAt, updatedAt

### Room Model
- id, title, coverImage, description
- hostId, coHosts, admins
- theme (galaxy/darkNeon/nightSky/arabicLounge)
- isPasswordProtected, password
- participants, maxParticipants (10)
- micSeats (array of 10 seats with user/locked status)
- isActive, createdAt, updatedAt

### Message Model
- id, senderId, receiverId
- content, messageType (text/voice/image)
- mediaUrl, isRead
- createdAt, updatedAt

### Gift Model
- id, name, nameAr, price, currency (gold/diamond)
- imageUrl, animationUrl, category
- createdAt, updatedAt

### Transaction Model
- id, userId, type (recharge/exchange/gift/reward)
- amount, currency, description
- relatedUserId, relatedItemId
- createdAt, updatedAt

### Achievement Model
- id, titleAr, descriptionAr
- iconUrl, category, points
- requirement, createdAt

## Service Layer

### AuthService
- Google/Facebook/Email/Phone authentication
- Session management
- Auto-login functionality
- User registration/login

### UserService
- Profile CRUD operations
- Follow/unfollow users
- Update user stats (coins, level, etc.)
- Manage achievements
- Visitor tracking

### RoomService
- Create/update/delete rooms
- Join/leave room
- Manage mic seats
- Host controls (kick, assign admin, etc.)
- Room theme management

### MessageService
- Send/receive messages
- Message history
- Mark as read
- Delete messages
- User status updates

### GiftService
- Available gifts catalog
- Send gift to user
- Gift history
- Animated gift display

### TransactionService
- Recharge coins/diamonds
- Currency exchange
- Transaction history
- Daily/weekly rewards

### StorageService
- Local storage using shared_preferences
- Save/load user data
- Cache management
- Offline data sync

## UI Structure

### Screens
1. **AuthScreen** - Login/Register with multiple options
2. **MainScreen** - Bottom navigation container
3. **HomeScreen** - Discovery, events, trending
4. **RoomsScreen** - List of all active rooms
5. **RoomDetailScreen** - Voice room with 10 mic seats
6. **MessagesScreen** - List of conversations
7. **ChatScreen** - One-on-one messaging
8. **ProfileScreen** - User profile and wallet
9. **RechargeScreen** - Coin/diamond purchase
10. **ExchangeScreen** - Currency exchange
11. **TasksScreen** - Daily/weekly tasks
12. **ShopScreen** - Gifts and items
13. **LeaderboardScreen** - Rankings
14. **EventsScreen** - Competitions and events

### Reusable Widgets
- ArabicAppBar - RTL app bar with Arabic styling
- UserAvatar - Circular avatar with VIP frame
- MicSeat - Voice room seat component
- GiftCard - Gift display card
- CurrencyDisplay - Coins/diamonds with icons
- LevelBadge - User level indicator
- AchievementBadge - Achievement display
- ChatBubble - Message bubble (RTL)
- RoomCard - Room preview card
- UserCard - User profile card
- BottomSheetDialog - Modern bottom sheet
- GradientButton - Styled button with glow effect

## Technical Implementation

### Packages Required
- shared_preferences (local storage)
- cached_network_image (image caching)
- intl (Arabic date/time formatting)
- flutter_svg (icons and graphics)
- animations (page transitions)

### RTL Support
- Set textDirection: TextDirection.rtl globally
- Use Directionality widget for RTL layouts
- Mirror UI elements appropriately
- Arabic font family (Cairo/Tajawal)

### Theme Configuration
- Dark mode default
- Navy (#0A0E27), Black (#000000) backgrounds
- Gold (#FFD700), Neon Blue (#00D4FF), Purple (#9D4EDD) accents
- Arabic typography with proper sizing
- Custom button themes with glow effects

### State Management
- Use StatefulWidget for local state
- Provider pattern for app-wide state (optional)
- ValueNotifier for reactive updates

### Data Persistence
- All user data stored locally using shared_preferences
- Auto-save on changes
- Load on app startup
- Graceful error handling for corrupted data

## Implementation Steps

1. **Setup & Configuration**
   - Add dependencies to pubspec.yaml
   - Configure Arabic fonts
   - Setup RTL in main.dart
   - Update theme with luxurious dark colors

2. **Data Models**
   - Create all model classes with toJson/fromJson
   - Add copyWith methods
   - Include sample data

3. **Service Layer**
   - Implement storage service
   - Create auth service (simulated)
   - Build user service
   - Implement room service
   - Create message service
   - Build gift and transaction services

4. **Authentication**
   - Build auth screen with multiple login options
   - Implement registration flow
   - Add session management

5. **Main Navigation**
   - Create bottom navigation bar
   - Implement main screen container
   - Setup routing

6. **Home Screen**
   - Build discovery section
   - Add trending rooms
   - Create events display
   - Add promotional banners

7. **Rooms System**
   - Create rooms list screen
   - Build room detail with 10 mic seats
   - Implement host controls
   - Add room themes
   - Create mini-player

8. **Messaging**
   - Build messages list
   - Create chat screen with RTL bubbles
   - Add voice notes UI
   - Implement status indicators

9. **Profile System**
   - Build profile screen
   - Add wallet display
   - Create recharge/exchange screens
   - Implement tasks and achievements

10. **Economy & Gifts**
    - Create gift shop
    - Implement gift sending
    - Add transaction history
    - Build leaderboards

11. **Polish & Testing**
    - Add animations and transitions
    - Implement 3D effects and glow
    - Test RTL layout thoroughly
    - Compile and fix errors

## Implementation Status ✅

### Completed Features
- ✅ Full Arabic RTL interface with Cairo font
- ✅ Dark luxurious theme (Navy, Gold, Neon Blue, Purple)
- ✅ Authentication system (Google, Facebook, Email, Phone)
- ✅ User profiles with VIP/SVIP levels and achievements
- ✅ Home screen with trending rooms and top users
- ✅ Voice rooms with 10 mic seats system
- ✅ Room themes (Galaxy, Night Sky, Dark Neon, Arabic Lounge)
- ✅ Private messaging with RTL chat bubbles
- ✅ Currency system (Gold Coins & Diamonds)
- ✅ User avatars with VIP frames and online status
- ✅ Level badges and experience system
- ✅ Profile screen with wallet and achievements
- ✅ Transaction history and gift system
- ✅ All data persisted in local storage

### Sample Data Included
- 5 sample users with different levels and stats
- 5 sample rooms with various themes
- Sample messages and conversations
- 12 gift items (Gold & Diamond currency)
- All data auto-loads on first launch

## Notes
- This is an MVP using local storage
- Voice chat is simulated (no real-time audio)
- Payment is simulated (no real transactions)
- All data persists locally via shared_preferences
- Firebase integration possible in future
- Focus on beautiful UI and smooth UX
- All screens support full RTL layout
- 100% Arabic interface with English architecture
