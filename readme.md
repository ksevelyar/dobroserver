# Dobroserver [![Code Climate](https://codeclimate.com/github/ksevelyar/dobroserver.png)](https://codeclimate.com/github/ksevelyar/dobroserver) [![Build Status](https://travis-ci.org/ksevelyar/dobroserver.png?branch=master)](https://travis-ci.org/ksevelyar/dobroserver) [![Coverage Status](https://coveralls.io/repos/ksevelyar/dobroserver/badge.png?branch=master)](https://coveralls.io/r/ksevelyar/dobroserver?branch=master)

## Requirements

* Ruby >= 2.0.0
* Imagemagick

## Installation

### Быстрая установка:

```
rake setup:development
```

### Ручная установка

```
cp config/database.yml{.example,}
cp config/config.yml{.example,}
```

```
rake db:create db:migrate db:test:clone
```

Демо записи:

```
rake db:seed
```
