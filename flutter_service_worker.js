'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "31598cd3556349cdbb0fd35f3401722a",
"version.json": "37c30b79e82b0015bc413e53d7370eed",
"index.html": "0622556746cd2a73895834a71168326a",
"/": "0622556746cd2a73895834a71168326a",
"main.dart.js": "450cf9f9f57f2e1fc980837a97cd8372",
"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"manifest.json": "ea1838a8b3c54e1c84965aeae510371a",
".git/config": "2462f9d97419065a25632b098ac60a76",
".git/objects/59/fbd3b4df03645593d7f17c99a7c7c8fe2963f5": "bd8f7220c382c923adfd8fa5675c470a",
".git/objects/92/cfeddcb22d6615b7325b00a58093926c54cfff": "dcf4ff338baa187f835cb8efea5069d8",
".git/objects/03/4001405037ec6828020647e6d4aad700d56fce": "97a102f2e49c26b56d960214c480c5a3",
".git/objects/05/58bf7347b99990fbf8317369dee770fc754e4b": "34f45578068aa2f89e0514b321ccff47",
".git/objects/a3/ab8de3bd18f024f629419df70fbb6485b61a2e": "25d1a1af4688ca79646f3f49574a5af6",
".git/objects/df/2acb3ec4b649b898f80ae0f25b787cce972e2d": "3513329829ea5a36971599b693348b08",
".git/objects/f3/fffc0ab96b70e079fc3cf42ed81cf716f64e37": "00aff23878737db2f5b68953ac253f0e",
".git/objects/ee/398167fa3d4c99e6190fca8f9d80d49338e26f": "8266581d56c0bc4a02f566be764c03b0",
".git/objects/fd/b8f28835c5ffd077035452b37c68f3b923f785": "64fa94a43e1b30a7b8d410d913d6fd04",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/e3/331a9804578da3cf92e581caa255d6a94cad83": "89fe225dbb19e5b4bcb23ce6b1cc2db2",
".git/objects/c6/06caa16378473a4bb9e8807b6f43e69acf30ad": "ed187e1b169337b5fbbce611844136c6",
".git/objects/ec/361605e9e785c47c62dd46a67f9c352731226b": "d1eafaea77b21719d7c450bcf18236d6",
".git/objects/27/a297abdda86a3cbc2d04f0036af1e62ae008c7": "51d74211c02d96c368704b99da4022d5",
".git/objects/7c/d9d9674681e5306200f968d66781d2f8a6de89": "4e9cc06d4eca835294fda99044e91fdc",
".git/objects/73/7f149c855c9ccd61a5e24ce64783eaf921c709": "1d813736c393435d016c1bfc46a6a3a6",
".git/objects/80/870ff358124c85fa19dfbec68ebf08bf00e802": "f7dbbdd2d865dfdecdfcd76ae87b6c29",
".git/objects/17/26913ef8e7c4f203d4727c66b4b8ca1345c5ba": "cdec7c3b3c097696f006c3e98345f442",
".git/objects/7b/3ffa47ce2424741075db957f0b5deea164d4ad": "8b23055ccd8c3ba51845bcccb159d636",
".git/objects/7e/6f46d8177401df0d9dc93cc2e89061f90a89d8": "6737e8f0125c1b47f692c7fa87c14a1b",
".git/objects/19/1ef9149a4a9b53ea805019a38602aef9492165": "ec670788ea0ba4efd593571c2a978094",
".git/objects/21/ef7b138ed2c189b7a0b02980209457cae8cb43": "0d36ea56fbb83a5ab556ee4840abc9b1",
".git/objects/9f/21cf168d2eee0f51dc71a67ea2bdaa6c6b9aab": "3d4f14e7ee0518488db01da62112ed6a",
".git/objects/9f/f18e396db5a9369a5e60f73867fc8d0a695e99": "11523b35ead4969b7cba1e0d14999f24",
".git/objects/38/a5007aa25477a87d48345570a0e9c8183bc188": "3a837a9fe80804ea629c6c17e58193e3",
".git/objects/36/caec92cad58e82499c89812f37952a22a1b3d8": "84cce28483f1b8922934e00c2d6a50de",
".git/objects/09/831c18f2c645193b94fe2289f6b446de739174": "c747d533eb090074f6e4e9946f0d8397",
".git/objects/09/3ddc308e86646552884701f063a3df4ff4c825": "e2f577b3ee820737c34352a2b6a5ad97",
".git/objects/96/08d45d3d49c46dcb8650e9f68eef7822bead50": "54901f59cfb1ef04263b1b76826a8a4a",
".git/objects/3a/f01313d33d6231437ccb0bf98060206d45721b": "86ced6b3187a3071b83ddf4cea84dfda",
".git/objects/6d/5f0fdc7ccbdf7d01fc607eb818f81a0165627e": "2b2403c52cb620129b4bbc62f12abd57",
".git/objects/01/8eacb940fa295ae8025d3df4db23aaeec598e5": "20b0c82edfb05b90975b0aee39bdf6db",
".git/objects/97/8a4d89de1d1e20408919ec3f54f9bba275d66f": "dbaa9c6711faa6123b43ef2573bc1457",
".git/objects/63/6931bcaa0ab4c3ff63c22d54be8c048340177b": "8cc9c6021cbd64a862e0e47758619fb7",
".git/objects/90/0716294081ecb7ae3dbbc286d6b9e4b546bbc4": "182df7989a3acb4663b391cd48387269",
".git/objects/bf/75949a37c57dcf05385d31038502329d965572": "96425c2c8e2b764fbddddb0efc33b2d3",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d4/bceb67fac37f02215161a10d7ab45ae0843004": "a7f919331b936a27b993381ad740af71",
".git/objects/b1/5ad935a6a00c2433c7fadad53602c1d0324365": "8f96f41fe1f2721c9e97d75caa004410",
".git/objects/b1/afd5429fbe3cc7a88b89f454006eb7b018849a": "e4c2e016668208ba57348269fcb46d7b",
".git/objects/d2/e35ba7310f6f04f378584211e97021dcf55b9d": "b729ba5113dde46ac1a0d87e57536e6b",
".git/objects/af/31ef4d98c006d9ada76f407195ad20570cc8e1": "a9d4d1360c77d67b4bb052383a3bdfd9",
".git/objects/af/1713b6fd0f8d3bbe5d3be3edb7a17043c50bef": "ab5c20cf51c2e41d620194c5ec740471",
".git/objects/de/7329f48934e5b3df485653acf20843bdea6423": "edfc9ad5a87907821bbcf136a785c4f2",
".git/objects/c3/e81f822689e3b8c05262eec63e4769e0dea74c": "8c6432dca0ea3fdc0d215dcc05d00a66",
".git/objects/e1/9f53a1024da5b0a17312990aba99bdda6af1f8": "6ff062afb957a061ee34e03759aa93c5",
".git/objects/f0/8c5b142781bafe751298087191f594b36c082c": "0e5de839130b2f42e348aecae0f4aee0",
".git/objects/fa/55ab00813adcd302774e1ed7d9713bcc322700": "c5381cc2942c1404ae8368b0758291bb",
".git/objects/f1/9b9bb207811fdb32db07169c851611b79fedf1": "8bdb3322009fdfc42670e0413521e89c",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/2d/fcdbe9f2df0332cee24295b9c0a4cdbf2478b7": "b40637ed7a305a7a7296f4f96b139cc1",
".git/objects/4f/346c3e43f95e778d7cef3cb6ceede9cd2bf1c8": "99981890f1649c8ef95c28d9e5a27d4e",
".git/objects/2e/9216e2fe11b86a3b3455762e9c3473740c87f3": "9e16efe0bf517df056e9e774277e6ef3",
".git/HEAD": "5ab7a4355e4c959b0c5c008f202f51ec",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "1e4b9359f9b22f9d2a7e03324f97b664",
".git/logs/refs/heads/gh-pages": "1e4b9359f9b22f9d2a7e03324f97b664",
".git/logs/refs/remotes/origin/gh-pages": "205eb987b52a580f40fc1861da380686",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/refs/heads/gh-pages": "22969448eeecc6c37ad1f3ea28d62945",
".git/refs/remotes/origin/gh-pages": "22969448eeecc6c37ad1f3ea28d62945",
".git/index": "1215ea5b83ba028f786816fc918471ec",
".git/COMMIT_EDITMSG": "34e0338029867e989dd4d5c0750e2f60",
"assets/AssetManifest.json": "a5aac35c76781e03b7cefb8890fd7c54",
"assets/NOTICES": "2c6ffb9836a38d482c45ed5fddcd1aba",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "b92a47e116c891daaa7fead69f28803d",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "5e6081f14140489da2b1194ecfde24b3",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "13790266e7995fbff84804234b6984ee",
"assets/fonts/MaterialIcons-Regular.otf": "f2118708ae87cae7c635727073f52553",
"assets/assets/logo/user.png": "ba2dd08740f9a0bb70eb8ca6c3614071",
"assets/assets/logo/logo.png": "457c91d4f49e95e2d873cc27b3496b95",
"assets/assets/icons/category.png": "af23197a6a6e5a33cad7eb7bb13ca124",
"assets/assets/icons/telegram.png": "5261fd64187c96fdab1e6677a925966c",
"assets/assets/icons/store.png": "a4b634e736ccf19ce0821df61c4a945c",
"assets/assets/icons/emptyitem.png": "41b7d990221881d4f3b5d7811507a8f7",
"assets/assets/icons/galochka.png": "c006667b7e46de2aedb445134fb296ea",
"assets/assets/icons/information.png": "7bf3cbfe4784de56326ec8826090deb1",
"assets/assets/icons/admin.png": "6f3ac4c3ceffd879cf9ef8205b62dd5c",
"assets/assets/icons/Group%2520343.svg": "5ce1df6f7545a03d5e0b593dda7ceab3",
"assets/assets/onboarding/onboarding3.png": "1b1088361d3a3d52b4ac7fca4d0ac0a1",
"assets/assets/onboarding/onboarding2.png": "6337ecbebdde38872cfbbae87c2c3697",
"assets/assets/onboarding/onboarding.png": "a18694203059568ac577efdd7a9e7e58",
"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
