# Dockerized DVWA

**[Install](#tada-install)** |
**[Start](#zap-start)** |
**[Stop](#no_entry_sign-stop)** |
**[Usage](#computer-usage)** |
**[Features](#star-features)** |
**[Configuration](#wrench-configuration)** |
**[FAQ](#bulb-faq)** |



[![Commit Build](https://github.com/kaakaww/dvwa-docker/actions/workflows/commit-build-and-pub.yml/badge.svg)](https://github.com/kaakaww/dvwa-docker/actions/workflows/commit-build-and-pub.yml)
[![Weekly Build](https://github.com/kaakaww/dvwa-docker/actions/workflows/weekly-build-and-pub.yml/badge.svg)](https://github.com/kaakaww/dvwa-docker/actions/workflows/weekly-build-and-pub.yml)
[![](https://img.shields.io/docker/pulls/kaakaww/dvwa-docker.svg)](https://hub.docker.com/r/kaakaww/dvwa-docker)
[![](https://img.shields.io/badge/github-kaakaww%2Fdvwa--docker-red.svg)](https://github.com/kaakaww/dvwa-docker "github.com/kaakaww/dvwa-docker")
[![License](https://img.shields.io/badge/license-MIT-%233DA639.svg)](https://opensource.org/licenses/MIT)

> Damn Vulnerable Web Application (DVWA) is a PHP/MySQL web application that is damn vulnerable. Its main goal is to be an aid for security professionals to test their skills and tools in a legal environment, help web developers better understand the processes of securing web applications and to aid both students & teachers to learn about web application security in a controlled class room environment.
>
> https://github.com/digininja/DVWA

[DVWA](https://github.com/digininja/DVWA) has an official Docker image available at [Dockerhub](https://hub.docker.com/r/vulnerables/web-dvwa/), but at this point they are not producing an image from the current code base.

HUGE THANK YOU TO [cytopia](https://hub.docker.com/r/cytopia/dvwa) who built a docker compose version of latest DVWA. For our uses, it's a little bit heavy and not quickly accessible (still needs database initialization) and is multiple images. We wanted something that was a bit more simple to run and use instantly. This image work is based upon work they have done!


We publish an amd64, arm64, and arm/v7 version of this image weekly. If you want a *NOW* up-to-date version, you can use the here provided Dockerfile. The images are built every Sunday night or when we make tweaks to this repository and are pushed to [Dockehub](https://hub.docker.com/r/kaakaww/dvwa-docker).

**Available Architectures:**  `amd64`, `arm64`, `arm/v7`

## :whale: Available Docker image versions

[![](https://img.shields.io/docker/pulls/kaakaww/dvwa-docker.svg)](https://hub.docker.com/r/kaakaww/dvwa-docker)
[![Docker](https://badgen.net/badge/icon/:latest?icon=docker&label=kaakaaw/dvwa-docker)](https://hub.docker.com/r/kaakaww/dvwa-docker)

#### Rolling releases

The following Docker image tags are rolling releases and are built and updated every Sunday.

[![weekly](https://github.com/kaakaww/dvwa-docker/actions/workflows/weekly-build-and-pub.yml/badge.svg)](https://github.com/kaakaww/dvwa-docker/actions/workflows/weekly-build-and-pub.yml)


| Docker Tag            | Git Ref | PHP | Available Architectures                      |
|-----------------------|---------|-----|----------------------------------------------|
| **`latest`**          | main     | 8.1 | `amd64`, `arm64`, `arm/v7` |




## :tada: Install
Docker/Podman Run In forground
```bash
docker run --rm -it -p 8080:80 kaakaww/dvwa-docker:latest

```
at this point you can use DVWA by accessing https://localhost:8080 or

Clone repository from GitHub:
```bash
git clone https://github.com/kaakaww/dvwa-docker
```



## :zap: Start
Inside the cloned repository (`docker-dvwa/` directory):
```bash
docker build . -t docker-dvwa
docker run -rm -p 8080:80 docker-dvwa
```



## :no_entry_sign: Stop
Inside the cloned repository (`dvwa-docker/` directory):
```bash
docker stop docker-dvwa
```



## :computer: Usage

After running `docker run` you can access DVWA in your browser via:

* Url: http://localhost:8080
* User: `admin`
* Pass: `password`



## :star: Features

* :whale: - Works out of the box on Linux, MacOS and Windows via Docker
* :repeat: - Docker images are [updated every Sunday](https://hub.docker.com/r/kaakaww/dvwa-docker) against [DVWA](https://github.com/digininja/DVWA) main branch
* :open_file_folder: - Bundles [Adminer](https://www.adminer.org/) to inspect the database



## :wrench: Configuration

This setup allows you to configure a few settings via the `Dockerfile` file to change settings in your own image.

| Variable             | Default | Settings |
|----------------------|---------|----------|
| `RECAPTCHA_PRIV_KEY` |         | Required to make the captcha module work. (See [FAQ](#bulb-faq) section below) |
| `RECAPTCHA_PUB_KEY`  |         | Required to make the captcha module work. (See [FAQ](#bulb-faq) section below) |
| `PHP_DISPLAY_ERRORS` | `0`     | Set to `1` to display PHP errors (if you want a really easy mode) |

The following `Dockerfile` file variables are default settings and their values can also be changed from within the web interface:

| Variable         | Default | Settings |
|------------------|---------|----------|
| `SECURITY_LEVEL` | `low`   | Adjust the difficulty level for the challenges<sup>[1]</sup><br/> (`low`, `medium`, `high` or `impossible`) |
| `PHPIDS_ENABLED` | `0`     | Set to `1` to enable PHP WAF/IDS<sup>[2]</sup> (off by default) |
| `PHPIDS_VERBOSE` | `0`     | Set to `1` to display WAF/IDS reasons for blocked requests |

> <sup>[1]</sup> For the `SECURITY_LEVEL` changes to take effect, you will have to clear your cookies. Alternatively change it in the web interface.<br/>
> <sup>[2]</sup> WAF (Web Application Firewall) / IDS (Intrusion Detection System)


## :bulb: FAQ



<details><summary><strong>Q:</strong> How can I run DVWA with a different PHP version?</summary>
<p><br/>
Changing the base reference in your own version of this Dockerfile is possible. Change `from php:8.1-apache` to the version you desire and build the image:<br/>
</details>



<details><summary><strong>Q:</strong> How can I reset the database and start fresh?</summary>
<p><br/>
Hit the reset database button in DVWA OR rebuild the docker container. Either with set the database fresh.<br/>

</p>
</details>



<details><summary><strong>Q:</strong> How can I view Apache access or error log files?</summary>
<p><br/>
Log files are piped to <i>stderr</i> from the Docker container and you can view them via:<br/>

```bash
docker attach <container-id|container-name>
```
</p>
</details>



<details><summary><strong>Q:</strong> How can I get a shell on the web server container?</summary>
<p><br/>
  <strong><img class="emoji" alt="warning" height="20" width="20" src="https://github.githubassets.com/images/icons/emoji/unicode/26a0.png"> Note:</strong> Doing so is basically cheating, you are supposed to gain access to the machine via exploitation.<br/><br/>
You can enter the running web server container as root via:<br/>

```bash
docker exec -it <container-id|container-name> /bin/bash
```
</p>
</details>



<details><summary><strong>Q:</strong> How do I setup the reCAPTCHA key?</summary>
<p><br/>
  Go to <a href="https://www.google.com/recaptcha/admin">https://www.google.com/recaptcha/admin</a> and generate your captcha as shown below:<br/>
  <ul>
   <li>Ensure to choose <code>reCAPTCHA v2</code></li>
   <li>Ensure to add <i>all</i> domains you plan on using</li>
  </ul>
  <a href="doc/captcha-01.png"><img src="doc/captcha-01-thumb.png" /></a>
  <ul>
   <li>Add <code>SITE KEY</code> to the <code>RECAPTCHA_PUB_KEY</code> variable in your <code>Dockerfile</code> file</li>
   <li>Add <code>SECRET KEY</code> to the <code>RECAPTCHA_PRIV_KEY</code> variable in your <code>Dockerfile</code> file</li>
  </ul>
  <a href="doc/captcha-02.png"><img src="doc/captcha-02-thumb.png" /></a>
</p>
</details>



<details><summary><strong>Q:</strong> How can I access/view the MySQL database?</summary>
<p><br/>
  <strong><img class="emoji" alt="warning" height="20" width="20" src="https://github.githubassets.com/images/icons/emoji/unicode/26a0.png"> Note:</strong> Doing so is basically cheating, but if you really need to, you can do so.<br/><br/>
  This Docker image bundles <a href="https://www.adminer.org/">Adminer</a> (a PHP web interace similar to phpMyAdmin) and you can access it here: <a href="http://localhost:8080/adminer.php">http://localhost:8080/adminer.php</a><br/>
  <ul>
   <li><strong>Server:</strong> <code>127.0.0.1</code></li>
   <li><strong>Username:</strong> <code>dvwa</code></li>
   <li><strong>Password:</strong> <code>p@ssw0rd</code></li>
  </ul>
  <img src="doc/adminer.png" />
</p>
</details>



<details><summary><strong>Q:</strong> How can I build the Docker image locally?</summary>
<p><br/>
To build or rebuild the Docker image against new updates in <a href="https://github.com/digininja/DVWA">DVWA master branch</a>, simply do the following:<br/>

```bash
# This is building the image for the default PHP version
docker build -t <name-of-image> .
```
</p>
</details>

## :page_facing_up: License

**[MIT License](LICENSE.md)**
