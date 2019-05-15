# GitHub issue あつめ

[![CircleCI](https://circleci.com/gh/hayato-yamashita/github-issue-atsume.svg?style=svg&circle-token=9ab9424cc15adf7e709b187e5ed1375af6f453ca)](https://circleci.com/gh/hayato-yamashita/github-issue-atsume)

GitHub の issue をあつめます。

## Introduction

```bash
docker-compose build
docker-compose run --rm web bin/setup
```

## Usage

### CLI

```bash
docker-compose run --rm web bin/rake rails_issues:puts_csv
```

<details>
<summary>Response example</summary>

```csv
Exclude mailer preview classes,Because mailer preview classes don't follow namesp,https://github.com/rails/rails/pull/36256
Remove SQLite savepoint suppor,Spotted when reviewing https://github.com/rails/ra,https://github.com/rails/rails/pull/36255
Use a single term instead of a,"Fixes #36233.

I agree with the sentiment behind",https://github.com/rails/rails/pull/36254
[ci skip] Clarity in the upgra,"`purpose` is not a known entity, `purpose metadata",https://github.com/rails/rails/pull/36245
Update documentation to explai,Closes https://github.com/rails/rails/issues/36229,https://github.com/rails/rails/pull/36240
Fix database loading when ERB ,*sigh* this seems like the never ending bug. I don,https://github.com/rails/rails/pull/36237
Fix ArgumentError with Rails 5,"### Steps to reproduce

Save the following code ",https://github.com/rails/rails/issues/36236
ActionText attachments not usi,"There is an inconsistency in ActionText, where att",https://github.com/rails/rails/issues/36235
docs fixup on named route help,4 different phrases are used to describe exactly t,https://github.com/rails/rails/issues/36233
Rails 6 RC1: Migration was not,"### Steps to reproduce
1. Have a Rails 6 RC 1 pro",https://github.com/rails/rails/issues/36232
select column name as alias gi,"### Steps to reproduce
<!-- (Guidelines for creat",https://github.com/rails/rails/issues/36231
Unexpected nested transaction ,"### Steps to reproduce
Raise an `ActiveRecord::Ro",https://github.com/rails/rails/issues/36229
"rails test, console, and gener","### Steps to reproduce
`rails test`, `rails conso",https://github.com/rails/rails/issues/36228
Prevent reading inline attachm,"### Summary

Without this change, `attachments.i",https://github.com/rails/rails/pull/36227
Remove `report-uri` directive ,"This is the continuation of #34704

It updates t",https://github.com/rails/rails/pull/36226
minor grammar fix,"""setup"" is a noun, ""set up"" is the verb phrase",https://github.com/rails/rails/pull/36222
[WIP] add server timing middle,"### Summary

This is a proposal for adding a ser",https://github.com/rails/rails/pull/36220
Interaction Between `autosave`,At GitHub we have an issue that we've determined t,https://github.com/rails/rails/issues/36219
Add Search to guides.rubyonrai,Adding a Search ability to the guides.rubyonrails.,https://github.com/rails/rails/issues/36218
includes(has-many).limit.pluck,When calling `pluck` on a relation that `includes`,https://github.com/rails/rails/issues/36217
Add `Vary: Accept` header when,According to [RFC 7231 7.1.4](https://tools.ietf.o,https://github.com/rails/rails/pull/36213
"tag_option fails with ""gsub!"" ","rails 6.0.0rc1

It seems that tag_option logic i",https://github.com/rails/rails/issues/36212
Fix: ActiveRecord::RecordInval,Fixes https://github.com/rails/rails/issues/35528.,https://github.com/rails/rails/pull/36210
Nested attributes use default ,"### Steps to reproduce
[https://github.com/rails/",https://github.com/rails/rails/issues/36208
ActiveModel numericality valid,"### Steps to reproduce

```ruby
# frozen_string",https://github.com/rails/rails/issues/36207
ActiveRecord::RecordInvalid: V,"### Steps to reproduce
class Post < ApplicationRe",https://github.com/rails/rails/issues/36206
Migrations not namespaced by d,"### Steps to reproduce
- `rails new project5`
- ",https://github.com/rails/rails/issues/36205
manifest.js directly loads all,"### Steps to reproduce
Create a new app using `ra",https://github.com/rails/rails/issues/36204
Added guide for `config.autolo,"### Summary
added a guide for `config.autoloader`",https://github.com/rails/rails/pull/36200
Rails attribute API typecast i,"### Steps to reproduce
```ruby
# frozen_string_l",https://github.com/rails/rails/issues/36199
```
</details>

### Web

```bash
docker-compose up -d
```

```bash
open http://localhost:3000/
```

Display example (by root path)

![top image](https://user-images.githubusercontent.com/12483929/57749991-52e3e480-771b-11e9-8074-a8b12a1bca91.png)
