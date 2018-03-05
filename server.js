const express = require("express");

const app = express();
const port = process.env.PORT || 5000;

const os = require("os");
const hostname = os.hostname();

const gitsha = process.env.GITSHA || "missing environment variable GITSHA";

app.get("/api/info", (req, res) => {
  res.send(
    { 
      hostname: hostname, 
      gitsha: gitsha 
    }
  );
});

app.listen(port, () => console.log(`Listening on port ${port}`));
