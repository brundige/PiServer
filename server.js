const express = require('express');
const os = require('os');

const app = express();
const hostname = '0.0.0.0';
const port = 3000;

// Serve static files from the 'public' directory
app.use(express.static('public'));

app.listen(port, hostname, () => {
  console.log(`Server running. Access it from another device on the same network.`);

  const interfaces = os.networkInterfaces();
  for (const name of Object.keys(interfaces)) {
    for (const iface of interfaces[name]) {
      if ('IPv4' !== iface.family || iface.internal !== false) {
        continue;
      }
      console.log(`- http://${iface.address}:${port}`);
    }
  }
});