#!/bin/bash

echo "Creating Studio..."
STUDIO_RESP=$(curl -s -X POST http://localhost:4000/api/studios \
   -H "Content-Type: application/json" \
   -d '{"studio": {"name": "Warner Bros"}}')
echo $STUDIO_RESP
STUDIO_ID=$(echo $STUDIO_RESP | grep -o '"id":[0-9]*' | head -1 | cut -d : -f 2)
echo "Studio ID: $STUDIO_ID"

echo "Creating Production Company..."
PC_RESP=$(curl -s -X POST http://localhost:4000/api/productioncompanies \
   -H "Content-Type: application/json" \
   -d "{\"production_company\": {\"name\": \"Legendary Pictures\", \"studio_id\": $STUDIO_ID}}")
echo $PC_RESP
PC_ID=$(echo $PC_RESP | grep -o '"id":[0-9]*' | head -1 | cut -d : -f 2)
echo "Production Company ID: $PC_ID"

echo "Creating Executive..."
EXEC_RESP=$(curl -s -X POST http://localhost:4000/api/executives \
   -H "Content-Type: application/json" \
   -d "{\"executive\": {\"name\": \"Kevin Tsujihara\", \"studio_id\": $STUDIO_ID, \"production_company_id\": $PC_ID}}")
echo $EXEC_RESP

echo "Creating Producer..."
PROD_RESP=$(curl -s -X POST http://localhost:4000/api/producers \
   -H "Content-Type: application/json" \
   -d "{\"producer\": {\"name\": \"Thomas Tull\", \"studio_id\": $STUDIO_ID, \"production_company_id\": $PC_ID}}")
echo $PROD_RESP
