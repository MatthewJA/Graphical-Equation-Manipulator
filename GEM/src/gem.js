// Generated by CoffeeScript 1.6.3
/*
Graphical Equation Manipulator

Matthew Alger, based on Buck Shlegeris' pyGEM.
https://github.com/MatthewJA/Graphical-Equation-Manipulator
https://github.com/bshlgrs/pyGEM

Licensed under GPL v3.
*/


(function() {
  require.config({
    baseUrl: "./src",
    paths: {
      jquery: "vendor/jquery-2.1.1.min",
      coffeequate: "vendor/coffeequate.min",
      mathjax: "http://cdn.mathjax.org/mathjax/latest/" + "MathJax.js?config=MML_HTMLorMML.js"
    },
    shim: {
      mathjax: {
        exports: "MathJax",
        init: function() {
          MathJax.Hub.Config({
            config: ["MMLorHTML.js"],
            jax: ["input/MathML", "output/HTML-CSS"],
            extensions: ["mml2jax.js", "MathMenu.js", "MathZoom.js"],
            showMathMenu: false,
            showMathMenuMSIE: false
          });
          MathJax.Hub.Startup.onload();
          return MathJax;
        }
      }
    }
  });

  require(["jquery", "Expression", "render"], function($, Expression, render) {
    return window.gem.loaded = true;
  });

}).call(this);
