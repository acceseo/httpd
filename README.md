<div align="center">
    <a href="https://www.acceseo.com">
        <img
            alt="acceseo logo"
            src="logo-acceseo.svg"
            width="150">
    </a>
</div>

<h1 align="center">httpd</h1>
<div align="center">
    <a href="https://hub.docker.com/r/acceseo/httpd"><img src="https://img.shields.io/docker/pulls/acceseo/httpd.svg" alt="Docker pulls"></a>
    <br><br>
    <a href="https://github.com/acceseo/httpd/tree/main/README.en.md">English version</a> | <a href="https://hub.docker.com/r/acceseo/httpd">Docker Hub</a>
</div>

<hr>

Imagen que tiene como base la oficial de httpd

## 📃 Parámetros de la imagen configurables
* Nombre del virtualhost
```HTTPD_SERVERNAME=localhost```
* Modificar WORKDIR
```HTTPD_APP_DIRECTORY=/app```
* Modificar el manejador para el servicio de PHP
```HTTPD_FPM_HANDLER=php.local:9000```
* Timeout de la petición
```HTTPD_TIMEOUT=60```
* Zona horaria
```TZ=Europe/Madrid```

## 🕹️ Ejemplo de uso
* Servir peticiones HTTP
```
docker run --rm -v $(pwd):/app -p 443:443 acceseo/httpd
```

* Cambiar el directorio de entrada
```
docker run --rm -v $(pwd):/app -e HTTPD_APP_DIRECTORY=/app/public -p 443:443 acceseo/httpd
```

*A través del flag --rm forzamos que las imágenes se eliminen tras terminar la ejecución.*<br>
*Compartimos el volumen con el flag -v.*<br>
*Vinculamos el puerto 443 del host con el 443 del contenedor a través del flag -p.*

## 🕹️ Ejemplo de uso (archivo de configuración docker-compose.yml)
```yaml
  version: '3'
  services:
    httpd.local:
      image: acceseo/httpd
      volumes:
        - .:/app
      ports:
        - 80:80
        - 443:443
    php.local:
        image: acceseo/php-fpm:8.2
        volumes:
          - .:/app
    #...
```

*<b>NOTA:</b> La imagen viene preconfigurada para usarla con PHP-FPM mediante la configuración que mostramos en el ejemplo anterior de docker-compose. Si se va a utilizar una nueva imagen para PHP o utilizar un nuevo servicio que sustituya a php.local, es necesario modificar HTTPD_FPM_HANDLER con las nuevas especificaciones del servicio, o cerciorarse de que la imagen de php sea compatible con PHP-FPM.*

## 👷 Créditos
* Creado por [acceseo](https://www.acceseo.com)