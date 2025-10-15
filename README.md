# BusTrackLK
Passenger App + Driver App + Admin Web App 

# 🚗 Ride System – Project Structure

```text
ride_system/
├── backend/
│   ├── admin-service/
│   │
│   ├── passenger-service/
│   │
│   ├── driver-service/
│   │
│   ├── api-gateway/                   # Optional, for unified routing
│   │   ├── src/main/java/com/example/gateway/
│   │   └── pom.xml
│   │
│   └── common-library/                # Shared DTOs, utils, auth logic
│       ├── src/main/java/com/example/common/
│       └── pom.xml
│
├── web-admin/                         # React frontend for admins
│
├── mobile/                            # Flutter apps
│   ├── passenger-app/
│   │
│   ├── driver-app/
│
├── docs/                              # System-level docs
│   ├── architecture.md
│   ├── api_contracts.md
│   ├── deployment_plan.md
│   └── env_variables.md
│
└── docker-compose.yml                 # Optional for running all services together
