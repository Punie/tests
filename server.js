const http = require("http");
const fs = require("fs");
const child_process = require("child_process");
const { join } = require("path");
const chokidar = require("chokidar");

const index = join(__dirname, "index.html");
const elm = join(__dirname, "src/");

child_process.exec("livereload");

const watcher = chokidar.watch(elm);
const make = debounce(() => {
  child_process.exec("make", (error, stdout, stderr) => {
    console.log(stdout.toString());
    console.log(stderr.toString());
  });
}, 1000);

make();

watcher.on("change", () => {
  console.log("Making");
  make();
});

const server = http.createServer(function(_, response) {
  fs.createReadStream(index).pipe(response);
});

server.listen(8001);

function debounce(func, wait, immediate) {
  var timeout;
  return function() {
    var context = this,
      args = arguments;
    var later = function() {
      timeout = null;
      if (!immediate) func.apply(context, args);
    };
    var callNow = immediate && !timeout;
    clearTimeout(timeout);
    timeout = setTimeout(later, wait);
    if (callNow) func.apply(context, args);
  };
}
