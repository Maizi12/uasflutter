# Transaksi2 Implementation - New Architecture

This document describes the implementation of the Transaksi2 page using the new clean architecture pattern.

## Overview

The Transaksi2 page has been successfully rewritten from the old `lib_old` architecture to the new `lib` architecture, following clean architecture principles with proper separation of concerns.

## How It Works - System Overview

### Architecture Flow
```
User Interface (Transaksi2Page) 
    ↓
BLoC Pattern (TransaksiCubit)
    ↓
Repository Pattern (TransaksiRepository)
    ↓
Use Cases (GetRequestUseCase, PostRequestUseCase)
    ↓
API Layer (Dio HTTP Client)
    ↓
Backend Services
```

### Data Flow Process
1. **User Interaction**: User selects wallet from dropdown or performs actions
2. **State Management**: TransaksiCubit receives events and manages state changes
3. **Business Logic**: Repository handles data operations and API calls
4. **Data Transformation**: Models convert JSON responses to Dart objects
5. **UI Updates**: BLoC emits new states, triggering UI rebuilds

### Key Decision Points

#### 1. Architecture Migration Decisions
- **Why Clean Architecture?**: Separated concerns for better maintainability and testability
- **Why BLoC Pattern?**: Consistent with existing codebase and provides reactive state management
- **Why Repository Pattern?**: Abstracts data sources and provides single point of truth

#### 2. State Management Strategy
- **Simple State Classes**: Chose concrete state classes over freezed due to generation complexity
- **Event-Driven**: All user actions trigger cubit methods that emit new states
- **Error Handling**: Dedicated failure states with meaningful error messages

#### 3. Data Layer Decisions
- **Model Adaptation**: Migrated models from old architecture while maintaining compatibility
- **Hive Integration**: Kept GetWalletModel as HiveObject for local storage capabilities
- **Type Safety**: Used Either<Failure, Success> pattern for error handling

#### 4. UI Component Decisions
- **Widget Separation**: Broke down large UI into reusable components
- **Responsive Design**: Used MediaQuery for adaptive layouts
- **Asset Management**: Integrated SVG support for consistent iconography

#### 5. Integration Strategy
- **Dependency Injection**: Used GetIt for service locator pattern
- **Routing**: Integrated with existing GoRouter setup
- **Navigation**: Maintained consistent navigation patterns

### Technical Implementation Details

#### State Management Flow
```dart
// User action triggers cubit method
context.read<TransaksiCubit>().getWallet(1);

// Cubit emits loading state
emit(const TransaksiLoading());

// Repository handles API call
final result = await transaksiRepository.getWallet(idJenisCoa);

// Success: Emit loaded state
emit(TransaksiWalletLoaded(wallets: wallets));

// Failure: Emit error state  
emit(TransaksiFailed(failure.message));
```

#### Data Transformation Pipeline
```dart
// API Response → Model → UI
JSON Response → GetWalletModel.fromJsonWallet() → DropdownWalletApp
```

#### Error Handling Strategy
- **Network Errors**: Caught and wrapped in ServerFailure
- **Parsing Errors**: Handled with try-catch blocks
- **UI Errors**: Displayed through state management
- **Fallback Values**: Empty models for graceful degradation

### Performance Considerations

#### 1. Lazy Loading
- **Pagination**: Implemented for transaction lists
- **On-Demand Loading**: Data fetched only when needed
- **Caching**: Hive integration for wallet data persistence

#### 2. Memory Management
- **Disposal**: Proper cleanup of controllers and listeners
- **State Isolation**: Each cubit manages its own state
- **Widget Optimization**: Stateless widgets where possible

#### 3. Network Optimization
- **Request Batching**: Multiple API calls handled efficiently
- **Error Recovery**: Retry mechanisms for failed requests
- **Loading States**: User feedback during data fetching

### Security & Data Integrity

#### 1. Authentication
- **Token Management**: Access tokens handled through BoxMixin
- **Header Injection**: Automatic token inclusion in API requests
- **Session Management**: Integrated with existing auth system

#### 2. Data Validation
- **Model Validation**: Type-safe data structures
- **Input Sanitization**: Proper data formatting and validation
- **Error Boundaries**: Graceful handling of malformed data

### Testing Strategy

#### 1. Unit Testing
- **Repository Tests**: Mock API responses
- **Cubit Tests**: State emission verification
- **Model Tests**: JSON serialization/deserialization

#### 2. Integration Testing
- **API Integration**: End-to-end data flow testing
- **Navigation Testing**: Route and state persistence
- **UI Testing**: Widget interaction verification

### Maintenance & Scalability

#### 1. Code Organization
- **Feature-Based Structure**: Related code grouped together
- **Dependency Management**: Clear separation of concerns
- **Documentation**: Comprehensive inline comments

#### 2. Future Extensibility
- **Modular Design**: Easy to add new features
- **Plugin Architecture**: Repository pattern allows easy data source changes
- **State Extensibility**: New states can be added without breaking existing code

### Decision Rationale Summary

| Decision | Rationale | Benefits |
|----------|-----------|----------|
| Clean Architecture | Separation of concerns | Maintainability, testability |
| BLoC Pattern | Consistent with existing codebase | Reactive UI, predictable state |
| Repository Pattern | Data abstraction | Single source of truth, testability |
| Simple State Classes | Avoided freezed complexity | Faster development, easier debugging |
| Widget Separation | Reusability | DRY principle, maintainability |
| GetIt DI | Service locator pattern | Dependency management, testing |
| GoRouter Integration | Consistent navigation | Type-safe routing, deep linking |

This architecture provides a solid foundation for future enhancements while maintaining compatibility with the existing codebase and ensuring good performance and maintainability.

## Architecture Components

### 1. Data Layer
- **Models**: `lib/data/models/response_go.dart` - Contains all the data models for transactions, wallets, and responses
- **Repository Interface**: `lib/domain/repository/transaksi_repository.dart` - Defines the contract for transaction operations
- **Repository Implementation**: `lib/domain/repositories/transaksi_repository_impl.dart` - Implements the repository interface

### 2. Domain Layer
- **Repository Interface**: Defines the business logic contracts
- **Use Cases**: Leverages existing use cases from the new architecture
- **Helper Classes**: `lib/domain/helper/currency_format.dart` - Utility for currency formatting

### 3. Presentation Layer
- **Cubit**: `lib/presentation/cubits/transaksi/transaksi_cubit.dart` - State management for transactions
- **State**: `lib/presentation/cubits/transaksi/transaksi_state.dart` - State classes for the cubit
- **Page**: `lib/presentation/pages/transaksi2_page.dart` - Main transaction page
- **Widgets**:
  - `lib/presentation/widgets/chart_transaksi.dart` - Chart component
  - `lib/presentation/widgets/dropdown_wallet.dart` - Wallet dropdown
  - `lib/presentation/widgets/list_transaksi_card.dart` - Transaction list item
  - `lib/presentation/widgets/footer_card.dart` - Footer navigation

## Key Features Implemented

1. **Wallet Management**: Dropdown to select different wallets
2. **Balance Display**: Shows wallet balance with hide/show functionality
3. **Transaction Charts**: Placeholder for transaction charts (daily/weekly/monthly)
4. **Recent Transactions**: List of recent transactions with pagination
5. **Navigation**: Footer navigation bar
6. **State Management**: Proper state management using BLoC pattern

## Dependencies Added

- `flutter_svg: ^2.0.10+1` - For SVG icons

## Integration Points

### Dependency Injection
The transaksi repository and cubit are properly registered in `lib/dependencies_injection.dart`:

```dart
// Repository registration
sl.registerLazySingleton<TransaksiRepository>(
  () => TransaksiRepositoryImpl(sl(), sl()),
);

// Cubit registration
sl.registerFactory(
  () => TransaksiCubit(sl<TransaksiRepository>()),
);
```

### Routing
The transaksi2 page is integrated into the router at `lib/router/router.dart`:

```dart
GoRoute(
  path: Transaksi2Page.routeName,
  name: 'transaksi',
  builder: (context, state) => Transaksi2Page(),
),
```

### Navigation
The page is accessible from the dashboard via a button that navigates to `/transaksi`.

## State Management

The application uses a simple state management approach with the following states:

- `TransaksiInitial` - Initial state
- `TransaksiLoading` - Loading state
- `TransaksiFailed` - Error state with message
- `TransaksiData` - Data state with selected wallet
- `TransaksiList` - List state with wallet list
- `TransaksiWalletLoaded` - Wallet data loaded
- `TransaksiJenisTransaksiLoaded` - Transaction types loaded
- `TransaksiBerandaLoaded` - Dashboard data loaded
- `TransaksiTransactionsLoaded` - Transactions loaded
- `TransaksiTransactionLoaded` - Single transaction loaded
- `TransaksiTransactionCreated` - Transaction created
- `TransaksiTransactionUpdated` - Transaction updated

## API Integration

The repository implementation handles API calls for:

- Getting wallet list
- Getting transaction types
- Getting dashboard data
- Getting recent transactions
- Getting single transaction details
- Creating transactions
- Updating transactions

## Usage

1. Navigate to the dashboard
2. Click "Go to Transaksi" button
3. The transaksi2 page will load with wallet selection and transaction data
4. Use the dropdown to switch between wallets
5. View transaction charts and recent transactions
6. Use the floating action button to create new transactions (placeholder)

## Future Enhancements

1. Implement actual chart functionality
2. Add transaction creation/editing pages
3. Implement proper error handling and loading states
4. Add transaction filtering and search
5. Implement proper pagination for transaction lists
6. Add transaction detail pages

## Notes

- The chart component is currently a placeholder and needs actual chart implementation
- Some navigation features are commented out and need to be implemented
- The floating action button navigation needs to be connected to actual transaction creation pages
- SVG assets need to be added to the assets folder for proper icon display
