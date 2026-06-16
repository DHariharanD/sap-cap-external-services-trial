# SAP CAP Procurement Service

A modern, enterprise-grade microservice that seamlessly integrates with SAP S/4HANA Cloud to provide a unified procurement data interface.

## Overview

This application serves as a **procurement gateway** for enterprises seeking to consolidate and expose purchase order and purchase requisition data from SAP S/4HANA Cloud systems. Built on the SAP Cloud Application Programming Model (CAP) with Spring Boot, it demonstrates best practices for enterprise API development, external service integration, and robust error handling.

### Key Capabilities

- **Unified Data Access**: Expose purchase orders and requisitions through a single, well-defined REST API
- **Real-time Integration**: Direct synchronization with SAP S/4HANA Cloud via OData v4
- **Enterprise-Ready**: Production-grade error handling, comprehensive logging, and secure API authentication
- **Standards-Based**: Implements OData 4.0 protocol for standards-compliant data queries and filtering

---

## Architecture

### High-Level Design

```
┌─────────────────────┐
│   Client Apps       │
│   (Web, Mobile)     │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────────────┐
│   Procurement Service API   │
│   (Spring Boot + CAP)       │
│   /procurement endpoint     │
└──────────┬──────────┬───────┘
           │          │
      ┌────▼────┐  ┌──▼──────┐
      │Purchase │  │Purchase  │
      │ Orders  │  │Requisiti │
      │Handler  │  │ons Hand. │
      └────┬────┘  └──┬───────┘
           │          │
      ┌────▼──────────▼──┐
      │ SAP S/4HANA      │
      │ Cloud OData APIs │
      └──────────────────┘
```

### Technology Stack

| Component | Version | Purpose |
|-----------|---------|---------|
| **Java** | 21 | Language runtime |
| **Spring Boot** | 3.5.11 | Application framework |
| **SAP CAP Services** | 4.8.0 | Data model & service layer |
| **OData v4** | 4.0 | External API protocol & adapter |
| **Maven** | 3.x | Build automation |
| **H2 Database** | Latest | Local development storage |

---

## Getting Started

### Prerequisites

- **Java Development Kit (JDK)** 21 or later
- **Maven** 3.8.0 or later
- **SAP API Credentials**: API key from SAP API Business Hub
- **Network Access**: Outbound HTTPS to SAP sandbox endpoints

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/DHariharanD/sap-cap-external-services-trial.git
   cd sap-cap-external-services-trial
   ```

2. **Configure API credentials**
   Create a `.env` file in the srv folder:
   ```
   SAP_API_KEY=your-api-key-here
   ```

3. **Build the project**
   ```bash
   mvn clean install
   ```

4. **Run the application**
   ```bash
   mvn spring-boot:run -pl srv
   ```
   or 
  ```bash
   mvn cds:watch
   ```

The service will start on `http://localhost:8080` with the procurement API available at `/procurement`.

---

## API Endpoints

### Purchase Orders

Retrieve all purchase orders from SAP S/4HANA Cloud.

```http
GET /procurement/purchase-orders
```

**Response Example:**
```json
{
  "value": [
    {
      "PurchaseOrder": "4500000001",
      "PurchaseOrderType": "NB",
      "Supplier": "1001234",
      "CompanyCode": "1000",
      "DocumentCurrency": "USD",
      "PurchaseOrderDate": "2024-01-15T00:00:00Z",
      "CreatedByUser": "USER001"
    }
  ],
  "@odata.count": 150
}
```

### Purchase Order Items

Retrieve line items for all purchase orders.

```http
GET /procurement/purchase-order-items
```

**Parameters:**
- `$filter`: Filter items by property (e.g., `Material eq '100-100'`)
- `$top`: Limit results (default: 50, max: 50)
- `$count`: Include total count (`true`/`false`)
- `$select`: Choose specific fields (e.g., `PurchaseOrder,Material,OrderQuantity`)

### Purchase Requisitions

Retrieve all purchase requisitions.

```http
GET /procurement/purchase-requisitions
```

### Purchase Requisition Items

Retrieve line items for all purchase requisitions.

```http
GET /procurement/purchase-requisition-items
```

---

## Configuration

### Application Properties

Edit `srv/src/main/resources/application.yaml`:

```yaml
server:
  port: 8080

# SAP API Endpoints (auto-configured in package.json)
# No additional configuration needed for external API URLs

# Logging Configuration
logging:
  level:
    customer.sap_cap_external_services_trial: DEBUG
    com.sap.cds: INFO
```

### SAP API Credentials

The application reads the `SAP_API_KEY` environment variable, which must contain a valid API key from the SAP API Business Hub.

**Development:**
```bash
export SAP_API_KEY="your-api-key"
mvn spring-boot:run -pl srv
```

**Production:**
Set the environment variable in your deployment platform (Cloud Foundry, Kubernetes, etc.).

---

## Project Structure

```
.
├── pom.xml                              # Parent POM with dependency management
├── package.json                         # CDS configuration & external service specs
├── srv/
│   ├── pom.xml                          # Service module POM
│   ├── procurement-service.cds          # CDS service definition
│   ├── external/
│   │   ├── CE_PURCHASEORDER_0001.cds    # SAP Purchase Order OData model
│   │   ├── CE_PURCHASEORDER_0001.edmx   # OData metadata
│   │   ├── CE_PURCHASEREQUISITION_0001.cds
│   │   └── CE_PURCHASEREQUISITION_0001.edmx
│   └── src/
│       ├── main/java/customer/sap_cap_external_services_trial/
│       │   ├── Application.java         # Spring Boot entry point
│       │   └── ProcurementServiceHandler.java  # Event handlers for data fetching
│       └── main/resources/
│           └── application.yaml         # Spring configuration
├── db/                                  # Database schema & initial data
└── README.md                            # This file
```

---

## How It Works

### Data Flow

1. **Client Request**: Application receives OData query (e.g., GET `/procurement/purchase-orders`)
2. **CDS Routing**: CAP routes request to `ProcurementServiceHandler`
3. **Remote Fetch**: Handler constructs HTTP request to SAP API with authentication
4. **Decompression**: Handles response compression (GZIP, DEFLATE)
5. **JSON Parsing**: Extracts data from OData response envelope
6. **Response**: Returns data as OData JSON feed to client

### Error Handling

The service implements comprehensive error handling:

- **HTTP 401/403**: Logs API authentication/authorization failures with actionable guidance
- **Network Timeouts**: Graceful failure with clear error messages
- **Malformed Response**: Logs full response body to diagnose API issues
- **Missing Data**: Returns empty result set rather than failing

All errors are logged with context to aid troubleshooting.

---

## Development

### Building

```bash
# Build entire project
mvn clean install

# Build only the service module
mvn clean install -pl srv

# Build with tests
mvn clean test install
```

### Running Locally

```bash
# Start with Spring Boot Maven plugin
mvn spring-boot:run -pl srv

#Start with CDS 
mvn cds:watch

# Start with JAR
java -jar srv/target/sap-cap-external-services-trial-exec.jar
```

### Debugging

The project includes Spring DevTools for fast reload during development:

```bash
mvn spring-boot:run -pl srv -Dspring-boot.run.arguments="--spring-devtools.restart.enabled=true"
```

### Logging

Enable debug logging for troubleshooting:

```bash
mvn spring-boot:run -pl srv -Dlogging.level.customer.sap_cap_external_services_trial=DEBUG
```

---

## External Dependencies

### SAP OData APIs

The service connects to SAP S/4HANA Cloud through two OData v4 endpoints:

1. **Purchase Order API**
   - Endpoint: `api_purchaseorder_2`
   - Entities: PurchaseOrder, PurchaseOrderItem
   - Documentation: SAP API Business Hub

2. **Purchase Requisition API**
   - Endpoint: `api_purchaserequisition_2`
   - Entities: PurchaseReqn, PurchaseReqnItem
   - Documentation: SAP API Business Hub

**Authentication**: API key supplied via `SAP_API_KEY` environment variable

---

## Troubleshooting

### "API key not found" Error
- Verify `.env` file exists in srv 
- Check `SAP_API_KEY` environment variable is set
- Ensure key has access to Purchase Order and Requisition APIs in SAP API Business Hub

### "HTTP 401 Unauthorized" from SAP
- Validate API key is active and not expired
- Confirm key is assigned to the correct APIs in SAP Business Hub
- Check network connectivity to `sandbox.api.sap.com`

### "No 'value' array in response"
- Check SAP API status at api.sap.com
- Verify API is activated on your account
- Review full response body in logs for diagnostic details

### Empty Result Sets
- Confirm data exists in your SAP system
- Check `$top=50` parameter—results are limited to 50 records
- Use `$filter` to refine queries if dataset is large

For additional support, refer to logs at debug level and consult the [SAP CAP documentation](https://cap.cloud.sap).

---

## Production Deployment

### Cloud Foundry (SAP Cloud Platform)

1. Build the application as an executable JAR
2. Create a deployment manifest (`manifest.yml`)
3. Bind required services (e.g., database, external connectivity)
4. Deploy: `cf push`

### Security Considerations

- **Never commit API keys**: Use environment variables or secrets management
- **HTTPS Only**: Enforce TLS 1.2+ for all API communication
- **API Rate Limiting**: Consider rate limiting for production deployments
- **Audit Logging**: Enable comprehensive audit trails for compliance

---

## Contributing

For contributions, please:

1. Create a feature branch from `main`
2. Follow the existing code style and conventions
3. Include tests for new functionality
4. Submit a pull request with clear description

---

## Support & Resources

- **SAP CAP Documentation**: https://cap.cloud.sap/docs
- **SAP CDS Reference**: https://cap.cloud.sap/docs/cds
- **OData Protocol**: https://www.odata.org
- **Spring Boot Guide**: https://spring.io/guides/gs/spring-boot

---
