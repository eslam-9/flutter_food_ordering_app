# Food Delivery App

A comprehensive Flutter food ordering application built with BloC architecture, featuring a complete workflow from restaurant selection to order confirmation with integrated Stripe payment processing.

## Features

- **Restaurant Discovery**: Browse local restaurants with filtering by cuisine type
- **Menu Browsing**: View detailed menus with food items, prices, and descriptions
- **Shopping Cart**: Add/remove items, update quantities, and view cart summary
- **Secure Payments**: Integrated Stripe payment processing for secure transactions
- **Order Placement**: Complete checkout process with customer information and payment
- **Order Tracking**: Real-time order status updates and confirmation
- **Error Handling**: Comprehensive error handling throughout the app
- **Responsive Design**: Beautiful, modern UI with smooth animations
- **Custom App Icon**: Branded app icon across all platforms

## Architecture

This app follows **SOLID principles** and uses **BloC (Business Logic Component)** architecture for state management:

- **Models**: Data classes for Restaurant, FoodItem, CartItem, and Order
- **Bloc**: State management with events, states, and business logic
- **Services**: Mock data service, Stripe payment service, and API integration
- **Screens**: UI components for each step of the ordering workflow
- **Routing**: Centralized route management with type-safe navigation
- **Tests**: Comprehensive unit tests for models and BloC logic

## Screenshots

### Restaurant List Screen
<img src="screenshots/restaurant_list.jpg" alt="Restaurant List" width="300"/>
*Browse available restaurants with category filtering*

### Restaurant Menu Screen
<img src="screenshots/restaurant_menu.jpg" alt="Restaurant Menu" width="300"/>
*View menu items and add to cart*

### Shopping Cart Screen
<img src="screenshots/cart.jpg" alt="Shopping Cart" width="300"/>
*Manage cart items and quantities*

### Checkout Screen
<img src="screenshots/checkout.jpg" alt="Checkout" width="300"/>
*Enter delivery information and place order*

### Order Confirmation Screen
<img src="screenshots/order_confirmation.jpg" alt="Order Confirmation" width="300"/>
*Order confirmation with tracking details*

## Getting Started

### Prerequisites

- Flutter SDK (3.9.0 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Stripe account (for payment processing)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd assigment
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Stripe (Optional)**
   - Update `lib/services/stripe_keys.dart` with your Stripe keys
   - Replace test keys with your production keys for live payments

4. **Generate app icons**
   ```bash
   flutter pub run flutter_launcher_icons:main
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage
```

## Project Structure

```
lib/
├── bloc/
│   ├── food_ordering_bloc.dart      # Main BloC implementation
│   ├── food_ordering_event.dart     # BloC events
│   ├── food_ordering_state.dart     # BloC states
│   └── route_generator.dart         # Centralized routing logic
├── models/
│   ├── food_item.dart               # Food item data model
│   ├── restaurant.dart              # Restaurant data model
│   ├── cart_item.dart               # Cart item data model
│   └── order.dart                   # Order data model
├── screens/
│   ├── restaurant_list_screen.dart   # Restaurant listing screen
│   ├── restaurant_menu_screen.dart   # Menu browsing screen
│   ├── cart_screen.dart             # Shopping cart screen
│   ├── checkout_screen.dart         # Checkout process screen
│   └── order_confirmation_screen.dart # Order confirmation screen
├── services/
│   ├── mock_data_service.dart       # Mock data service
│   ├── stripe_service.dart          # Stripe payment integration
│   └── stripe_keys.dart             # Stripe API keys configuration
└── main.dart                        # App entry point

test/
├── models/
│   ├── food_item_test.dart          # Food item model tests
│   └── cart_item_test.dart          # Cart item model tests
└── bloc/
    └── food_ordering_bloc_test.dart # BloC logic tests

assets/
└── appIcon.png                      # Custom app icon source
```

## Key Features Implementation

### BloC Architecture
- **Events**: User actions like `LoadRestaurants`, `AddToCart`, `PlaceOrder`
- **States**: UI states like `loading`, `loaded`, `error`, `orderPlaced`
- **Bloc**: Business logic handling state transitions and data processing

### Payment Integration
- **Stripe Integration**: Secure payment processing with Stripe SDK
- **Payment Sheet**: Native payment UI for seamless checkout experience
- **Error Handling**: Comprehensive payment error handling and retry logic
- **Test Mode**: Configured with Stripe test keys for development

### Routing System
- **Centralized Routing**: Type-safe navigation with RouteGenerator
- **Argument Passing**: Secure data passing between screens
- **Error Routes**: Graceful handling of invalid routes

### Error Handling
- Network error simulation with retry functionality
- Form validation with user-friendly error messages
- Graceful error states with recovery options
- Payment error handling with user feedback

### State Management
- Immutable state objects using Equatable
- Predictable state transitions
- Reactive UI updates based on state changes

### UI/UX Design
- Material Design 3 components
- Google Fonts (Poppins) for typography
- Smooth animations and transitions
- Responsive layout for different screen sizes
- Consistent color scheme with orange primary color
- Custom app icons across all platforms

## Dependencies

### Core Dependencies
- `flutter_bloc`: State management with BloC pattern
- `equatable`: Value equality for models
- `google_fonts`: Typography with Poppins font family
- `cached_network_image`: Image loading and caching
- `flutter_stripe`: Stripe payment integration
- `dio`: HTTP client for API calls

### Development Dependencies
- `flutter_lints`: Code linting and style enforcement
- `bloc_test`: Testing BloC logic
- `mocktail`: Mocking for tests
- `flutter_launcher_icons`: Custom app icon generation

## Workflow

1. **Restaurant Selection**: Users browse restaurants by category
2. **Menu Browsing**: View restaurant menu with detailed food items
3. **Cart Management**: Add items, adjust quantities, view cart summary
4. **Checkout Process**: Enter delivery information and payment details
5. **Payment Processing**: Secure payment through Stripe integration
6. **Order Confirmation**: Receive order confirmation with tracking information

## Testing

The app includes comprehensive unit tests covering:
- Model equality and copyWith methods
- BloC state transitions and business logic
- Error handling scenarios
- Cart operations (add, remove, update quantities)
- Payment integration testing (with mock Stripe responses)

## Future Enhancements

- Real API integration with backend services
- User authentication and profiles
- Order history and tracking
- Push notifications for order updates
- Multiple payment methods (Apple Pay, Google Pay)
- Restaurant reviews and ratings
- Real-time order tracking with maps
- Loyalty programs and discounts
- Multi-language support

## Stripe Configuration

### Security Notes
⚠️ **Important**: The current implementation uses test keys for development. For production:

1. **Never commit real API keys** to version control
2. **Use environment variables** or secure key management
3. **Replace test keys** in `lib/services/stripe_keys.dart`
4. **Enable webhook endpoints** for production payment processing

### Test Cards
For testing payments, use Stripe's test card numbers:
- **Success**: 4242 4242 4242 4242
- **Decline**: 4000 0000 0000 0002
- **Requires Authentication**: 4000 0025 0000 3155

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
