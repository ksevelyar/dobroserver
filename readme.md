# Dobroserver [![Code Climate](https://codeclimate.com/github/ksevelyar/dobroserver.png)](https://codeclimate.com/github/ksevelyar/dobroserver) [![Build Status](https://travis-ci.org/ksevelyar/dobroserver.png?branch=master)](https://travis-ci.org/ksevelyar/dobroserver)
[![](https://raw.githubusercontent.com/ksevelyar/dobroserver/master/screenshots/dobroserver_show.png)](https://raw.githubusercontent.com/ksevelyar/dobroserver/master/screenshots/dobroserver_show.png)

## Requirements

* Ruby >= 2.0.0
* ImageMagick

## Installation

### Быстрая установка:

```
rake setup:development
```

### Ручная установка

```
cp config/database.yml{.example,}
```

```
rake db:create db:migrate db:test:clone
```

Демо записи:

```
rake db:seed
```
