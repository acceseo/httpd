<div align="center">
    <a href="https://www.acceseo.com">
        <img
            alt="acceseo logo"
            src="https://www.acceseo.com/wp-content/uploads/2019/09/logoAcceseo-2.svg"
            width="150">
    </a>
</div>

<h1 align="center">httpd</h1>
<div align="center">
    <a href="https://hub.docker.com/r/acceseo/httpd"><img src="https://img.shields.io/docker/pulls/acceseo/httpd.svg" alt="Docker pulls"></a>
    <br><br>
    <a href="https://github.com/acceseo/httpd/tree/main/README.md">Versión Española</a> | <a href="https://hub.docker.com/r/acceseo/httpd">Docker Hub</a>
</div>

<hr>

Image based on the official httpd image

## 📃 Configurable image parameters
* Virtualhost name
```HTTPD_SERVERNAME=localhost```
* Modify WORKDIR
```HTTPD_APP_DIRECTORY=/app```
* Modify the PHP's service Handler
```HTTPD_FPM_HANDLER=php.local:9000```
* Request timeout
```HTTPD_TIMEOUT=60```
* Time zone
```TZ=Europe/Madrid```

## 🕹️ Examples
* Serving HTTP requests
```
docker run --rm -v $(pwd):/app -p 443:443 acceseo/httpd
```

* Change the input directory
```
docker run --rm -v $(pwd):/app -e HTTPD_APP_DIRECTORY=/app/public -p 443:443 acceseo/httpd
```

*The --rm flag is used to force the images to be deleted after the execution is finished.*<br>
*We share the volume with the -v flag.*<br>
*Bind port 443 of the host to port 443 of the container via the -p flag.*

## 🕹️ Example (docker-compose.yml configuration file)
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

*<b>NOTE:</b> The image comes pre-configured for use with PHP-FPM using the configuration shown in the docker-compose example above. If you are going to use a new image for PHP or use a new service that replaces php.local, you need to modify HTTPD_FPM_HANDLER to the new service specifications, or make sure that the php image is compatible with PHP-FPM.*

## 👷 Credits
* Created by [acceseo](https://www.acceseo.com)