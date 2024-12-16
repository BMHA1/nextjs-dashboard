#!/bin/bash

# URL y datos de la solicitud
URL="http://certificacioninternacional.mijp.gob.ve/paginas/CU_login/"
COOKIES="_ga=GA1.3.1576728135.1732543339; _ga_HW2M5R5970=GS1.3.1734282057.1.1.1734283772.0.0.0; _ga_LSKG51E1ZQ=GS1.3.1734281608.7.1.1734284674.0.0.0; _gid=GA1.3.2032423414.1734281608; HASH_PHPSESSID=3e40f777d3ef3b99f383174efcd55b1a34d15d7d; PHPSESSID=gg32b532rhgumrmee5p1e3ibm1"
DATA="correo=brajinh18%40gmail.com&password=B7%25RcZpaM%2BfVjah"

# Loop para hacer peticiones cada 5 segundos
while true; do
  echo "Haciendo solicitud a $URL..."
  
  # Hacer la solicitud y guardar el resultado
  RESPONSE=$(curl -s -w "%{http_code}" -o response_body.txt -X POST "$URL" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -H "Cookie: $COOKIES" \
    -d "$DATA")
  
  # Leer el código de estado HTTP
  HTTP_CODE=${RESPONSE: -3}
  
  # Verificar si la respuesta es diferente de 403
  if [ "$HTTP_CODE" -ne 403 ]; then
    echo "Respuesta exitosa con código HTTP: $HTTP_CODE"
    cat response_body.txt
    break
  else
    echo "Acceso denegado (403). Reintentando en 5 segundos..."
  fi

  # Esperar 5 segundos antes de la próxima solicitud
  sleep 5
done
