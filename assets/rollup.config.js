import svelte from 'rollup-plugin-svelte';
import resolve from '@rollup/plugin-node-resolve';
import commonjs from '@rollup/plugin-commonjs';

import livereload from 'rollup-plugin-livereload';
import { terser } from 'rollup-plugin-terser';

import image from '@rollup/plugin-image';
import copy from 'rollup-plugin-copy';
import autoPreprocess from 'svelte-preprocess';
import postcss from 'rollup-plugin-postcss';

// it's production mode if MIX_ENV is "prod"
const production = process.env.MIX_ENV == 'prod';

export default {
  // main entry point
  input: 'src/main.js',

  // define output path & format and request sourcemaps
  output: {
    sourcemap: true,
    format: 'iife',
    name: 'app',
    file: '../priv/static/js/app.js',
    globals: {
      phoenix: 'phx',
    },
  },

  // define all the plugins we'd like to use
  plugins: [
    // the postcss plugin is used to preprocess css
    // for more info, see: https://www.npmjs.com/package/rollup-plugin-postcss
    postcss(),

    // the svelte plugin converts .svelte files to .js equivalent
    svelte({
      // enable run-time checks when not in production
      dev: !production,
      // the preprocessor plugin allows you to use <style type="scss"> or <script lang="typescript"> inside .svelte files
      // for more info, see: https://www.npmjs.com/package/svelte-preprocess
      preprocess: autoPreprocess(),

      // take css output and write it to priv/static
      css: (css) => {
        css.write('../priv/static/css/app.css');
      },
    }),

    // the resolve plugin resolves modules located in node_modules folder
    resolve({
      // resolve modules that are designed to run in browser
      browser: true,

      // a dependency in node_modules may have svelte inside it's node_modules folder
      // dedupe option prevents bundling those duplicates
      dedupe: ['svelte'],
    }),

    // use commonjs import convention
    commonjs(),

    // Watch the `public` directory and refresh the
    // browser on changes when not in production
    !production && livereload('public'),

    // If we're building for production (npm run build
    // instead of npm run dev), minify
    production && terser(),

    image(),
    copy({
      targets: [{ src: 'static/textures/*', dest: '../priv/static/textures' }],
    }),
  ],

  // don't clear terminal screen after each re-compilation
  watch: {
    clearScreen: false,
  },
};
