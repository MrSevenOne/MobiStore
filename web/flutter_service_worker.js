'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "fd002754228738a81872d9f7dcb45892",
"version.json": "37c30b79e82b0015bc413e53d7370eed",
"index.html": "b347b905d935cf60d543c77b6e0e6d5d",
"/": "b347b905d935cf60d543c77b6e0e6d5d",
"main.dart.js": "7150bf9be7d8db5e5cc31178f580c8a7",
"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "f1d8e6bbac01b46f22d6e43c46eb58cf",
".git/config": "38881ccff4dc4e249623736f3cd97a15",
".git/objects/50/08ddfcf53c02e82d7eee2e57c38e5672ef89f6": "d18c553584a7393b594e374cfe29b727",
".git/objects/6f/a02e28a9f258995f7bae41480982f83100ba05": "22345440c97aa44638fd27e3228b2505",
".git/objects/6f/7921dfd472f1f38d68c22de36975331e80970a": "983b6d111ec32e5f1b10c3d4e9cb8efd",
".git/objects/32/f1864a80be84d1dcb3c4064d461f54b620ac9b": "37008a4350b33abc511fe2d6b71c9bf6",
".git/objects/33/4db9f5e4310debf75b97599b8cd6738d56e38a": "ab5d0a565b03957a4dc6724b62b1934c",
".git/objects/05/5a869f581e5d94cdda24b129075c9c44757e92": "b922c4d40c80cc180e3ff6732e50e9f0",
".git/objects/a3/ab8de3bd18f024f629419df70fbb6485b61a2e": "25d1a1af4688ca79646f3f49574a5af6",
".git/objects/b2/58599401ed156f367d554123545dc3220ca081": "5a719ebfeec7e3e44d6e35bff8c86746",
".git/objects/be/2e63984c5143e23459d9581c2dee697dfc9aed": "97be81e03e90e974f06f40d3d6f52efd",
".git/objects/df/2acb3ec4b649b898f80ae0f25b787cce972e2d": "3513329829ea5a36971599b693348b08",
".git/objects/df/4bdf5c55db216870f5d418d819bf23ee328133": "d69cf079d9ebe1f6915b5d87a47c8642",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/c7/2e527c4cf09d2f7448505b4f73fe228504e6b0": "f5db96829f14b0b1f442500044e4d6cd",
".git/objects/c0/a280bf33f4e10eed4d2e700f5f07ae2538915f": "e1c408bc90bc649a7a597caedaf9cf82",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/e3/ba48aff20cb0ec559988c5ee7b19e443b68db4": "7feca38ac36ba328f42885418481fea6",
".git/objects/e3/331a9804578da3cf92e581caa255d6a94cad83": "89fe225dbb19e5b4bcb23ce6b1cc2db2",
".git/objects/c6/06caa16378473a4bb9e8807b6f43e69acf30ad": "ed187e1b169337b5fbbce611844136c6",
".git/objects/ec/361605e9e785c47c62dd46a67f9c352731226b": "d1eafaea77b21719d7c450bcf18236d6",
".git/objects/27/a297abdda86a3cbc2d04f0036af1e62ae008c7": "51d74211c02d96c368704b99da4022d5",
".git/objects/7c/d9d9674681e5306200f968d66781d2f8a6de89": "4e9cc06d4eca835294fda99044e91fdc",
".git/objects/73/7f149c855c9ccd61a5e24ce64783eaf921c709": "1d813736c393435d016c1bfc46a6a3a6",
".git/objects/17/26913ef8e7c4f203d4727c66b4b8ca1345c5ba": "cdec7c3b3c097696f006c3e98345f442",
".git/objects/7b/3ffa47ce2424741075db957f0b5deea164d4ad": "8b23055ccd8c3ba51845bcccb159d636",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/19/1ef9149a4a9b53ea805019a38602aef9492165": "ec670788ea0ba4efd593571c2a978094",
".git/objects/21/ef7b138ed2c189b7a0b02980209457cae8cb43": "0d36ea56fbb83a5ab556ee4840abc9b1",
".git/objects/43/15d116712c71f029fc834a1cc1008d1a8c0065": "1b94e9f156fed5442d3cd64eedb935c2",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/38/a5007aa25477a87d48345570a0e9c8183bc188": "3a837a9fe80804ea629c6c17e58193e3",
".git/objects/38/53cc35e661bf6fb2c11aab0fd6d20c49259aa9": "5cfe480de8f9c72a88e0202ddf77bcf5",
".git/objects/36/caec92cad58e82499c89812f37952a22a1b3d8": "84cce28483f1b8922934e00c2d6a50de",
".git/objects/09/3ddc308e86646552884701f063a3df4ff4c825": "e2f577b3ee820737c34352a2b6a5ad97",
".git/objects/96/08d45d3d49c46dcb8650e9f68eef7822bead50": "54901f59cfb1ef04263b1b76826a8a4a",
".git/objects/53/c275a0a48f1520422dcadd07989b39660f83a7": "1d355b508876e28ab5d0deac3c615c45",
".git/objects/6d/5f0fdc7ccbdf7d01fc607eb818f81a0165627e": "2b2403c52cb620129b4bbc62f12abd57",
".git/objects/97/8a4d89de1d1e20408919ec3f54f9bba275d66f": "dbaa9c6711faa6123b43ef2573bc1457",
".git/objects/63/6931bcaa0ab4c3ff63c22d54be8c048340177b": "8cc9c6021cbd64a862e0e47758619fb7",
".git/objects/0a/38c7379f59a435bcaf65f38b7b9325e9ef28f4": "ff8d607c518c2e1faf055876b2e68e06",
".git/objects/90/0716294081ecb7ae3dbbc286d6b9e4b546bbc4": "182df7989a3acb4663b391cd48387269",
".git/objects/bf/75949a37c57dcf05385d31038502329d965572": "96425c2c8e2b764fbddddb0efc33b2d3",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/b1/5ad935a6a00c2433c7fadad53602c1d0324365": "8f96f41fe1f2721c9e97d75caa004410",
".git/objects/b1/afd5429fbe3cc7a88b89f454006eb7b018849a": "e4c2e016668208ba57348269fcb46d7b",
".git/objects/d2/e35ba7310f6f04f378584211e97021dcf55b9d": "b729ba5113dde46ac1a0d87e57536e6b",
".git/objects/af/31ef4d98c006d9ada76f407195ad20570cc8e1": "a9d4d1360c77d67b4bb052383a3bdfd9",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/c3/e81f822689e3b8c05262eec63e4769e0dea74c": "8c6432dca0ea3fdc0d215dcc05d00a66",
".git/objects/f0/74fb752138339bde22b1007e4190c20820c477": "7814f02a0021fd510e1892f5d09c6f57",
".git/objects/fa/55ab00813adcd302774e1ed7d9713bcc322700": "c5381cc2942c1404ae8368b0758291bb",
".git/objects/f1/9b9bb207811fdb32db07169c851611b79fedf1": "8bdb3322009fdfc42670e0413521e89c",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/2d/fcdbe9f2df0332cee24295b9c0a4cdbf2478b7": "b40637ed7a305a7a7296f4f96b139cc1",
".git/objects/4f/346c3e43f95e778d7cef3cb6ceede9cd2bf1c8": "99981890f1649c8ef95c28d9e5a27d4e",
".git/objects/82/a15ba02e45f5f4678ef6c6382eba8da38ec96b": "f8371a2040694ee5c0882e85b187387d",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "c0bfb6561b7abe4b50f0daa1198a254c",
".git/logs/refs/heads/main": "c0bfb6561b7abe4b50f0daa1198a254c",
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
".git/refs/heads/main": "d240163056f5c6058df6d232a49f908c",
".git/index": "1394f44ff5e55c8a0cb4baca58121e91",
".git/COMMIT_EDITMSG": "64d42024f1a77ee5e61e4096bdebac78",
"assets/AssetManifest.json": "1e2d4f1d93c9a093efef1c1d47d7a255",
"assets/NOTICES": "71fc1d1521ede7d8070fea6cdf0fdb24",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "3751172d44abf54e4779e71144162e64",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e455ae36d5a3c85421c75361fe30dd30",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "6cb71c2d73a09e28c5538a5f77a84386",
"assets/fonts/MaterialIcons-Regular.otf": "0a7be738ceb66d968a79535bbf6ec52f",
"assets/assets/logo/user.png": "ba2dd08740f9a0bb70eb8ca6c3614071",
"assets/assets/logo/logo.png": "457c91d4f49e95e2d873cc27b3496b95",
"assets/assets/icons/store.png": "a4b634e736ccf19ce0821df61c4a945c",
"assets/assets/icons/emptyitem.png": "41b7d990221881d4f3b5d7811507a8f7",
"assets/assets/icons/galochka.png": "c006667b7e46de2aedb445134fb296ea",
"assets/assets/icons/information.png": "7bf3cbfe4784de56326ec8826090deb1",
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
