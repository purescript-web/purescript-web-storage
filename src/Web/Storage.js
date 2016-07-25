// Copyright 2016 Ian D. Bollinger
//
// Licensed under the MIT license <LICENSE or
// http://opensource.org/licenses/MIT>. This file may not be copied, modified,
// or distributed except according to those terms.

"use strict";

exports.local = function () {
  return window.localStorage;
};

exports.session = function () {
  return window.sessionStorage;
};

exports.length = function (storage) {
  return function () {
    return storage.length;
  };
};

exports.keyForeign = function (index) {
  return function (storage) {
    return function () {
      return storage.key(index);
    };
  };
};

exports.getItemForeign = function (key) {
  return function (storage) {
    return function () {
      return storage.getItem(key);
    };
  };
};

exports.setItem = function (key) {
  return function (value) {
    return function (storage) {
      return function () {
        storage.setItem(key, value);
      };
    };
  };
};

exports.removeItem = function (key) {
  return function (storage) {
    return function () {
      storage.removeItem(key);
    };
  };
};

exports.clear = function (storage) {
  return function () {
    storage.clear();
  };
};
