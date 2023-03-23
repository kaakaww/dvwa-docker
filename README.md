# Dockerized DVWA

**[Install](#tada-install)** |
**[Start](#zap-start)** |
**[Stop](#no_entry_sign-stop)** |
**[Usage](#computer-usage)** |
**[Features](#star-features)** |
**[Configuration](#wrench-configuration)** |
**[Capture the flag](#pirate_flag-capture-the-flag)** |
**[Tools](#gear-tools)** |
**[FAQ](#bulb-faq)** |


[![Tag](https://img.shields.io/github/tag/kaakaww/dvwa-docker.svg)](https://github.com/cytopia/docker-dvwa/releases)
[![build](https://github.com/kaakaww/dvwa-docker/workflows/build/badge.svg)](https://github.com/cytopia/docker-dvwa/actions?query=workflow%3Abuild)
[![nightly](https://github.com/kaakaww/dvwa-docker/workflows/nightly/badge.svg)](https://github.com/cytopia/docker-dvwa/actions?query=workflow%3Anightly)
[![](https://img.shields.io/docker/pulls/kaakaww/dvwa-docker.svg)](https://hub.docker.com/r/cytopia/dvwa)
[![](https://img.shields.io/badge/github-kaakaww%2Fdvwa--docker-red.svg)](https://github.com/cytopia/docker-dvwa "github.com/cytopia/docker-dvwa")
[![License](https://img.shields.io/badge/license-MIT-%233DA639.svg)](https://opensource.org/licenses/MIT)

> Damn Vulnerable Web Application (DVWA) is a PHP/MySQL web application that is damn vulnerable. Its main goal is to be an aid for security professionals to test their skills and tools in a legal environment, help web developers better understand the processes of securing web applications and to aid both students & teachers to learn about web application security in a controlled class room environment.
>
> https://github.com/digininja/DVWA

[DVWA](https://github.com/digininja/DVWA) has an official Docker image available at [Dockerhub](https://hub.docker.com/r/vulnerables/web-dvwa/), however by the time of writing this image did not receive any recent updates.

HUGE THANK YOU TO [cytopia](https://hub.docker.com/r/cytopia/dvwa) who built a docker compose version of latest DVWA but it's a little bit heavy and not quickly acccessable (still needs database initialization) and is multile images. We wanted something that was a bit more simple to run and use instantly and this image work is based upon.


If you need an always up-to-date version or **`arm64`** images, you can use the here provided Dockerfile. The image is built every time the [DVWA](https://github.com/digininja/DVWA) master branch receives an update and pushed to [Dockehub](https://hub.docker.com/r/kaakaww/dvwa-docker).

**Available Architectures:**  `amd64`, `arm64`

## :whale: Available Docker image versions

[![](https://img.shields.io/docker/pulls/kaakaww/dvwa-docker.svg)](https://hub.docker.com/r/kaakaww/dvwa-docker)
[![Docker](https://badgen.net/badge/icon/:latest?icon=docker&label=kaakaww/dvwa-docker)](https://hub.docker.com/r/kaakaww/dvwa-docker)

#### Rolling releases

The following Docker image tags are rolling releases and are built and updated every night.

[![nightly](https://github.com/cytopia/docker-dvwa/workflows/nightly/badge.svg)](https://github.com/cytopia/docker-dvwa/actions?query=workflow%3Anightly)


| Docker Tag            | Git Ref      | PHP         | Available Architectures                      |
|-----------------------|--------------|-------------|----------------------------------------------|
| **`latest`**          | master       | latest      | `amd64`, `arm64` |
| `php-8.1`             | master       | **`8.1`**   | `amd64`, `arm64` |



## :tada: Install
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
Inside the cloned repository (`docker-dvwa/` directory):
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
* :repeat: - Docker images are [updated every night](https://hub.docker.com/r/cytopia/dvwa) against [DVWA](https://github.com/digininja/DVWA) master branch
* :open_file_folder: - Bundles [Adminer](https://www.adminer.org/) to inspect the database



## :wrench: Configuration

This setup allows you to configure a few settings via the `.env` file.

| Variable             | Default | Settings |
|----------------------|---------|----------|
| `RECAPTCHA_PRIV_KEY` |         | Required to make the captcha module work. (See [FAQ](#bulb-faq) section below) |
| `RECAPTCHA_PUB_KEY`  |         | Required to make the captcha module work. (See [FAQ](#bulb-faq) section below) |
| `PHP_DISPLAY_ERRORS` | `0`     | Set to `1` to display PHP errors (if you want a really easy mode) |

The following `.env` file variables are default settings and their values can also be changed from within the web interface:

| Variable         | Default  | Settings |
|------------------|----------|----------|
| `SECURITY_LEVEL` | `medium` | Adjust the difficulty level for the challenges<sup>[1]</sup><br/> (`low`, `medium`, `high` or `impossible`) |
| `PHPIDS_ENABLED` | `0`      | Set to `1` to enable PHP WAF/IDS<sup>[2]</sup> (off by default) |
| `PHPIDS_VERBOSE` | `0`      | Set to `1` to display WAF/IDS reasons for blocked requests |

> <sup>[1]</sup> For the `SECURITY_LEVEL` changes to take effect, you will have to clear your cookies. Alternatively change it in the web interface.<br/>
> <sup>[2]</sup> WAF (Web Application Firewall) / IDS (Intrusion Detection System)


Let me know on :bird: [Twitter](https://twitter.com/everythingcli) if you've solved them and how easy/difficult they were.



## :gear: Tools

The DVWA Docker image contains the following tools assisting you in solving the challenges and also allowing you to gain access via reverse shells.

* `bash`
* `netcat`
* `ping`
* `sudo`
* `telnet`
* `python3`



## :bulb: FAQ

<details><summary><strong>Q:</strong> I want to proxy through <a href="https://portswigger.net/burp">BurpSuite</a>, but it does not work on <code>localhost</code> or <code>127.0.0.1</code>.</summary>
<p><br/>
Browsers ususally bypass <code>localhost</code> or <code>127.0.0.1</code> for proxy traffic. One solution is to add an alternative hostname to <code>/etc/hosts</code> and access the application through that.<br/><br/>
<code>/etc/hosts</code>:

```bash
127.0.0.1  dvwa
```

Then use <a href="http://dvwa:8000">http://dvwa:8000</a> in your browser.
</p>
</details>



<details><summary><strong>Q:</strong> How can I run DVWA with a different PHP version?</summary>
<p><br/>
The here provided Docker images are built against all common PHP versions and you can easily select your version of choice in the <a href="https://github.com/cytopia/docker-dvwa/blob/master/.env-example#L1">.env</a> prior startup. To do so, just uncomment the version of choice and restart the Docker Compose stack:<br/>
<code>.env</code>

```bash
# PHP VERSION
# -----------
# Uncomment one of the PHP versions you want to use for DVWA
#PHP_VERSION=5.6
#PHP_VERSION=7.0
#PHP_VERSION=7.1
#PHP_VERSION=7.2
#PHP_VERSION=7.3
#PHP_VERSION=7.4
#PHP_VERSION=8.0
PHP_VERSION=8.1
```
</p>
</details>



<details><summary><strong>Q:</strong> How can I reset the database and start fresh?</summary>
<p><br/>
The database uses a Docker volume and you can simply remove it via:<br/>

```bash
# the command below will stop all running container,
# remove their state and delete the MySQL docker volume.
make reset
```
</p>
</details>



<details><summary><strong>Q:</strong> How can I view Apache access or error log files?</summary>
<p><br/>
Log files are piped to <i>stderr</i> from the Docker container and you can view them via:<br/>

```bash
make logs
```
</p>
</details>



<details><summary><strong>Q:</strong> How can I get a shell on the web server container?</summary>
<p><br/>
  <strong><img class="emoji" alt="warning" height="20" width="20" src="https://github.githubassets.com/images/icons/emoji/unicode/26a0.png"> Note:</strong> Doing so is basically cheating, you are supposed to gain access to the machine via exploitation.<br/><br/>
You can enter the running web server container as root via:<br/>

```bash
make enter
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
   <li>Add <code>SITE KEY</code> to the <code>RECAPTCHA_PUB_KEY</code> variable in your <code>.env</code> file</li>
   <li>Add <code>SECRET KEY</code> to the <code>RECAPTCHA_PRIV_KEY</code> variable in your <code>.env</code> file</li>
  </ul>
  <a href="doc/captcha-02.png"><img src="doc/captcha-02-thumb.png" /></a>
</p>
</details>



<details><summary><strong>Q:</strong> How can I access/view the MySQL database?</summary>
<p><br/>
  <strong><img class="emoji" alt="warning" height="20" width="20" src="https://github.githubassets.com/images/icons/emoji/unicode/26a0.png"> Note:</strong> Doing so is basically cheating, but if you really need to, you can do so.<br/><br/>
  This Docker image bundles <a href="https://www.adminer.org/">Adminer</a> (a PHP web interace similar to phpMyAdmin) and you can access it here: <a href="http://localhost:8000/adminer.php">http://localhost:8000/adminer.php</a><br/>
  <ul>
   <li><strong>Server:</strong> <code>dvwa_db</code></li>
   <li><strong>Username:</strong> <code>root</code></li>
   <li><strong>Password:</strong> <code>rootpass</code></li>
  </ul>
  <img src="doc/adminer.png" />
</p>
</details>



<details><summary><strong>Q:</strong> How can I build the Docker image locally?</summary>
<p><br/>
To build or rebuild the Docker image against new updates in <a href="https://github.com/digininja/DVWA">DVWA master branch</a>, simply do the following:<br/>

```bash
# This is builing the image for the default PHP version
make rebuild

# This is building the image with PHP 8.0
make rebuild VERSION=8.0

# Rebuild PHP 8.1 for arm64 platform
make rebuild VERSION=8.0 ARCH=linux/arm64
```
</p>
</details>











## :page_facing_up: License

**[MIT License](LICENSE.md)**

Copyright (c) 2021 **[cytopia](https://github.com/cytopia)**
