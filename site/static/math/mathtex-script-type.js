!(function (e, t) {
  if ("object" == typeof exports && "object" == typeof module)
    module.exports = t(require("katex"));
  else if ("function" == typeof define && define.amd) define(["katex"], t);
  else {
    var r = "object" == typeof exports ? t(require("katex")) : t(e.katex);
    for (var n in r) ("object" == typeof exports ? exports : e)[n] = r[n];
  }
})("undefined" != typeof self ? self : this, function (e) {
  return (function (e) {
    var t = {};
    function r(n) {
      if (t[n]) return t[n].exports;
      var o = (t[n] = { i: n, l: !1, exports: {} });
      return e[n].call(o.exports, o, o.exports, r), (o.l = !0), o.exports;
    }
    return (
      (r.m = e),
      (r.c = t),
      (r.d = function (e, t, n) {
        r.o(e, t) || Object.defineProperty(e, t, { enumerable: !0, get: n });
      }),
      (r.r = function (e) {
        "undefined" != typeof Symbol &&
          Symbol.toStringTag &&
          Object.defineProperty(e, Symbol.toStringTag, { value: "Module" }),
          Object.defineProperty(e, "__esModule", { value: !0 });
      }),
      (r.t = function (e, t) {
        if ((1 & t && (e = r(e)), 8 & t)) return e;
        if (4 & t && "object" == typeof e && e && e.__esModule) return e;
        var n = Object.create(null);
        if (
          (r.r(n),
          Object.defineProperty(n, "default", { enumerable: !0, value: e }),
          2 & t && "string" != typeof e)
        )
          for (var o in e)
            r.d(
              n,
              o,
              function (t) {
                return e[t];
              }.bind(null, o)
            );
        return n;
      }),
      (r.n = function (e) {
        var t =
          e && e.__esModule
            ? function () {
                return e.default;
              }
            : function () {
                return e;
              };
        return r.d(t, "a", t), t;
      }),
      (r.o = function (e, t) {
        return Object.prototype.hasOwnProperty.call(e, t);
      }),
      (r.p = ""),
      r((r.s = 1))
    );
  })([
    function (t, r) {
      t.exports = e;
    },
    function (e, t, r) {
      "use strict";
      r.r(t);
      var n = r(0),
        o = r.n(n),
        u = document.body.getElementsByTagName("script");
      (u = Array.prototype.slice.call(u)).forEach(function (e) {
        if (!e.type || !e.type.match(/math\/tex/i)) return -1;
        var t = null != e.type.match(/mode\s*=\s*display(;|\s|\n|$)/),
          r = document.createElement(t ? "div" : "span");
        r.setAttribute("class", t ? "equation" : "inline-equation");
        try {
          o.a.render(e.text, r, { displayMode: t });
        } catch (t) {
          r.textContent = e.text;
        }
        e.parentNode.replaceChild(r, e);
      });
    },
  ]).default;
});
