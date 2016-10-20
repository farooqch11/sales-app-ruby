# PushVendor

PushVendor is an open source point of sale system built with Ruby on Rails and Twitter Bootstrap. This was originally a prototype for a commercial offering that never materialized. I'm in the process of cleaning it up and adding tests. Pull requests welcome.


## Getting Started

```
git clone https://github.com/websitescenes/pushvendor.git
```

```
cd pushvendor
```

```
bundle install
```

```
bundle exec guard
```

## Database default data set

```bash
bundle exec rake pushvendor:load_default_data
```

visit: localhost:3000/

Default Credentials: admin, password


## Online Demo (May not be current)

Demo Available @ demo.pushvendor.com

## To-do

* rspec tests for controllers



## Contributing

* Fork it.
* Create a branch (git checkout -b branch-name)
* Commit your changes
* Push to the branch (git push origin branch-name)
* Create a pull request with description from your branch into develop


## Comments

This project is based off of an early prototype that never went into production. It is not suitable for actual deployment in its current state.

--------

The MIT License (MIT)

Copyright (c) 2014,2016 Hunt Burdick

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
