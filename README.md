# Plutus Smart API Integration for Hybrid Apps

## Overview
Plutus Smart supports communication with hybrid platform apps using Intents. The integration allows billing applications to interact with payment systems through a standardized API.

## Key Integration Mechanism
- Communication happens via Intents
- Hybrid framework can provide functionality natively or via third-party plugin
- Intent action: `"com.pinelabs.masterapp.HYBRID_REQUEST"`
- Data is passed using `"REQUEST_DATA"` key
- Response retrieved via `"RESPONSE_DATA"` key

## Main API Endpoints

### 1. DoTransaction API
**Purpose**: Process payments and various transaction types
**Key Transaction Types**:
- Sale (4001)
- Void (4006)
- UPI Sale (5120)
- UPI Get Status (5122)

**Request Parameters**:
- Transaction Type
- Billing Reference Number
- Payment Amount
- Optional: Bank Code, Card Details, Customer Information

### 2. Print Data API
**Purpose**: Print paper receipts on Plutus Smart Device
**Features**:
- Support for text, images, barcodes, QR codes
- Configurable printer width and alignment
- Multiple print data types supported

### 3. Settlement API
**Purpose**: Settle current batch of payment transactions
**Methods**:
- API-based settlement
- Manual settlement through Plutus Smart App

### 4. Get Terminal Info API
**Purpose**: Retrieve terminal configuration details
**Information Retrieved**:
- Plutus Store ID
- Terminal ID
- Merchant Name
- Store Name

### 5. Bluetooth Connection APIs
**Purpose**: 
- Connect Bluetooth on Plutus Smart Device
- Disconnect Bluetooth connection

## Header Information
**Common Request Header Parameters**:
- ApplicationId (Mandatory)
- UserId (Optional)
- MethodId (Mandatory)
- VersionNo (Mandatory)

## Response Handling
- Standard response structure with Header, Response, and Detail sections
- Response codes indicate transaction status
- Detailed transaction information returned in response

## Integration Steps
1. Define intent with `"com.pinelabs.masterapp.HYBRID_REQUEST"` action
2. Prepare request JSON payload
3. Use `startActivityForResult()` to launch intent
4. Implement `onActivityResult()` to handle response
5. Extract response data using `"RESPONSE_DATA"` key

## Best Practices
- Always include complete header information
- Handle different transaction types appropriately
- Implement proper error handling
- Validate response codes and messages
- Secure sensitive transaction data